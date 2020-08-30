class Image < ApplicationRecord
  belongs_to :release
    
  alias_attribute :id, :image_id
  self.table_name = "image"
end
