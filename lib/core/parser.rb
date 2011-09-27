puts "loaded #{__FILE__}"



module Questionnaire
  class Parser
    def self.load_fields(key, filename='questionnaires.yml')
      begin
        hash = YAML.load_file(File.join(Rails.root, 'config', filename))
        hash.has_key?(key.to_s) ? hash[key.to_s] : {}
      rescue Errno::ENOENT => e
        puts e.message    
      rescue NoMethodError => e
        puts 'File seems to be not in proper yml format'
      end      
    end
  end
end  