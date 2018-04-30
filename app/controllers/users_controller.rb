# UserScarpingInformation
class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]
  before_action :user_check, only: %i[edit update]
  def edit; end

  def update
    if @user.update(user_params)
      password = params[:user][:password]
      if Scraping.get_classes(@user.email, password, current_user.id) == false
        render :edit
      else
        redirect_to homes_path
      end
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_check
    redirect_to edit_user_path(@user) if params[:id].to_i != @user.id
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
