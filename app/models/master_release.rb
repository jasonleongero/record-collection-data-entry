class MasterRelease < ApplicationRecord
  belongs_to :artist
  alias_attribute :id, :master_release_id
  self.table_name = "master_release"
end
