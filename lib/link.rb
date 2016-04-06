class LinkItem
  include Listable
  attr_reader :description, :site_name, :link, :item_type

  def initialize(url, options={})
    @description = url
    @site_name = options[:site_name]
    @item_type = "link"
  end
  
  def format_name
    @site_name ? @site_name : ""
  end
  
  def details
    [item_type.capitalize, format_description(@description), "site name: " + format_name, ""]
  end
end
