module Questionnaire
  class Formatter

    OPTIONS = {default_element: :as}

    class << self
      include ActionView::Helpers
      extend ActiveSupport::Memoizable

      def create_form_body(object, key, fields, form)
        output = content_tag(Questionnaire.title_tag, I18n.t(:"questionnaires.#{key}.label"))
        fields.keys.each do |section|
          next if fields[section].nil?
          output << content_tag(Questionnaire.section_tag, I18n.t(:"questionnaires.#{key}.#{section}.label"))
          fields[section].each_pair do |section_field, field_options|
            output << field_with_options(form, object, key, section_field, field_options, section)
          end
        end
        output << form.button(:submit)
        output.html_safe
      end

      def field_with_options(form, object, key,  field, options, section)
        options.nil? ? simple_field(form, object, key, field, section) : with_options(form, object, key, field, options, section)
      end

      # Simple fields without any additional options                                             ,
      def simple_field(form, object, key, field, section)
        form.input field.to_sym, field_attributes.merge!(html_options(field, object, key, section))
      end

      # grabs elements defined in gem initializer file, select getters, check if them are't nil,
      # and maps them onto simple_form hashes (temporary solution)
      def field_attributes
        #    methods = Questionnaire.instance_methods.select { |m| m.to_s !~ /=/ }
        #    methods.inject({}) { |opt, met| OPTIONS[met] = result if (result = Questionnaire.send(met.to_sym)) }
        #    opt
        {}
      end

      memoize :field_attributes

      def html_options(field, object, key, section)
        {required: false}.tap do |h|
          h[:label] = I18n.t(:"questionnaires.#{key}.#{section}.#{field}")
          h[:input_html] = {value: object.send(key.to_sym).try(:[], field)}
        end
      end

      # Field with additional options :only, :as etc..
      def with_options(form, object, key, field, options, section)
        simple_field(form, object, key, field, section) #temporary mock
      end
    end
  end
end
