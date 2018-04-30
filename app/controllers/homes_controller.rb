class HomesController < ApplicationController
  before_action :redirect_to_scraping
  def index
    set_current_user_timetable
    @arr_json = @timetables.to_json.html_safe
  end

  private

  def c_user_timetables
    current_user.school_timetables
  end

  def set_current_user_timetable
    @timetables = {
      spring: c_user_timetables.spring,
      autumn: c_user_timetables.autumn
    }
  end

  def c_user_taking?
    current_user.taking_classes.first
  end

  def redirect_to_scraping
    redirect_to edit_user_path(current_user) unless c_user_taking?
  end
end
