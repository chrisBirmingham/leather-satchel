# frozen_string_literal: true

module Leather
  module Satchel
    class ContainerBuilder
      # ContainerBuilder Constructor
      # @param service_resolver [ServiceResolver]
      # @param parameter_resolver [ParameterResolver]
      def initialize(service_resolver, parameter_resolver)
        @service_resolver = service_resolver
        @parameter_resolver = parameter_resolver
      end

      # @param config [Hash]
      # @param container [Container]
      def build(config, container)
        config.parameters.each do |key, value|
          container[key] = value
        end

        config.services.each do |key, definition|
          container[key] = lambda { |c|
            cls = Object.const_get(definition['class'])

            obj = cls.new(*definition['arguments'])

            unless definition['calls'].nil?
              definition['calls'].each do |func|
                f = func['method']
                args = func['arguments']
                obj.public_send(f, *args)
              end
            end

            obj
          }
        end
      end
    end
  end
end
