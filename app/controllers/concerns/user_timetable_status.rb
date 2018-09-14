module UserTimetableStatus
  extend ActiveSupport::Concern

  private

  def redirect_to_scraping_if_current_user_has_not_timetable
    redirect_to edit_user_path(current_user) unless current_user.timetable?
  end
end
