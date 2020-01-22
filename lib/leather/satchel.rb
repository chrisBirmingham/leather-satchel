# frozen_string_literal: true

module Leather
  module Satchel
    autoload :Container, 'leather/satchel/container'
    autoload :VERSION, 'leather/satchel/version'
    autoload :Error, 'leather/satchel/error'

    autoload :Config, 'leather/satchel/config'
    autoload :ConfigParser, 'leather/satchel/config_parser'
    autoload :Loader, 'leather/satchel/loader'
    autoload :Resolver, 'leather/satchel/resolver'
    autoload :ContainerBuilder, 'leather/satchel/container_builder'
    autoload :LeatherSatchel, 'leather/satchel/leather_satchel'
  end
end
