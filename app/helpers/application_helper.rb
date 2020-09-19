module ApplicationHelper
  def date_time_format(datetime)
    datetime.strftime("%Y-%m-%d %H:%M")
  end
end
