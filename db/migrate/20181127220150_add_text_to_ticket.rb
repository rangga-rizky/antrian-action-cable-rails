class AddTextToTicket < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :text, :string
  end
end
