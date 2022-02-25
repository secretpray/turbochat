class FavoritesController < ApplicationController
  before_action :set_room
  before_action :set_favorite

  def create
    return if @favorite.present?

    @room.favorite(current_user)
    render_turbo_template
  end

  def destroy
    return unless @favorite.present?

    @room.unfavorite(current_user)
    render_turbo_template
  end

  private

  def set_room
    @room = Room.find_by_title(params[:room_title])
    @room ||= Room.find(params[:id])
  end

  def set_favorite
    @favorite = @room&.favorites.find_by(user: current_user)
  end

  def render_turbo_template
    @room.broadcast_update_to([current_user, :rooms], target: "room_#{@room.id}_favorite_section",
                              partial: 'rooms/favorite_room',
                              locals: {room: @room, user: current_user})
  end
end
