# Moses Lagoon
# Filename: BasicFood.rb
# Ruby DietManager project

# Log class which holds a hash of LogItems
class Log
# Date as the key, log item as the value
  def initialize
    @logHash = Hash.new([])  #Creating a new hash make of log, date and string array?
    @dirty = true
  end

  attr_reader :logHash, :dirty

  # The addLog function builds a hash and adds one unit of named food to the log
  # for the day or the specified date.
  def addLog(name, date = Date.today.strftime("%m/%d/%Y"))
    logItem = LogItem.new(name, date)			#Creating a new log item object
    if @logHash.has_key? logItem.date
      #puts "Same Date comes here!"
      @logHash[logItem.date].push logItem
    else
      @logHash[logItem.date] = [logItem]
    end
  end

  # The show all function shows the log of foods for all dates in the log, organi-
  # zed by acending date. The log for each day is preceded by a line with the day's
  # date
  def showAll
    @logHash.each do |date, items|
      puts "#{date}"
      items.each do |item|
        puts "  #{item.name}"
      end
    end
  end

  # The showDate function shows the log of foods for the given date as with the plain 
  # show above.
  def showDate(date)
    puts "#{date}"
    items = @logHash[date]
    items.each do |item|
      puts "  #{item.name}"
    end
  end

  # The save_log function saves the logged food and recipe into the databasef file. 
  def save_log
    logfile = File.open("DietLog.txt", "w")
    @logHash.each do |date, items|
      items.each do |item|
        logfile.write("#{date},#{item.name}\n")
      end
    end
    logfile.close()
    @dirty = false
  end

  # The delete_log function removes one unit of the named food to the log for the specified
  # date. Simple prints a message if the food is not in the database.
  def delete_log(name,date)
    logItem = LogItem.new(name, date)
    if @logHash.has_key? logItem.date
      to_remove = 0
      @logHash[logItem.date].each do |item|
        if item.name == logItem.name
          to_remove = item
        end
      end

      @logHash[logItem.date].delete(to_remove)

      #@logHash[logItem.date].delete(logItem)
      #puts "DATE TO LOOK FOR?#{logItem.date}"
      #then find and delete
      #otherwise
    else
      puts "#{logItem.name} is not in the database"
    end
  end

  # The parse_logfile file method parses the file to be logged in and calls the addLog
  # function to add it to the appropriate log database.
  def parse_logfile
    File.open("DietLog.txt", "r") do |f|
      f.each_line do |line|
        line.chomp!
        command = line.split(",")
        date = command[0]
        food = command[1]
        addLog(food, date)
      end
    end
  end
end
    