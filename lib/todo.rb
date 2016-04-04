class TodoItem
  include Listable
  attr_reader :description, :due, :priority, :item_type

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]).to_s : options[:due]
    @priority = options[:priority] 
    @item_type = "todo"
  end
  
  def details
    [item_type.capitalize, format_description(@description), "due: " + format_date(due: @due), + format_priority(@priority)]
  end
end