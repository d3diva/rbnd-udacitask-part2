class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
    verify_priority(@priority) if @priority
  end

  def priority_type_exist(priority)
    priority == "high" || priority == "medium" || priority == "low"
  end

  def priority_type_error(priority)
    puts "#{priority} does not exist"
    #@priority = ""
  end

  def verify_priority(priority)
    priority = priority.downcase
    priority_type_error(priority) if !priority_type_exist(priority)
  end


  #def format_description
  #  "#{@description}".ljust(25)
  #end
  #def format_date
  #  @due ? @due.strftime("%D") : "No due date"
  #end
  #def format_priority
  #  value = " ⇧" if @priority == "high"
  #  value = " ⇨" if @priority == "medium"
  #  value = " ⇩" if @priority == "low"
  #  value = "" if !@priority
  #  return value
  #end
  def details
    format_description(@description) + "due: " +
    format_date(due: @due) +
    format_priority(@priority).to_s
  end
end
