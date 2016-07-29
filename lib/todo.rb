class TodoItem
  include Listable
  attr_reader :description, :due, :priority, :item_type

  def initialize(item_type, description, status, options={})
    @item_type = item_type
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
    @status = status
  end

  # changes priority of the given item
  def change(new_priority)
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
