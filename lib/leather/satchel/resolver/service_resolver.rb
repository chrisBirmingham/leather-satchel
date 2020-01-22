# frozen_string_literal: true

module Leather
  module Satchel
    module Resolver
      class ServiceResolver
        SERVICE_TOKEN = '@'

        private_constant :SERVICE_TOKEN

        # @param container [Container]
        # @param service [String]
        # @return [Object]
        def resolve(container, service)
          if service[0] == '@'
            service = service[1...service.length]
            return container[service]
          end

          service
        end
      end
    end
  end
end
