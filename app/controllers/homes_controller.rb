class HomesController < ApplicationController
  def index
    timetables = current_user.school_timetables
    @arr = []
    timetables.each do |timetable|
      @time_arr = []
      @time_arr << timetable.class_time
      @time_arr << timetable.class_name
      @time_arr << timetable.class_room
      @time_arr << timetable.professor_name
      @arr << @time_arr
    end
    # 配列をJsonへ変換する
    @arr_json = @arr.to_json.html_safe
  end
end
