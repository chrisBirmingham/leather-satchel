# frozen_string_literal: true

require 'yaml'

module Leather
  module Satchel
    module Loader
      class YAMLLoader
        # @param path [String]
        # @return [Hash]
        def load_file(path)
          YAML.load_file(path)
        end
      end
    end
  end
end
