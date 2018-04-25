class AddColumnToSchoolTimetables < ActiveRecord::Migration[5.0]
  def change
    add_column :school_timetables, :class_type, :integer, null: false
  end
end
