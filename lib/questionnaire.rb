puts "loaded #{__FILE__}"

require "simple_form"

module Questionnaire
  #TODO: investigate why autoload Parser, require ... didnt work
  require   'core/parser'
  require   'core/form_helper'
  require   'core/formatter'

end
