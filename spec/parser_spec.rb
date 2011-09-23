require 'spec_helper'

describe Questionnaire::Parser do
  describe "#load_fields_from_file" do
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

    it 'should throw exception if there are errors during load' do
      pending
    end
  end  
end