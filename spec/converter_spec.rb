require_relative '../converter'

RSpec.describe Converter do

  subject(:converter) { Converter.new }

  context '#convert_string' do
    let(:test_string) { 'abcdab987612' }

    it 'returns right answer' do
      expect(subject.convert_string(test_string)).to match 'a-dab9-612'
    end
  end
end
