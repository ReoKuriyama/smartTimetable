class HomesController < ApplicationController
  before_action :user_has_timetable?
  def index
    @arr = []
    @@timetables.each do |timetable|
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

  private

  def user_has_timetable?
    @@timetables = current_user.school_timetables
    if @@timetables.empty?
      redirect_to scraping_path
    end
  end
end
