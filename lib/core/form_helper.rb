#require "core/parser"

module Questionnaire
  module FormHelper
    def questionnaire(key, object)
      fields = Parser.load_fields_from_file(key)
      body = Formatter.format_body(fields)
    #  simple_form_for(object, options={}, &body)
    end

    

  end
end

ActionView::Base.send :include, Questionnaire::FormHelper