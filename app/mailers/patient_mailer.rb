class PatientMailer < ApplicationMailer
  helper :application
  def next_appointment_email(patient,appointment)
    @patient = patient
    @appointment = appointment

    mail(to: @patient.email, subject: "You have an appointment!")
  end
end
