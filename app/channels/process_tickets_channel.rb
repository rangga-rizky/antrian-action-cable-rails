class ProcessTicketsChannel < ApplicationCable::Channel

    def subscribed
        stream_from "process_ticket"
    end

    def unsubscribed
        stop_all_streams
    end
end