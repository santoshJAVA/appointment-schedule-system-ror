class AppointmentsController < ApplicationController
  before_action :authenticate_patient!, only: [:new, :create, :destroy, :show]
  before_action :authenticate_doctor!, only: [:accept_appointment, :reject_appointment]
  before_action :set_appointment, only: [:show, :accept_appointment, :reject_appointment, :destroy]

  def new
    @doctor = Doctor.find_by(id: params[:doctor_id])
    @appointment = Appointment.new
  end

  def show
  end

  def create
    @appointment = current_patient.appointments.build(appointment_params)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept_appointment
    respond_to do |format|
      if @appointment.accepted!
        mail_schedule_time = @appointment.appointment_date - 1.hour
        DoctorMailer.next_appointment_email(@appointment.doctor,@appointment).deliver_later(wait_until: mail_schedule_time)
        PatientMailer.next_appointment_email(@appointment.patient,@appointment).deliver_later(wait_until: mail_schedule_time)
        format.html { redirect_to dashboard_doctors_path, notice: 'Appointment was successfully accepted.' }
      else
        format.html { redirect_to dashboard_doctors_path }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  def reject_appointment
    respond_to do |format|
      if @appointment.rejected!
        format.html { redirect_to dashboard_doctors_path, notice: 'Appointment was rejected.' }
      else
        format.html { redirect_to dashboard_doctors_path }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_patients_path, notice: 'Appointment was successfully cancelled.' }
      format.json { head :no_content }
    end
  end

  private
  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:appointment_date,:doctor_id)
  end
end
