# Moses Lagoon
# Filename: LogItem.rb
# Ruby DietManager project

require 'date'

# The LogItem class is used to represent and intitialize the logged
# database name and date.
class LogItem
  # Creates a new Log Item object consisting of a food name and the date it 
  # was logged in.
  def initialize(name, date)
    @name = name
    @date = date
  end

  attr_reader :name, :date
end

