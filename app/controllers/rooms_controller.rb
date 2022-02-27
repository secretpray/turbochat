class RoomsController < ApplicationController

  def index
    @rooms = Room.common.recent
    @new_room = Room.new
  end

  def favorites
    @rooms = Room.favorited_by(current_user&.email)
    @new_room = Room.new
  end

  def show
    @room = Room.find_by!(title: params[:title])
    @messages = MessageDecorator.decorate_collection(@room.messages.includes(:user))
    @new_message = current_user&.messages&.build(room: @room)
  end

  def create
    return if not_autorize_common? || not_autorize_personal?

    @new_room = Room.new(user: current_user)

    if @new_room.save
      flash.now[:notice] = "Room created!"
      turbo_render_flash(flash)
      @new_room.broadcast_prepend_to :rooms, partial: "rooms/room", locals: { user: current_user, room: @new_room }
    end
  end

  private

  def not_autorize_common?
    unless current_user&.admin? && params.dig(:chat_room).blank?
      flash.now[:alert] = "Not autorized!"
      turbo_render_flash(flash)
      return true
    end
  end

  def not_autorize_personal?
    return params.dig(:chat_room).present?
  end

  def turbo_render_flash(flash)
    Turbo::StreamsChannel.broadcast_update_to([current_user, :rooms], target: 'flash_container', partial: 'shared/flash', locals: { flash: flash })
  end
end
