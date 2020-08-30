class RecordLabel < ApplicationRecord
  alias_attribute :id, :record_label_id
  self.table_name = "record_label"
end
