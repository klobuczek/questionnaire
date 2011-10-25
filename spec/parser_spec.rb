require 'spec_helper'

describe Questionnaire::Parser do
  describe "#load_fields" do
    it "should always return a hash" do
      hash = Questionnaire::Parser.load_fields("no_matter_what_key")
      hash.should be_instance_of(Hash)
    end

    it 'should return filled hash when hash for specified key is non-empty' do
      hash = Questionnaire::Parser.load_fields("cherish_maps")
      hash.should_not be_empty
    end

    it "should return empty hash if key doesn't exist" do
      hash = Questionnaire::Parser.load_fields("no_existing")
      hash.should be_empty
    end

    it "should cache questionnaires file if file didn't change" do
      Questionnaire::Parser.load_fields("cherish_maps")
      YAML.should_not_receive(:load_file)
      Questionnaire::Parser.load_fields("cherish_maps")
    end
    
    it "should load questionnaires file if file has changed" do
      Questionnaire::Parser.fetch_from_cache_or_file("questionnaires.yml")
      f = File.open(File.join(Rails.root, 'config', "questionnaires.yml"), "a+")
      f.write("\n")
      f.close
      YAML.should_receive(:load_file)
      Questionnaire::Parser.fetch_from_cache_or_file("questionnaires.yml")
    end
  end
end