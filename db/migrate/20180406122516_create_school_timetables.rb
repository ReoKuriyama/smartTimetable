class CreateSchoolTimetables < ActiveRecord::Migration[5.0]
  def change
    create_table :school_timetables do |t|
      t.integer :class_time, null: false, limit: 1
      t.string :class_name, null: false
      t.string :class_room, null: false
      t.string :professor_name, null: false

      t.timestamps
    end
  end
end
