class AddFavoritesCountToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :favorites_count, :integer
  end
end
