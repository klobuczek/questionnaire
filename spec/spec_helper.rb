require 'factory_girl'
require 'simplecov'
SimpleCov.start

# for simple form
module Rails
  def self.env
    ActiveSupport::StringInquirer.new("test")
  end
  
  def self.root
    File.expand_path("../../spec/files", __FILE__)
  end
end

require 'rubygems'
require 'bundler/setup'
require 'questionnaire'
