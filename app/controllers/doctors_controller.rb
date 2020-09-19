class DoctorsController < ApplicationController
  before_action :authenticate_doctor!
  def dashboard
    @appointments = current_doctor.appointments.where(status: nil)
  end
end
