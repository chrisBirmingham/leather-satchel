# frozen_string_literal: true

module Leather
  module Satchel
    module Loader
      autoload :JSONLoader, 'leather/satchel/loader/json_loader'
      autoload :YAMLLoader, 'leather/satchel/loader/yaml_loader'
    end
  end
end
