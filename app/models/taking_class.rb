class TakingClass < ApplicationRecord
  belongs_to :user
  belongs_to :school_timetable

  # validation
  validates :user_id, uniqueness: { scope: %i[school_timetable_id] }
end
