class Release < ApplicationRecord
  belongs_to :master_release
  belongs_to :country, foreign_key: :country_iso_code
  belongs_to :record_label
  
  has_many :tracks
  has_many :formats
  has_many :images
  
  alias_attribute :id, :release_id
  self.table_name = "release"
  
  def release_date
    "#{self.release_day}/#{self.release_month}/#{self.release_year}"
  end
  
  def country_name
    self.country.name
  end
  
  def record_label_name
    self.record_label.name
  end
  
  def primary_image
    (self.images.select { |img| !!img.is_primary })[0]
  end
  
  def formats_description    
    self.formats.reduce('') do |memo, format|
      memo + (memo.empty? ? '' : ', ') + if format.quantity > 1
        "#{format.quantity} x #{format.format_name}"
      else
        format.format_name
      end
    end
  end
end
