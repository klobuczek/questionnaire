require "spec_helper"

class ClassA; end

describe Questionnaire::ModelHelper do
  let(:section_body) { {"date_of_birth" => nil} }
  let(:field) { "date_of_birth" }
  let(:nil_options) { nil }
  let(:options) { { "type" => "Integer" } }
  let(:attr_accessible) { Set.new }
   
  describe "#extended" do
    it "when extended should also add FieldsHelper methods to class" do
      ClassA.send(:extend, Questionnaire::ModelHelper)
      ClassA.should respond_to(:questionnaire_fields)
    end
  end
  
  describe "#create_model_fields" do
    before do
      ClassA.send(:extend, Questionnaire::ModelHelper)
      ClassA.stub(:questionnaire_fields).and_yield("section", section_body)
    end
    
    context "#defining fields" do
    
      before do
        ClassA.stub(:attr_accessible).and_return(attr_accessible)
        attr_accessible.stub(:<<)
      end
      
      it "should define keys for mongo_mapper" do
        section_body.stub(:each_pair).and_yield(field, nil_options)
        ClassA.should_receive(:key).with(field.to_sym, String)
        ClassA.create_model_fields
      end
      
      it "should create field with given type" do
        section_body.stub(:each_pair).and_yield(field, options)
        ClassA.should_receive(:key).with(field.to_sym, options.fetch("type").constantize)
        ClassA.create_model_fields  
      end
      
    end
    context "#attr_accessible" do
      
      before do
        section_body.stub(:each_pair).and_yield(field, nil_options)
        ClassA.stub(:attr_accessible).and_return(attr_accessible)
        ClassA.stub(:key)
      end
    
      it "should add created keys into attr_accessible" do
        attr_accessible.should_receive(:<<).with(field.to_sym)
        ClassA.create_model_fields
      end
    end  
  end
end