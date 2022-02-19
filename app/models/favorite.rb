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
    count = room.favorites_count
    logger.debug "---------- Room favorites count: #{count} -----------"
    # broadcast_update_to :rooms, target: "favorites_counter", partial: 'favorites/count', locals: { count: Comment.count }
  end
end
