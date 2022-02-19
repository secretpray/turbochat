class Favorite < ApplicationRecord
  belongs_to :room, counter_cache: true
  belongs_to :user

  after_create_commit do
    update_favorites_counter
  end

  after_destroy_commit do
    update_favorites_counter
  end

  private

  def update_favorites_counter
    broadcast_update_to :rooms, target: "room_#{self.room.id}_favorites_count", html: html_count
  end

  def html_count
    # logger.debug "---------- Room favorites count: #{count} -----------"
    count = room.favorites_count
    " (in #{count} Favorites)"
  end
end
