require 'spec_helper'
require 'rjp'

describe 'rjp' do
  let(:json_string) { %({"level1": #{level1}}) }
  let(:level1) { %({ "level2" : #{level2} }) }
  let(:level2) { %([ { "level3a": "level3a_value" }, { "level3b": "level3b_value" } ]) }
  let(:rjp) { File.expand_path(File.join('..', '..', 'bin', 'rjp'), __FILE__) }

  it "accepts stdin" do
    expect(`echo '{ "key": "value" }' | #{rjp} -k key`).to eq(%("value"\n))
  end

  it "accepts file list" do
    `echo '{ "key": "value" }' > /tmp/rjp_json_test`
    expect(`#{rjp} -k key /tmp/rjp_json_test`).to eq(%("value"\n))
    `rm /tmp/rjp_json_test`
  end

  it "outputs formated a hash to stdout" do
    str=<<-hash
{
    "level1" => {
        "level2" => [
            [0] {
                "level3a" => "level3a_value"
            },
            [1] {
                "level3b" => "level3b_value"
            }
        ]
    }
}
    hash
    expect(`echo '#{json_string}' | #{rjp}`).to eq(str)
  end

  context "when --keys are provided" do
    it "extracts the value from the hash" do
      expect(`echo '#{json_string}' | #{rjp} -k level1,level2,0,level3a`).to eq(%("level3a_value"\n))
      expect(`echo '#{json_string}' | #{rjp} --keys level1,level2,0,level3a`).to eq(%("level3a_value"\n))
    end

    context "when the key is not found" do
      it "returns a non-zero status" do
        `echo '#{json_string}' | #{rjp} -k level1,level2,something`
        expect($?.exitstatus).to eq(1)
      end

      context "when --default is provided" do
        it "it is returned" do
          expect(`echo '#{json_string}' | #{rjp} -k something -d default`).to eq(%("default"\n))
          expect(`echo '#{json_string}' | #{rjp} --keys something --default default`).to eq(%("default"\n))
        end
      end
    end
  end
end
