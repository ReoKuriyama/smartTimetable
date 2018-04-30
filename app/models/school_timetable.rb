class SchoolTimetable < ApplicationRecord
  has_many :taking_classes
  has_many :users, through: :taking_classes

  enum class_type: { spring: 0, autumn: 1 }
end
