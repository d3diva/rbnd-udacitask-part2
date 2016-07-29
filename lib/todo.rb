class TodoItem
  include Listable
  attr_accessor :description, :due, :priority, :item_type, :status

  def initialize(item_type, description, options={})
    @item_type = item_type
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
    @status = options[:status] ? @status = options[:status] : @status = false
  end

  # changes priority of the given item
  def toggle_priority(new_priority)
    @priority = new_priority
  end

  # toggles the status of the item
  def update_status
    @status = !@status
  end

  # details of the item
  def details
    format_list_type(@item_type) +
    format_description(@description) + "due: " +
    format_date(due: @due) +
    format_priority(@priority) +
    format_status(@status)
  end
end
