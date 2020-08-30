module ReleaseHelper
  START_YEAR = 1900
  END_YEAR = 2100
  
  def valid_years
    Array(Range.new(START_YEAR, END_YEAR)).map { |year| [year, year] }
  end
  
  def valid_months
    Array(Range.new(1, 12)).map { |month| [month, month] }
  end
  
  def valid_days
    Array(Range.new(1, 31)).map { |day| [day, day] }
  end
end
