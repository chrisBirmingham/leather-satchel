# frozen_string_literal: true

module Leather
  module Satchel
    autoload :VERSION, 'leather/satchel/version'
    autoload :Error, 'leather/satchel/error'

    # IOC Container Class
    class Container
      # Container constructor
      # @param values [Hash]
      def initialize(values = {})
        @keys = {}
        @values = {}
        @cached_services = {}
        @factories = []

        values.each do |key, value|
          self[key] = value
        end
      end

      # Inserts a service into the container under the name @key
      # @param key [String|Symbol] The name of the service
      # @param value [Any] The value of the container
      def []=(key, value)
        @keys[key] = true
        @values[key] = value
      end

      # Gets a service from the container
      # @param key [String|Symbol] The name of the service to look for
      # @return [Any] The stored service value
      # @throw Error::UnknownIdentifierError
      def [](key)
        raise Error::UnknownIdentifierError, key unless @keys.key?(key)

        service = @values[key]
        return service.call(self) if @factories.include?(service)

        if service.is_a?(Proc)
          return @cached_services[key] if @cached_services.key?(key)

          value = service.call(self)
          @cached_services[key] = value
          return value
        end

        service
      end

      # Defines a factory service
      # @param service [Proc]
      # @return [Proc]
      def factory(service)
        raise Error::InvalidFactoryError, service.class unless service.is_a?(Proc)

        @factories << service
        service
      end

      # Deletes a stored service from the container if it exists
      # @param key [String|Symbol]
      def remove(key)
        return unless @keys.key?(key)

        service = @values.delete(key)
        @factories.delete(service)
        @keys.delete(key)
        @cached_services.delete(key)
      end

      # Clears all stored services from the container
      def clear
        @keys.clear
        @values.clear
        @cached_services.clear
        @factories.clear
      end
    end
  end
end
