# frozen_string_literal: true

module Leather
  module Satchel
    module Error
      # Error to be raised if an identifier is unknown
      class UnknownIdentifierError < StandardError
        # UnknownIdentifierError constructor
        # @param identifier [String]
        def initialize(identifier)
          message = "Unknown service identifier #{identifier}"
          super(message)
        end
      end
    end
  end
end
