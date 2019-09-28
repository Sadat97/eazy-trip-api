class TripLocation < ApplicationRecord
  belongs_to :trip
  validates_presence_of :trip
end
