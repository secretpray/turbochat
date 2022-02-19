class ResetAllRoomCacheCounters < ActiveRecord::Migration[7.0]
  def change
    Room.all.each do |room|
     Room.reset_counters(room.id, :favorites)
     end
  end
end
