class HomesController < ApplicationController
  before_action :redirect_to_scraping_if_current_user_has_not_timetable, only: %i[index]
  before_action :set_current_user_timetable, only: %i[index]

  include UserTimetableStatus

  def index
    @arr_json = @timetables.to_json.html_safe
  end

  private

  def set_current_user_timetable
    @timetables = {
      spring: current_user.school_timetables.spring,
      autumn: current_user.school_timetables.autumn
    }
  end
end
