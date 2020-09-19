class PatientsController < ApplicationController
  before_action :authenticate_patient!
  def dashboard
    @doctors = Doctor.all
    @appointments = current_patient.appointments
  end
end
