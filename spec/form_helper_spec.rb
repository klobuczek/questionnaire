require "spec_helper"

class ClassA; extend Questionnaire::FormHelper; end

class FormBuilder; end

class SomeObject; end

describe Questionnaire::FormHelper do
  let(:builder) { FormBuilder.new }
  let(:object) { SomeObject.new  }
  let(:fields) { FormBuilder.new  }
  
  describe "questionnaire_field_displayed?" do
    it "should call method from Formatter" do
      Questionnaire::Formatter.should_receive(:displayed?)
      ClassA.questionnaire_field_displayed?("some_object", "some_options")
    end
  end
  
  describe "questionnaire" do
    
    before do
      Questionnaire::Parser.stub(:load_fields)
      object.stub(:send).and_return(nil)
      ClassA.stub(:simple_form_for).and_yield(builder)
      builder.stub(:simple_fields_for).and_yield(fields) 
      Questionnaire::Formatter.should_receive(:create_form_body)
    end 
    
    it "should create a form" do
      ClassA.questionnaire("some_key", object)
    end
  end
end