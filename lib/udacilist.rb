class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    options[:title] ? @title = options[:title] : @title = "Untitled List"
    @items = []
  end

  def type_exist(type)
      if type == "todo" || type == "event" || type == "link"
        return true
      else
        raise UdaciListErrors::InvalidItemType, "Item Type Does not exist"
      end
  end

  def todoitem(description, options)
    @items.push TodoItem.new(description, options) 
  end

  def eventitem(description, options)
      @items.push EventItem.new(description, options)
  end

  def linkitem(description, options)
    @items.push LinkItem.new(description, options)
  end

  def add(type, description, options={})
    type = type.downcase
    if type_exist(type)
      todoitem(description, options) if type == "todo"
      eventitem(description, options) if type == "event"
      linkitem(description, options) if type == "link"
    end
  end

  def index_exist(index)
    @items.length >= index
  end

  def index_error(index)
    puts "********** #{index} false ***************"
    raise UdaciListErrors::IndexExceedsListSize, "Does not exist"
  end

  def delete_index(index)
    @items.delete_at(index - 1)
    puts "***************** true **********"
  end

  def delete(index)
    index_exist(index) ? delete_index(index) : index_error(index)
  end

  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
end
