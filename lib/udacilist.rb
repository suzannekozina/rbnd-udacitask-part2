class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
      if ["todo", "event", "link"].include?(type)
        if type == "todo"
          if options.has_key?(:priority)
            if ["low", "medium", "high"].include?(options[:priority])
              @items.push TodoItem.new(description, options)
            else
              raise UdaciListErrors::InvalidPriorityValue
            end
          else
            @items.push TodoItem.new(description, options)
          end
        end
        @items.push EventItem.new(description, options) if type == "event"
        @items.push LinkItem.new(description, options) if type == "link"
      else
      raise UdaciListErrors::InvalidItemType
      end
  end
  
  def delete(index)
    @items.delete_at(index - 1)
  end
  
  def all
    display_header
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

  private

  def display_header
    puts "-" * @title.to_s.length
    puts @title
    puts "-" * @title.to_s.length
  end
end