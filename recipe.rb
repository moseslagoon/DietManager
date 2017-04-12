# Moses Lagoon
# Ruby Diet Manager
# File: Recipe.rb

require 'basic_food'


class Recipe
  # Creating a new Recipe,takes in a name(string) and and
  # list of BasicFood objects
  def initialize(name, ingredients, calories)
    @name = name
    @ingredients = ingredients
    @calories = calories
  end

  attr_reader :name, :ingredients, :calories


end