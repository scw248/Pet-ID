# frozen_string_literal: true

class Appointment < ApplicationRecord
  validates :date_time, presence: true
  validate :validate_appt
  
  validates :reason_for_visit, presence: true
  validates :reason_for_visit, inclusion: { in: ['Dental', 'Medical Exam', 'Medication Refill', 'New Patient Visit', 'Surgery', 'Wellness Exam', 'Vaccinations'],
  message: "%{value} is not a valid visit reason"}

  validates :vet_provider, presence: true
  belongs_to :user
  belongs_to :vet_provider
  belongs_to :pet

  def self.visit_reasons
    ['Dental', 'Medical Exam', 'Medication Refill', 'New Patient Visit', 'Surgery', 'Wellness Exam', 'Vaccinations']
  end

  private

  def validate_appt
      if date_time < Date.today
          errors.add(:date_time, 'Appointments Must Be Booked At Least One Day in Advance')
      end
  end
end
