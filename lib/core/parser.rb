module Questionnaire
  class Parser

    class << self
     # extend ActiveSupport::Memoizable

      def load_fields(key, filename='questionnaires.yml')
        begin
          hash = fetch_from_cache_or_file(filename)
          hash.has_key?(key.to_s) ? hash[key.to_s] : {}
        rescue Errno::ENOENT => e
          puts e.message
        rescue NoMethodError => e
          puts 'File seems to be not in proper yml format'
        end
      end

      # Opens file with questionnaires and caches it in class instance variable
      # if file is updated, its mtime parameter is changed and file is loaded once again
      # if not this method doesn't touch file
      def fetch_from_cache_or_file(filename)
        @path = File.join(Rails.root, 'config', filename)
        if update_time == last_update_time
          cached_hash
        else
          @update_time = last_update_time
          hash_from_file
        end
      end

      def update_time
        @update_time ||= last_update_time
      end

      def last_update_time
        File.stat(@path).mtime
      end

      def cached_hash
        @cached_hash ||= hash_from_file
      end

      def hash_from_file
        file = YAML.load_file(@path)
      end
    end
  end
end