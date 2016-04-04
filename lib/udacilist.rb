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
    table = Terminal::Table.new :title => table_title, :headings => ['#', 'Type', 'Description', "More info", "Priority"], :rows => rows
    table.align_column(4,:center)
    puts table
  end
    
  #   if @title == nil
  #   @title = "Untitled List"
  #   end
  #   table = Terminal::Table.new do |t|
  #     t.title = @title
  #     @items.each_with_index do |item, position|
  #       t.add_row [position + 1, item]
  #     end
  #   end
  #   table.style = {:border_x => "=", :border_i => "x"}
  #   puts table
  # end

  def filter(type)
    header = "Filtered by '#{type}' result:"
    puts "-" * header.length
    puts header
    puts "-" * header.length
    all(type: type)
  end
  
  private

  def display_header
    puts "-" * @title.to_s.length
    puts @title
    puts "-" * @title.to_s.length
  end
end
  # private

  # def display_header
  #   puts "-" * @title.to_s.length
  #   puts @title
  #   puts "-" * @title.to_s.length
  # end
  
  # def pretty_list
  #   rows = []
  #   rows << ["?", "#", "Details"]
  #   rows << [" ", " ", " "]
  #   @items.each_with_index do |item, position|
  #     rows << ["_", position + 1, item.details]
  #   end
  #   table = Terminal::Table.new :rows => rows
  #   table.style = {:border_x => "=", :border_i => "x"}
  #   puts table
  # end
# end