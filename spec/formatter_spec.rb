require 'spec_helper'

class User; end
class FormBuilder; end

describe Questionnaire::Formatter do
  let(:field_options) { { "only" => "male", "as" => "text" } }
  let(:user) { User.new }
  let(:builder) { FormBuilder.new }

  describe "#create form body" do
    it "should return form body" do
      pending
    end
  end 
  
  describe "#field_with_options" do
    it "should return proper options for field" do
      Questionnaire::Formatter.stub(:displayed?)
      builder.should_receive(:input)
      Questionnaire::Formatter.field_with_options(builder, user, "key", "field",  "section_field", field_options)
    end
  end

  describe "#displayed?" do
    it "should return true if field should be displayed" do
      user.stub(:male?).and_return(true)
      Questionnaire::Formatter.displayed?(user, field_options).should be_true
    end

    it "should return false if field shouldn't be displayed" do
      user.stub(:male?).and_return(false)
      Questionnaire::Formatter.displayed?(user, field_options).should be_false
    end
  end

  describe "#field attributes" do
    
    before { Questionnaire.setup { |config| config.as = :text } }
    
    it "should return settings defined in initializer" do
      Questionnaire::Formatter.field_attributes.should == { :as => :text }
    end
  end

  describe "#html_options" do
    it "should return options with type of field" do
      opt = Questionnaire::Formatter.html_options("some_field", user, "key", "section", field_options )
      opt.should include(:as => :text) 
    end

    it "should return label associated with field" do
      I18n.stub(:t).and_return("some translated label")
      opt = Questionnaire::Formatter.html_options("some_field", user, "key", "section", field_options )
      opt.should include(:label => "some translated label")  
    end
  end
end