module PatientsHelper
  def is_eligible_for_cancel?(appointment)
    Time.zone.now < (appointment.created_at + 1.hour)
  end
end
