class UdaciList
  attr_accessor :title, :items

  def initialize(options={})
    options[:title] ? @title = options[:title] : @title = "Untitled List"
    @items = []
    @itemlist = []
    @delete_completed = []
    @exist_item_types = ["todo", "event", "link"]
    @exist_priorities = ["high", "medium", "low", nil ]
  end

  def priority_notfound(priority)
    raise UdaciListErrors::InvalidPriorityValue, "#{priority} Priority Type Does not exist"
  end

  def item_type_notfound(item_type)
    raise UdaciListErrors::InvalidItemType, "#{item_type} Item Type Does not exist"
  end

  def index_notfound(index)
    raise UdaciListErrors::IndexExceedsListSize, "#{index} Does not exist"
  end


  # verifies priority if true creates new TodoItem and pushes to items array else raises error
  def priority_exist(priority)
      @exist_priorities.include? priority
  end

  def todoitem(item_type, description, status, options)
    if priority_exist(options[:priority])
      @items.push TodoItem.new(item_type, description, status, options)
    else
      priority_notfound(priority)
    end
  end

  # creates new EventItem and pushes to items array
  def eventitem(item_type, description, options)
      @items.push EventItem.new(item_type, description, options)
  end

  # cerates new LinkItem and pushes to items array
  def linkitem(item_type, description, options)
    @items.push LinkItem.new(item_type, description, options)
  end

  # verifies item_type
  def type_exist(item_type)
      @exist_item_types.include? item_type
  end

  # adds new items
  def add(item_type, description, options={})
    item_type = item_type.downcase
    if type_exist(item_type)
      todoitem(item_type, description, status = false, options) if item_type == "todo"
      eventitem(item_type, description, options) if item_type == "event"
      linkitem(item_type, description, options) if item_type == "link"
    else
      item_type_notfound(item_type)
    end
  end

  # delete item after verifing
  def index_exist(index)
    @items.length >= index
  end


  def delete_index(index)
    @items.delete_at(index - 1)
  end

  def delete(index)
    index_exist(index) ? delete_index(index) : index_notfound(index)
  end

  # sorts the to be deleted items and deletes if exists
  def multilpe_delete(items)
    items.sort.each_with_index {|e, index| delete(e - index)}
  end

  # prints all items
  def print_line
    puts "-" * @title.length
  end

  def print_title
    puts @title
  end

  def print_items
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

  def all
    print_line
    print_title
    print_line
    print_items
  end

  # prints items for given item_type
  def print_item_type_header(item_type)
    puts "list of #{item_type}"
  end

  def print_itemlist(itemlist, item_type)
    print_line
    print_item_type_header(item_type)
    print_line
    itemlist.each { |item| puts "#{item.details}"  }
  end

  def item_type_list(item_type)
    @items.each { |item| @itemlist.push item if item.item_type == item_type }
  end

  def filter(item_type)
    item_type_list(item_type) if type_exist(item_type) 
    !@itemlist.empty?? print_itemlist(@itemlist, item_type) : item_type_notfound(item_type)
  end

  # changes priority of given todo item
  def change_priority(todo_item, todo_priority)
    @items.each { |item| item.priority = todo_priority if item.description == todo_item }
  end

  # delets completed todo items - not working
  def delete_completed
    @itemlist = item_type_list("todo")
    @itemlist.each_with_index { |item, index| puts"#{ index}" if item.status == true}
  end

end
