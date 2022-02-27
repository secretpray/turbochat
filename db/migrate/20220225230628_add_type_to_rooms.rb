class AddTypeToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :chat_type, :integer, default: 0, limit: 1
  end
end
