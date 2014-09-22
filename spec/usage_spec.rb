require 'spec_helper'
require 'apriori/algorithm'
require 'csv'

RSpec.describe Apriori::Algorithm do

  transactions = []
  File.open('spec/dataset.csv') do |file|
    file.each_line do |line|
      transactions << CSV.parse(line)[0]
    end
  end

  it 'works as expected with default settings' do
    algorithm = Apriori::Algorithm.new()
    result = algorithm.analyze(transactions)
    expect(result.association_rules.length).to eq(5)
  end

  it 'works as expected with custom settings' do
    algorithm = Apriori::Algorithm.new(0.15, 0.8)
    result = algorithm.analyze(transactions)
    expect(result.association_rules.length).to eq(4)
  end

end

