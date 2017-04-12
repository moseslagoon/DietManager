# Ruby Diet Manager
# Moses Lagoon
# Filename: DietManager.rb (The main class perhaps)
# April 11, 2016

# The main class, DietManager is the main class where all the commands for the speci-
# fied levels are handled as necessary. It processes each line from standard input as a
# command and takes it to invoke functions as required to log, add, and display foo-
# s etc.

require 'basic_food'
require 'recipe'
require 'food_db'
require 'log'
require 'log_item'
require 'date'


db = FoodDB.new       #instantiating the food database class
db.parse_file	        #parsing the food database
logdb = Log.new       #creating a new instance of log database here
logdb.parse_logfile   #parsing the log database

# Process each line from the command line input and invoke functions as required to handled
# different cases.
$stdin.each do|line|
  command = line.chomp.split(" ")  #the input command

  #Print and print all commands
  if command[0].eql? "print"
    if command[1].eql? "all"
      puts "\n"
      db.printAllFood()
    else
      #puts "Here #{command[1..-1].join(" ")}"
      db.printFood(command[1..-1].join(" "))
    end
    # to create a new food and new recipe
    # new food and new recipe
  elsif command[0].eql? "new"
    if command[1].eql? "food"
      if command.size == 3
        cmd_split = command[2]
        puts "#{cmd_split}"
        cmd_split = cmd_split.split(",")
        db.addFood(cmd_split[0], cmd_split[1])
      elsif command.size >3
        cmd = command[2..-1].join(" ")
        puts "#{cmd}"
        cmd_split = cmd.split(",")
        db.addFood(cmd_split[0],cmd_split[1])
      end

      # new recipe
    elsif command[1].eql? "recipe"
      cmd = command[2..-1].join(" ")
      cmd_split = cmd.split(",")
      db.addRecipe(cmd_split[0], cmd_split[1..-1])	#name, and ingredients
    end

    # SAVE the food into the database
  elsif command[0].eql? "save"
    db.save()
    logdb.save_log()


    # FIND, finding the food in the database
  elsif command[0].eql? "find"
    db.findPrint(command[1])

    # QUIT, quit command
  elsif command[0].eql? "quit"	#LEVEL 1
    #if not saved
    if db.dirty
      db.save()
      logdb.save_log()
      break
      #  puts "Do you want to exit without saving? yes/no"
      #  userin = gets.chomp
      #  if userin.eql? "yes"
      #    break
      #  end
      #@else
      #  break
    end

    # LOG, log foods into the food database
  elsif command[0].eql? "log"
    cmd = command[1..-1].join(" ")
    cmd_split = cmd.split(",")
    if db.foodExists?(cmd_split[0]) || db.recipeExists?(cmd_split[0])
      length = cmd_split.length
      if length == 2		#if the user added the date
        logdb.addLog(cmd_split[0], cmd_split[1])
      else			     	#otherwise, just add the name and let it be default
        logdb.addLog(cmd)
      end
    else
      puts "Food is not found in the database"
    end

    #SHOW function, show all, show method of the log gets invoked to show
    # as required.
  elsif command[0].eql? "show"
    if command[1].eql? "all"
      logdb.showAll()
    else
      length = command.length
      #puts "Else case for just show method"
      if length == 2
        datein = command[1]
        logdb.showDate(datein)
      else
        currdate = Date.today.strftime("%m/%d/%Y")
        #puts "#{currdate}"
        #currdate = Date.today
        logdb.showDate(currdate)
        #generate the current date and use the show date to do it
      end
    end

    #The delete command deletes the given name and date from the log database
  elsif command[0].eql? "delete"
    cmd_split = command[1..-1].join(" ")
    cmd = cmd_split.split(",")
    name = cmd[0]
    date = cmd[1]
    logdb.delete_log(name,date)
  end

end


