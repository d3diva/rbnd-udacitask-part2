class EventItem
  include Listable
  attr_reader :description, :start_date, :end_date, :item_type

  def initialize(item_type, description, options={})
    @description = description
    @item_type = item_type
    @start_date = Chronic.parse(options[:start_date]) if options[:start_date]
    @end_date = Chronic.parse(options[:end_date]) if options[:end_date]
  end

  def details
    format_list_type(@item_type) +
    format_description(@description) +
    "event dates: " +
    format_date(start_date: @start_date, end_date: @end_date)
  end
end
