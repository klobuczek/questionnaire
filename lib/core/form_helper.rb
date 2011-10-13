module Questionnaire
  module FormHelper
    def questionnaire(key, object, options={})
      fields = Parser.load_fields(key)
      simple_form_for(object, options) do |f|
        f.simple_fields_for key.to_s.singularize.to_sym do |sf|
          Formatter.create_form_body(object, key, fields, sf)
        end
      end
    end

    def questionnaire_fields questionnaire
      Parser.load_fields(questionnaire).each do |section_name, section_body|
        yield section_name, section_body
      end
    end
  end
end

ActionView::Base.send :include, Questionnaire::FormHelper