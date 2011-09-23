module Questionnaire
  class Parser
    def self.load_fields(key)
      #TODO: Handle errors with loading file
      #TODO: Make this more flexible and allow to pass a filename
      hash = YAML.load_file(File.join(Rails.root, 'config', 'questionnaires.yml'))
      hash.has_key?(key) ? hash[key] : {}
    end
  end
end  