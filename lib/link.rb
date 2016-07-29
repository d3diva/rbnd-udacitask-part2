class LinkItem
  include Listable
  attr_reader :description, :site_name, :item_type

  def initialize(item_type, url, options={})
    @description = url
    @item_type = item_type
    options[:site_name] ? @site_name = options[:site_name] : get_site_name
  end

  # gets site name with Mechanize
  def get_site_name
    @site_name = Mechanize.new.get(@description).title
  end

  def details
    format_list_type(@item_type) +
    format_description(@description) +
    "site name: " + format_name(@site_name)
  end
end
