require 'spec_helper'

class ClassB; extend Questionnaire::FieldsHelper; end

describe Questionnaire::FieldsHelper do
  let(:questionnaire) { { "section_name" => { "some_field" => nil, "some_other_field" => nil } } }

  describe "questionnaire fields" do
    it "should return section_name with set of section fields" do
      Questionnaire::Parser.stub(:load_fields).and_return(questionnaire)
      ClassB.questionnaire_fields(questionnaire) {|s,b|}.should == questionnaire      
    end
  end
end
  