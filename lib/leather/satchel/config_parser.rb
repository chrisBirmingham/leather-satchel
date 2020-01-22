# frozen_string_literal: true

module Leather
  module Satchel
    class ConfigParser
      # @param loader [Loader]
      def initialize(loader)
        @loader = loader
      end

      # @param path [String]
      # @return [Config]
      def parse_file(path)
        data = @loader.load_file(path)
        require_libs = get_require_libs(data)
        parameters = get_parameters(data)
        services = get_services(data)

        Config.new(parameters, services, require_libs)
      end

      protected

      # @param data [Hash]
      # @return [Array]
      def get_require_libs(data)
        return [] if data['require'].nil?

        require_libs = data['require']
        raise 'Required libraries must be an array' unless require_libs.is_a?(Array)

        require_libs
      end

      # @param data [Hash]
      # @return [Hash]
      def get_parameters(data)
        return {} if data['parameters'].nil?

        params = {}
        data['parameters'].each do |key, value|
          params[key] = value
        end

        params
      end

      # @param data [Hash]
      # @return [Hash]
      def get_services(data)
        return {} if data['services'].nil?

        services = {}
        data['services'].each do |key, definition|
          raise "Service class has not been defined for service #{key}" if definition['class'].nil?

          unless definition['arguments'].nil?
            arguments = definition['arguments']
            raise "Arguments for service definition #{key} is not an array" unless arguments.is_a?(Array)
          end

          unless definition['calls'].nil?
            calls = definition['calls']
            raise "Calls definition for service #{key} must be an array" unless calls.is_a?(Hash)
          end

          services[key] = definition
        end

        services
      end
    end
  end
end
