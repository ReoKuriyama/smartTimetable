class HomesController < ApplicationController
  attr_accessor :timetables
  before_action :user_has_timetable?
  def index
    @arr_json = @timetables.to_json.html_safe
  end

  private

  def user_has_timetable?
    @timetables = {}
    c_user_tt = current_user.school_timetables
    @timetables[:spring] = c_user_tt.where(class_type: 0)
    @timetables[:autumn] = c_user_tt.where(class_type: 1)
    # redirect_to edit_user_path(current_user) if @@timetables.empty?
  end
end
