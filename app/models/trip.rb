# frozen_string_literal: true

class Trip < ApplicationRecord
  has_many :trip_locations

  before_validation :assign_status, if: :status_not_present?, on: :create
  enum status: %i[ongoing completed]

  validates_presence_of :status
  validate :right_status, if: :status_changed?, on: :update

  private

  def assign_status
    self.status = 0
  end

  def right_status
    previous_status = status_change[0]
    current_status  = status_change[1]
    if numeric_status(current_status) < numeric_status(previous_status)
      errors.add :status, I18n.t('status_wrong_direction')
      false
    end
    true
  end


  def numeric_status(status)
    self.class.statuses[status].to_i
  end

  def status_not_present?
    status.nil?
  end
end
