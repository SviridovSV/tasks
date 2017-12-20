require 'json'
# We have the employees drink preference records in a text file
# (employees.json, attached) one employee per line, JSON-encoded.
# We want to organize the party and invite as many employees as possible.
# We've created the JSON files with the drink recipes (recipes.json, attached)
# and the prices of the components (prices.json, attached).
# Please, write the program that will accept the party budget
# and will output the names, user ids and chosen drinks for the employees
# that should be invited, sorted by user id (ascending).
class Invitation
  def initialize(budget)
    @total_price = 0
    @budget = budget
    @employees = []
    load_employee('employees.json')
    read_json('prices.json')
    read_json('recipes.json')
  end

  def invited_persons
    persons = []
    return 'Check errors' unless @employees.any?
    @employees.each do |emp|
      if emp[:drinks]
        return p "Check ingredients and prices for #{emp[:drinks].join(', ')}" unless drink_cost(emp[:drinks])
        return sort_output_by_id(persons) if budget_exceeded(@total_price)
      end
      persons << emp
    end
    sort_output_by_id(persons)
  end

  private

  def sort_output_by_id(array)
    array.sort_by! { |item| item[:id] }
  end

  def read_json(file)
    f = open(file)
    json = f.read
    instance_variable_set("@#{File.basename(file, '.*')}", JSON.parse(json, symbolize_names: true))
  rescue
    p "Error happened while getting data from #{file}"
  end

  def load_employee(file)
    File.open(file).each do |line|
      @employees << JSON.parse(line, symbolize_names: true)
    end
    @employees
  rescue
    p "Error happened while getting data from #{file}"
  end

  def budget_exceeded(price)
    price > @budget
  end

  def drink_cost(drinks)
    drinks.each do |drink|
      ingredients = @recipes.find { |key, _| key.to_s == drink.to_s }.last
      ingredients.each { |key, val| @total_price += @prices[key] * val }
    end
    return true
  rescue
    return false
  end
end
