require "spec_helper"

Questionnaire.setup do |config|
  config.title_tag = :h1  
end


describe Questionnaire do
  describe "#setup" do
    it "should consist options defined using setup block" do
      Questionnaire.title_tag == :h1
    end
  end
end
