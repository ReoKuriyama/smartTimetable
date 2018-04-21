# UserScarpingInformation
class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]
  def edit; end

  def update
    if @user.update(user_params)
      email = @user.email
      password = params[:user][:password]
      Scraping.get_classes(email, password)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
