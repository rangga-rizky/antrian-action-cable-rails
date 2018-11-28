class TicketsController < ApplicationController
    skip_before_action :verify_authenticity_token  

    def index
        @tickets = Ticket.where(:status => "ISSUED").order('created_at')
    end

    def action
        @ticket = Ticket.find(params[:id])
        if  @ticket.update(status: params[:status])
            ActionCable.server.broadcast 'process_ticket',
            ticket_type: @ticket.ticket_type,  
            text: @ticket.text
            head :ok
        end
    end

    def create
        @ticket = Ticket.new(ticket_params)

        if @ticket.save
            ActionCable.server.broadcast 'print_ticket',
              id: @ticket.id,
              text: @ticket.text,
              created_at: @ticket.created_at,
              ticket_type: @ticket.ticket_type
            render :json => {
                ticketA: getCurrentTicket("A"),
                ticketB: getCurrentTicket("B")
            }
        end

    end

    def displayOnPublic
        @ticketsA = Ticket.where(:ticket_type => "A").where(:status => "PROCESS").order('updated_at DESC').first
        @ticketsB = Ticket.where(:ticket_type => "B").where(:status => "PROCESS").order('updated_at DESC').first
        render "tickets/display_on_public"
    end

    def displayOnClient
        @ticketsA = getCurrentTicket("A")
        @ticketsB = getCurrentTicket("B")
        render "tickets/display_on_client"
    end

    private

    def getCurrentTicket(type)
        ticket = Ticket.where(:ticket_type => type).order('ticket_order DESC').first
        if ticket == nil
            ticket = 1

        else
            ticket = ticket.ticket_order + 1
        end
    end

    def ticket_params
        params.permit(:ticket_order,:ticket_type,:status,:text)
    end
end
