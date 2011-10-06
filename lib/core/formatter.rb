module Questionnaire
  class Formatter


    OPTIONS = { default_element: :as }

    class << self
      extend ActiveSupport::Memoizable
      include ActionView::Helpers

      def new(*args)
        initialize(*args)
        self
      end

      def initialize(object, key, fields)
        @object, @key, @fields = object, key, fields
      end

      def create_form_body(f)
        @form = f
        output = '' << content_tag(:h1, I18n.t(:"questionnaires.#{@key}.label"))
        @fields.keys.each do |section|
          next if @fields[section].nil?
          output << content_tag(:h3, I18n.t(:"questionnaires.#{@key}.#{section}.label"))
          @fields[section].each_pair do |section_field, field_options|
             output << field_with_options(section_field, field_options, section)
          end
        end
        output << f.button(:submit)
        output.html_safe
      end

      def field_with_options(field, options, section)
       options.nil? ? simple_field(field, section) : with_options(field, options, section)
     end

     # Simple fields without any additional options
     def simple_field(field, section)
       @form.input field.to_sym, field_attributes.merge!(html_options(field, section))
     end

      # grabs elements defined in gem initializer file, select getters, check if them are't nil,
      # and maps them onto simple_form hashes (temporary solution)
      def field_attributes
        opt = {}
        methods = Questionnaire.instance_methods.select { |m| m.to_s !~ /=/ }

        methods.each do |m|
          if result = Questionnaire.send(m.to_sym)
            opt.merge!({ OPTIONS[m] => result })
          end
        end
        opt
      end
      memoize :field_attributes

      def html_options(field, section)
        { required: false }.tap do |h|
          h[:label] = I18n.t(:"questionnaires.#{@key}.#{section}.#{field}")
          h[:input_html] = { value: @object.send(@key.to_sym).try(:[], field) }
         end
      end

      # Field with additional options :only, :as etc..
      def with_options(field, options, section)
        simple_field(field, section) #temporary mock
      end
    end
  end
end
