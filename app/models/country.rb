class Country < ApplicationRecord
  alias_attribute :id, :country_iso_code
  self.table_name = "country"
end
