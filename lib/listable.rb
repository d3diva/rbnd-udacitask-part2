module Listable
  def format_description(description)
    "#{description}".ljust(30)
  end

  def format_date(options={})
    dates = options[:due] ? options[:due].strftime("%D") : "No due date"
    dates = options[:start_date].strftime("%D") if options[:start_date]
    dates << " -- " + options[:end_date].strftime("%D") if options[:end_date]
    dates = "N/A" if !dates
    return dates
  end
end
