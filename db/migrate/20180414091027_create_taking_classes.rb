class CreateTakingClasses < ActiveRecord::Migration[5.0]
  def change
    create_table :taking_classes do |t|
      t.references :user, null: false
      t.references :school_timetable, null: false
      t.timestamps
    end
    add_index :taking_classes, [:user_id, :school_timetable_id]
  end
end
