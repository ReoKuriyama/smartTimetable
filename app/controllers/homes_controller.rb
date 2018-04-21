class HomesController < ApplicationController
  before_action :user_has_timetable?
  def index
    @arr = []
    @@timetables.each do |timetable|
      @class_arr = []
      @class_arr << timetable.class_time
      @class_arr << timetable.class_name
      @class_arr << timetable.class_room
      @class_arr << timetable.professor_name
      @arr << @class_arr
    end
    # array to Json
    @arr_json = @arr.to_json.html_safe
  end

  private

  def user_has_timetable?
    @@timetables = current_user.school_timetables
    # redirect_to edit_user_path(current_user) if @@timetables.empty?
  end
end
