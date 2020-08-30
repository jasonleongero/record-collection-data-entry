class Format < ApplicationRecord
  belongs_to :release
  
  alias_attribute :id, :format_id
  self.table_name = "format"
end
