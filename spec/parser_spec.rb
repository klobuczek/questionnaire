require 'spec_helper'

describe Questionnaire::Parser do
  describe "#load_fields" do
    it "should always return a hash" do
      hash = Questionnaire::Parser.load("no_matter_what_key")
      hash.should be_instance_of(Hash)
    end

    it 'should return filled hash when hash for specified key is non-empty' do
      hash = Questionnaire::Parser.load("cherish_maps")
      hash.should_not be_empty
    end

    it "should return empty hash if key doesn't exist" do
      hash = Questionnaire::Parser.load("no_existing")
      hash.should be_empty
    end

    it 'should handle exception if file does not exist' do
      Questionnaire::Parser.load("no_existing", 'file.yml').should raise_error
    end

    it 'should handle exception if file is not in valid yaml format' do
      Questionnaire::Parser.load("no_existing", 'bad_file.rb').should raise_error
    end

    it 'should cache questionnaires file' do
      Questionnaire::Parser.load("cherish_maps")
      YAML.should_not_receive(:load_file)
      Questionnaire::Parser.load("cherish_maps")
    end
  end
end