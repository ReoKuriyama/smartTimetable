class HomesController < ApplicationController
  attr_accessor :timetables
  before_action :user_has_timetable?
  def index
    @timetables = {}
    @timetables[:spring] = current_user_timetables.where(class_type: 0)
    @timetables[:autumn] = current_user_timetables.where(class_type: 1)
    @arr_json = @timetables.to_json.html_safe
  end

  private

  def current_user_timetables
    current_user.school_timetables
  end

  def current_user_taking?
    current_user.taking_classes.first
  end

  def user_has_timetable?
    redirect_to edit_user_path(current_user) if current_user_taking?.nil?
  end
end
