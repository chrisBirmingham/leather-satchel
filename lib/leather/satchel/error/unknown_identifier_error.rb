# frozen_string_literal: true

module Leather
  module Satchel
    module Error
      # Error raised if the requested identifier is not known by the container
      class UnknownIdentifierError < StandardError
        # UnknownIdentifierError constructor
        # @param identifier [String|Symbol]
        def initialize(identifier)
          message = "Unknown service identifier #{identifier}"
          super(message)
        end
      end
    end
  end
end
