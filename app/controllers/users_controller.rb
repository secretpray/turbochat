class UsersController < ApplicationController
  before_action :set_user

  def show
    @favorites = @user.favorites
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
