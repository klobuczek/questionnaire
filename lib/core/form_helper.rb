module Questionnaire
  module FormHelper
    def questionnaire(key, object, options={})
      fields = Parser.load_fields(key)
      formatter = Formatter.new(object, key, fields)
      simple_form_for(object, options) do |f|
        f.simple_fields_for key.to_s.singularize.to_sym do |sf|
          formatter.create_form_body(sf)
        end
      end
    end
  end
end

ActionView::Base.send :include, Questionnaire::FormHelper