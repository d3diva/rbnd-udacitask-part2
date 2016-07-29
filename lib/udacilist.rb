class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    options[:title] ? @title = options[:title] : @title = "Untitled List"
    @items = []
    @exist_priorities = ["high", "medium", "low", nil ]
    @item_classes = {"todo"=>TodoItem, "event"=>EventItem, "link"=>LinkItem}
  end

  def priority_notfound(priority)
    raise UdaciListErrors::InvalidPriorityValue, "#{priority} Priority Type Does not exist"
  end

  def item_type_notfound(item_type)
    raise UdaciListErrors::InvalidItemType, "#{item_type} Item Type Does not exist"
  end

  def index_notfound(item_no)
    raise UdaciListErrors::IndexExceedsListSize, "#{item_no} Does not exist"
  end


  # verifies priority if true creates new TodoItem and pushes to items array else raises error
  def priority_exist(priority)
      @exist_priorities.include? priority
  end

  # verifies item_type
  def type_exist(item_type)
      @item_classes.include? item_type
  end

  def continue_add_items(item_type, description, options)
    if priority_exist(options[:priority])
      @items.push @item_classes[item_type].new(item_type, description, options)
    else
      priority_notfound(options[:priority])
    end
  end

  # adds new items
  def add(item_type, description, options={})
    item_type = item_type.downcase
    if type_exist(item_type)
      continue_add_items(item_type, description, options)
    else
      item_type_notfound(item_type)
    end
  end

  # delete item after verifing
  def index_exist(item_no)
    @items.length >= item_no
  end

  def delete_index(item_no)
    @items.delete_at(item_no)
  end

  def delete(item_no)
    item_no = item_no - 1
    index_exist(item_no) ? delete_index(item_no) : index_notfound(item_no)
  end

  # sorts the to be deleted items and deletes if exists
  def multiple_delete(items)
    items.sort.each_with_index {|item, item_no| delete(item - item_no)}
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
    @items.select { |item| item.item_type == item_type }
  end

  def filter(item_type)
    itemlist = item_type_list(item_type) if type_exist(item_type)
    itemlist.empty?? item_type_notfound(item_type) : print_itemlist(itemlist, item_type)
  end

  # changes priority of given todo item
  def change_priority(todo_item, todo_priority)
    @items.each { |item| item.priority = todo_priority if item.description == todo_item }
  end

  # delets completed todo items
  def delete_completed
    todo_item_list = item_type_list("todo")
    todo_item_list.each_with_index { |item, item_no| delete_index(item_no) if item.status == true}
  end

end
