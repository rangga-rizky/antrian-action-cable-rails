class PrintTicketsChannel < ApplicationCable::Channel

    def subscribed
        stream_from "print_ticket"
    end

    def unsubscribed
        stop_all_streams
    end
end