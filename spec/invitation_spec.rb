require 'json'
require_relative '../invitation'

RSpec.describe Invitation do

  subject(:invitation) { Invitation.new(2) }

  context '#initialize' do
    it 'create employees variable' do
      expect(subject.instance_variable_defined?(:@employees)).to be true
    end

    it 'loads elements to employees variable' do
      elements_count = File.open('employees.json').count
      expect(subject.instance_variable_get(:@employees).size).to eq(elements_count)
    end

    it 'notifies about error when can not fill employees' do
      expect(subject.send(:load_employee, 'employees.jso')).to eq('Error happened while getting data from employees.jso')
    end

    it 'creates new variables from file name' do
      expect(subject.instance_variable_defined?(:@recipes)).to be true
      expect(subject.instance_variable_defined?(:@prices)).to be true
    end

    it 'notifies about error when can not create variables from file name' do
      expect(subject.send(:read_json, 'recipes.jso')).to eq('Error happened while getting data from recipes.jso')
    end
  end

  context '#invited_persons' do
    it 'returns warning if no data in employees' do
      subject.instance_variable_set(:@employees, [])
      expect(subject.invited_persons).to eq('Check errors')
    end

    it 'add employee to persons array when key drink is absent' do
      subject.instance_variable_set(:@employees, [{id: 1, name: 'Mildred Carson'}, {id: 2,name: 'Clifford Brown', drinks: ['Latte']}])
      expect(subject.invited_persons.size).to eq(2)
    end

    it 'calculate the total price when drink exists' do
      subject.instance_variable_set(:@total_price, 0)
      drink = ['Latte']
      latte_cost = 0.2735
      subject.send(:drink_cost, drink)
      expect(subject.instance_variable_get(:@total_price)).to eq(latte_cost)
    end

    it 'notifies about warning when drink is not valid' do
      subject.instance_variable_set(:@employees, [{id: 2, name: "Clifford Brown", drinks: ["L"]}])
      expect(subject.invited_persons).to eq('Check ingredients and prices for L')
    end

    it 'returns persons not including current when budget less then total price' do
      subject.instance_variable_set(:@total_price, 1.99)
      subject.instance_variable_set(:@employees, [{id: 2, name: "Clifford Brown", drinks: ["Latte"]}])
      expect(subject.invited_persons).to be_empty
    end

    it 'returns persons including current when budget bigger then total price' do
      subject.instance_variable_set(:@total_price, 0.5)
      person = subject.instance_variable_set(:@employees, [{id: 2, name: "Clifford Brown", drinks: ["Latte"]}])
      expect(subject.invited_persons).to eq(person)
    end

    it 'returns persons sorted by id' do
      subject.instance_variable_set(:@employees, [{id: 3, name: 'Kellie Fletcher', drinks: ['Flat White']}, {id: 6, name: 'Rudolph Bishop', drinks: ['Latte']}, {id: 4, name: 'Don Parsons', drinks: ['Espresso']}])
      sorted_result = [{ id: 3, name: 'Kellie Fletcher', drinks: ['Flat White'] }, { id: 4, name: 'Don Parsons', drinks: ['Espresso'] }, { id: 6, name: 'Rudolph Bishop', drinks: ['Latte'] }]
      expect(subject.invited_persons).to eq(sorted_result)
    end
  end
end
