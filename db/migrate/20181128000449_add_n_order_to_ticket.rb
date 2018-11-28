class AddNOrderToTicket < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :ticket_order , :int
  end
end
