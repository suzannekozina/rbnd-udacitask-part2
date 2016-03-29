class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    # set_type('todo')
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
  end

  def details
    format_description(@description) + "due: " +
    format_date(@due) +
    format_priority(@priority)
  end

  def change_due_date(due_date)
    @due = Chronic.parse(due_date)
  end
end
