class Track < ApplicationRecord
  belongs_to :release
  
  alias_attribute :id, :track_id
  self.table_name = "track"
  
  def minutes
    self.duration / 60
  end
  
  def seconds
    self.duration % 60
  end
end
