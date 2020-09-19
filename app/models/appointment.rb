class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  enum status: [ :accepted, :rejected ]
end
