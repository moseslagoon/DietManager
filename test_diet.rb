# Ruby Diet Manager
# Moses Lagoon
# April 15, 2016

require 'test/unit'
require 'basic_food'
require 'recipe'
require 'log'
require 'log_item'

class TestDiet < Test::Unit::TestCase

  def test1
    food = BasicFood.new('Avocado', 225)
    assert( food.calories == 225, 'Failure in BasicFood calorie accessor' )
    assert( food.name == 'Avocado', 'Failure in BasicFood name accessor' )
    #assert( food.name == 'wrongname', 'This test should fail because the food.name is: ' + food.name )
  end

  #Test more basic foods
  def test2
    food = BasicFood.new('Apple', 90)
    assert(food.calories == 90, 'Failure in BasicFood calorie accessor')
    assert(food.name == 'Apple', 'Failure in BasicFood name accessor')
  end

  #test recipe
  def test3
    #Recipe object contains food, ingredients and calories
    food = Recipe.new('Chicken Sandwich','Chicken, Bacon Ranch', 0)
    assert(food.ingredients == 'Chicken, Bacon Ranch', 'Failure in Recipe ingredients accessor')
    assert(food.name == 'Chicken Sandwich','Failure in Recipe name accessor')
  end

  #test more recipes

  def test4
    food = Recipe.new('PB&J Sandwich','Peanut Butter, Jelly', 0)
    assert(food.ingredients == 'Peanut Butter, Jelly', 'Failure in Recipe ingredients accessor')
    assert(food.name == 'PB&J Sandwich','Failure in Recipe name accessor')
  end
end
