class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :render_flash

  def render_flash
    Turbo::StreamsChannel.broadcast_update_to([current_user, :rooms],
                                              target: 'flash_container',
                                              partial: 'shared/flash',
                                              locals: { flash: flash })
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:avatar, :current_password]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end
end
