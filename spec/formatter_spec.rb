require 'spec_helper'

class User; end
class FormBuilder; end

describe Questionnaire::Formatter do
  let(:questionnaire) { { "section_body" => { "city_of_birth" => nil, "city_of_growing_up" => nil } } }
  let(:bad_questionnaire) { { "section_body" => nil } }
  let(:field_options) { { "only" => "male", "as" => "text" } }
  let(:user) { User.new }
  let(:builder) { FormBuilder.new }

  describe "#create form body" do
    before do
      builder.stub(:button)
    end
    
    it "should return form body when input data is properly formatted" do
      Questionnaire::Formatter.stub(:field_with_options).and_return("form output")
      Questionnaire::Formatter.create_form_body(user, "some_key", questionnaire, builder).html_safe?.should be_true
    end
    
    it "should not consist section field if section hasn't got body" do
      Questionnaire::Formatter.should_not_receive(:field_with_options)
      Questionnaire::Formatter.create_form_body(user, "some_key", bad_questionnaire, builder)
    end
  end  
  
  describe "#field_with_options" do
    it "should return proper options for field" do
      Questionnaire::Formatter.stub(:displayed?).and_return(true)
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