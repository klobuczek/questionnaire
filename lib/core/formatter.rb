module Questionnaire
  class Formatter

    OPTIONS = {default_element: :as}

    class << self
      extend ActiveSupport::Memoizable

      def create_form_body(fields, f)
        output = ''
        fields.keys.each do |section|
          next if fields[section].nil?
          fields[section].each_pair do |k,v|
             output << field_with_options(k, v, f, section)
          end
        end
        output << f.button(:submit)
        output.html_safe
      end

      def field_with_options(k, v, f, section)
        v.nil? ? simple_field(k, f, section) : with_options(k, v, f, section)
      end

      # Simple fields without any additional options
      def simple_field(k, f, section)
        f.input k.to_sym, attributes.merge!(input_html: input_html_options(k, section))
      end

      def input_html_options(k, section)
        {name: [section, k].join("_")}
      end

      # grabs elements defined in gem initializer file, select getters, check if them are't nil,
      # and maps them onto simple_form hashes (temporary solution)
      def attributes
        opt = {}
        methods = Questionnaire.instance_methods.select { |m| m.to_s !~ /=/ }

        methods.each do |m|
          if result = Questionnaire.send(m.to_sym)
            opt.merge!({OPTIONS[m] => result})
          end
        end
        opt
      end
      memoize :attributes

      # Field with additional options :only, :as etc..
      def with_options(k, v, f, section)
        simple_field(k, f, section) #temporary mock
      end
    end
  end
end
