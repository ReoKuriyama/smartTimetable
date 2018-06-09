class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]
  before_action :user_check, only: %i[edit update]
  def edit; end

  def update
    if @user.update(user_params)
      sign_in(@user, bypass: true)
      if Scraping.new(set_password).scrape_timetables == false
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

  def set_password
    args = @user.set_scraping_info
    args[:password] = params[:user][:password]
    args
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
