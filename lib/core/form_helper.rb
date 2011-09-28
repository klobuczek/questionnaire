puts "loaded #{__FILE__}"

module Questionnaire
  module FormHelper
    def questionnaire(key, object)
      fields = Parser.load(key)
      Formatter.config = Parser.load(key, "questionnaires_config.yml")

      simple_form_for(object, options={}) do |f|
        Formatter.create_form_body(fields, f)
      end
    end
  end
end

ActionView::Base.send :include, Questionnaire::FormHelper