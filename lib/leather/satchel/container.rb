# frozen_string_literal: true

module Leather
  module Satchel
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

      # Checks if a given @key exists in the container
      # @param key [String|Symbol] The name we are checking
      # @return [Boolean]
      def contain?(key)
        @keys.key?(key)
      end

      # Inserts a service into the container under the name @key
      # @param key [String|Symbol] The name of the value, service or factory
      # @param value [Object] The object to store against @key
      def []=(key, value)
        @keys[key] = true
        @values[key] = value
      end

      # Gets a value, service or factory from the container
      # @param key [String|Symbol] The name of the service to look for
      # @return [Object] The stored service value
      # @raise [Error::UnknownIdentifierError] If the container doesn't contain
      #   the requested key
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
      # @raise [Error::InvalidFactoryError] If the provided factory is not a Proc
      def factory(service)
        raise Error::InvalidFactoryError, service.class unless service.is_a?(Proc)

        @factories << service
        service
      end

      # Deletes a stored value, service or factory from the container if it exists
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
