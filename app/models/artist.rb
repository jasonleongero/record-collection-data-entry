class Artist < ApplicationRecord
  alias_attribute :id, :artist_id
  self.table_name = "artist"
end
