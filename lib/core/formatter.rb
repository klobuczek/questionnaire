puts "loaded #{__FILE__}"

module Questionnaire
  class Formatter
  
    def self.create_form_body(fields, f)
      output = ''
      fields.keys.each do |section|
        next if fields[section].nil?
        fields[section].each_pair do |k,v|
           output << field_with_options(k, v, f)
        end
      end
      output << f.button(:submit)
      output.html_safe
    end
    
    def self.field_with_options(k, v, f)
      v.nil? ? simple_field(k,f) : with_options(k,v,f)
    end
    
    # Simple fields without any additional options
    def self.simple_field(k,f)
      f.input k.to_sym
    end
    
    # Field with additional options :only, :as etc..
    def self.with_options(k,v,f)
      simple_field(k,f) #temporary mock
    end

  end
end
