require 'spec_helper'
require 'rjp'

describe Rjp do
  let(:json_string) { %({ "level1": #{level1}}) }
  let(:level1) { %({ "level2" : #{level2} }) }
  let(:level2) { '[ { "level3a": "level3a_value" }, { "level3b": "level3b_value" } ]' }
  let(:rjp) { Rjp.new json_string }

  it "parses json to a hash" do
    expect(rjp.to_h).to eq(JSON.parse json_string)
  end

  describe '#extract' do
    it "returns a value for a key" do
      expect(rjp.extract('level1')).to eq(JSON.parse level1)
    end

    it "returns a value for an index" do
      rjp = Rjp.new level2
      expect(rjp.extract('0', 'level3a')).to eq("level3a_value")
    end

    it "returns a value for an index" do
      rjp = Rjp.new '[ "zero", "one"]'
      expect(rjp.extract('0')).to eq('zero')
    end

    it "returns a value for a list of nested keys or indecies" do
      expect(rjp.extract('level1', 'level2', 0, 'level3a')).to eq('level3a_value')
    end
  end
end
