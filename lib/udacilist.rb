class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
  end
  
  def add(type, description, options={})
    type = type.downcase
    if !["todo", "event", "link"].include?(type)
      raise UdaciListErrors::InvalidItemType, "'#{type}' is not a valid type."
    end
    if !["high", "medium", "low", nil].include?(options[:priority])
      raise UdaciListErrors::InvalidPriorityValue, "'#{options[:priority]}' is not a valid priorty"
    end
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end
  
  def delete(index)
    if(@items.size < index)
        raise UdaciListErrors::IndexExceedsListSizeError, "Cannot delete - index exceeds current list size"
    end
    @items.delete_at(index - 1)
  end
  
  def all(options={})
    display_header
    rows = []
    @items.each_with_index do |item, position|
      if options[:type]
        if item.item_type == options[:type]
          item_number = position + 1
          rows << item.details.unshift(item_number)
        end
      else
        item_number = position + 1
        rows << item.details.unshift(item_number)
      end
    end
    table_title = @title
    if options[:type]
      table_title += " ** Filter by #{options[:type]} **"
    end
    a = Artii::Base.new :font => "standard"
    table = Terminal::Table.new :title => a.asciify(table_title), :headings => ["#", "Type", "Description", "More info", "Priority"], :rows => rows
    table.align_column(4,:center)
    table.style = {:border_x => "=", :border_i => "x"}
    puts table
  end
    
  def filter(type)
    header = "Filtered by "#{type}" result:"
    puts "-" * header.length
    puts header
    puts "-" * header.length
    all(type: type)
  end
  
  private

  def display_header
    now = DateTime.now.strftime("%m/%d/%Y " + "%H:%M")
    puts "-" * now.length
    puts now
    puts "-" * now.length
  end
end
 