puts "loaded #{__FILE__}"

module Questionnaire
  module FormHelper
    def questionnaire(key, object)
      fields = Parser.load_fields(key)
      simple_form_for(object, options={}) do |f|
        Formatter.create_form_body(fields, f)
      end  
    end
  end
end

ActionView::Base.send :include, Questionnaire::FormHelper