class DoctorMailer < ApplicationMailer
  def next_appointment_email(doctor,appointment)
    @doctor = doctor
    @appointment = appointment

    mail(to: @doctor.email, subject: "You have an appointment!")
  end
end
