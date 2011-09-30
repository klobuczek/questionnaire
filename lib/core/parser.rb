module Questionnaire
  class Parser

    class << self
      extend ActiveSupport::Memoizable

      def load_fields(key, filename='questionnaires.yml')
        begin
          hash = load_questionnaire(filename)
          hash.has_key?(key.to_s) ? hash[key.to_s] : {}
        rescue Errno::ENOENT => e
          puts e.message
        rescue NoMethodError => e
          puts 'File seems to be not in proper yml format'
        end
      end

      def load_questionnaire(filename)
        YAML.load_file(File.join(Rails.root, 'config', filename))
      end
      memoize :load_questionnaire
    end
  end
end