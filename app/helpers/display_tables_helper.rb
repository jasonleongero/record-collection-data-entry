module DisplayTablesHelper
  def conditionally_link(entity, attribute)
    data_item = entity.send(attribute[:sym])
    
    attribute[:is_link_attribute] ? link_to(data_item, url_for(entity)) : data_item
  end
end