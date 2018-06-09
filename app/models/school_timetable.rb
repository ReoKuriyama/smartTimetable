class SchoolTimetable < ApplicationRecord
  # association
  has_many :taking_classes
  has_many :users, through: :taking_classes

  # validation
  validates :class_time, :class_name, :class_room, :professor_name, :class_type, presence: true

  enum class_type: { spring: 0, autumn: 1 }
end
