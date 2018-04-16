# UserScarpingInformation
class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]
  def edit; end

  def update
    if @user.update(user_params)
      redirect_to edit_user_path(@user)
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
