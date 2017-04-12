# Moses Lagoon
# File: FoodDB.rb
# Date: 04/13/2016

require 'basic_food'
require 'recipe'


# The foodDB class is food database class where two hashes are created
# to store all of the basic food and recipes. Furthermore, it consists
# of several other methods to handle specified commands ranging from st-
# oring, adding the saving the database to printing them out as required.

class FoodDB

  # Intializes a new food object. Two Hashes, BasicHash and RecipeHash are 
  # created,and a boolean instance dirty is initialized to true to check if 
  # the new recipe or food that's being added is saved or not
  def initialize()
    @BasicHash = Hash.new   #BasicHash to store basic food
    @RecipeHash = Hash.new  #RecipeHash to store recipes
    @dirty = true           #check for save status
  end

  attr_reader :BasicHash, :RecipeHash, :dirty

  # The addFood methhod creates a new basic food object with name and calories
  # and adds it to the hash with the name as the key and the object as the val
  # -ues respectively
  def addFood(name, calories)
    basics = BasicFood.new(name, calories)
    @BasicHash[name] = basics
  end

  # The addRecipe method creates a new recipe object with the  name and ingredients
  #  and adds it to the hash. First of all, it checks if the basic food ( name ) is
  #  already in the database, or if any N constituent food names are not  in the data
  #  -base and prints out appropriate message 
  def addRecipe(name, ingredients)
    calories = 0
    keys = @BasicHash.keys
    ingredients.each do |ingredient|
      ingredient.chomp!
      # if the ingredient is in the basicFood
      if @BasicHash.has_key? ingredient
        calories += @BasicHash[ingredient].calories.to_i
      else
        puts "Can't find the ingredient"
        puts "#{ingredient}"
      end
      #Making recipe object and adding it to the hash
      myrecipes = Recipe.new(name, ingredients, calories)
      @RecipeHash[name] = myrecipes
    end
  end

  # The print function is responsible for printing basic food and recipe contents of the 
  # file, prints all the foods and the recipes that is stored in the food database.
  def printAllFood
    @BasicHash.each do |key, value|
      basicfood = @BasicHash[key]
      puts "#{basicfood.name} #{basicfood.calories} "
    end
    puts "\n" #Adding a new line between basicFood and recipes
    @RecipeHash.each do |key, value|
      recipePrintHelper(key)  #Calls helper function to print recipe as requested
    end
  end

  # Level 2 Print Food 
  # This method prints the requested basic food. For a basic food it simply prints 
  # the food name if it exits and prints an errors message otherwise. A variable i
  # is initialzed to check if the food is contained in either of the two recipe or 
  # basic food database. i is changed to 1 whenever it visits and the key is found.
  def printFood(name)
    i = 0      #initializing i to zero
    # if the given food matches basicHash food name
    # look into basicHash and set i to 1 to mark found
    if @BasicHash.has_key? name
      i = 1
      basicfood = @BasicHash[name]
      puts "#{basicfood.name} #{basicfood.calories} "
    end
    # if it is found in recipeHash then look into
    # recipe hash and print it out.
    if  @RecipeHash.has_key? name
      i = 1
      recipePrintHelper(name)
    end
    # else case, if it can't find in both recipe
    # and basic hash
    if i == 0
      puts "Can't find the food '#{name}'"
    end
  end

  # RecipePrintHelper function prints the required recipe name and ingredients 
  # along with its calories
  def recipePrintHelper(name)
    myrecipe = @RecipeHash[name]
    puts "#{myrecipe.name} #{myrecipe.calories}"
    # Loop through each ingredient and print out the required ingredient name and
    # and the associated calories.
    myrecipe.ingredients.each do |ingredient|
      puts "  #{@BasicHash[ingredient].name} #{@BasicHash[ingredient].calories}\n"
    end
  end

  # The findPrint funciton finds the word with the given prefix and then prints it, 
  # if the word is in the hashmap otherwise breaks out of the loop and prints out 
  # the error message.
  def findPrint(prefix)
    @BasicHash.each do |key, value|
      basicfood = @BasicHash[key]
      # if the name of the food matches the prefix
      # print the requested food
      if basicfood.name.downcase.start_with?(prefix.downcase)
        basicfood = @BasicHash[key]
        puts "#{basicfood.name} #{basicfood.calories} "
      end
    end
    @RecipeHash.each do |key, value|
      myrecipe = @RecipeHash[key]
      # if the name of the food matches the prefix
      # print the requested food
      if myrecipe.name.downcase.start_with?(prefix.downcase)
        recipePrintHelper(key)
      end
    end
    #else case, if it can't find the food its looking for
    #puts "Can't find the food starting with '#{prefix}'"
  end

  # The save function saves the created new recipe or food to the foodDB.txt file
  # write method is used to write the file.
  def save
    dbfile = File.open("FoodDB.txt", "w")
    @BasicHash.each do |foodName, foodObject|
      dbfile.write("#{foodName},b,#{foodObject.calories}\n")
    end
    @RecipeHash.each do |recipeName, recipeObject|
      dbfile.write("#{recipeName},r,#{recipeObject.ingredients.join(",")}\n")
    end
    dbfile.close()
    @dirty = false
  end

  #Check for log, checks if basic food exists in the database or not? 
  def foodExists? (name)
    !!@BasicHash[name] #!! BasicHash checks if the food exists, evaluates to true if it does
    #otherwise false
  end

  # Checking for log, Check if the recipe of the given name being logged exists in
  # the database
  def recipeExists?(name)
    !!@RecipeHash[name]
  end

  # Parse the file and add the contents as per the type, into the database addRecipe and
  # add BasicFood respectively
  def parse_file
    File.open("FoodDB.txt", "r") do |f|
      f.each_line do |line|
        line.chomp!
        command = line.split(",")
        name = command[0]
        type = command[1]
        info = command[2]
        #switches on type
        case type
          when "b"
            addFood(name, info)
          when "r"
            length = command.length-1
            ingredients = command[2..length]
            addRecipe(name,ingredients)
        end
      end
    end
  end
end

	  
	
	
  
	
  
    
    	
