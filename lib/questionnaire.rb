puts "loaded #{__FILE__}"

require "simple_form"

module Questionnaire
  #TODO: investigate why autoload Parser, require ... didnt work
  require   'core/parser'
  require   'core/form_helper'
  require   'core/formatter'


  # define global options for fields as a module accessors here, consider using the same names as
  # simple_form does
  mattr_accessor :default_element

  def self.setup
    yield self
  end


end
