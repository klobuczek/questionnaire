puts "loaded #{__FILE__}"

module Questionnaire
  class Formatter

    class << self
      extend ActiveSupport::Memoizable

      def config
        @config
      end

      def config=(config_hash)
        @config = config_hash.empty? ? {} : config_hash.symbolize_keys!
      end
      memoize :config

      # consider if this should be a class method
      # this approach should be enough flexible to to add custom fields to 'output variable'
      def create_form_body(fields, f)
        output = ''
        fields.keys.each do |section|
          next if fields[section].nil?
          # add to output some title paragraph with section
          fields[section].each_pair do |k,v|
            output << field_with_options(k, v, f)
          end
        end
        output << f.button(:submit)
        output.html_safe
      end

      #
      def field_with_options(k, v, f)
        v.nil? ? simple_field(k,f) : with_options(k,v,f)
      end

      # Simple fields with standard view options if it differs from options for simple form
      def simple_field(k,f)
        f.input(k.to_sym, config)
      end

     # Field with additional options :only, :as etc..
      def with_options(k,v,f)
        simple_field(k,f) #temporary mock
      end
    end
  end
end
