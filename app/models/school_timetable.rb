class SchoolTimetable < ApplicationRecord
  has_many :taking_classes
  has_many :users, through: :taking_classes
end
