module Listable
  # formated list_type with color
  def format_list_type(item_type)
    if item_type == "link"
      "#{item_type}".ljust(7).colorize(:light_blue)
    elsif  item_type == "event"
      "#{item_type}".ljust(7).colorize(:cyan)
    elsif  item_type == "todo"
      "#{item_type}".ljust(7).colorize(:magenta)
    end
  end

  # formated description
  def format_description(description)
    "#{description}".ljust(30)
  end

  # formated date
  def format_date(options={})
    dates = options[:due] ? options[:due].strftime("%D") : "No due date"
    dates = options[:start_date].strftime("%D") if options[:start_date]
    dates << " -- " + options[:end_date].strftime("%D") if options[:end_date]
    dates = "N/A" if !dates
    return "#{dates}".ljust(12)
  end

  #formated priority with colorize
  def format_priority(priority)
    value = " ⇧".ljust(10).colorize(:red) if priority == "high"
    value = " ⇨".ljust(10).colorize(:yellow) if priority == "medium"
    value = " ⇩".ljust(10).colorize(:green) if priority == "low"
    value = "  ".ljust(10) if !priority
    return "#{value}"#.ljust(10)
  end

  # formated status with colorize
  def format_status(status)
    value = "completed".colorize(:green) if status == true
    value = "pending".colorize(:red) if status == false
    "#{value}".ljust(10)
  end

  #formated site_name
  def format_name(site_name)
    "#{site_name}"
  end
end
