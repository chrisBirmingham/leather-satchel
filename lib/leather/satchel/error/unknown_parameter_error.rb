# frozen_string_literal: true

module Leather
  module Satchel
    module Error
      # Error raised if the requested identifier is not known by the container
      class UnknownParameterError < StandardError
        # UnknownIdentifierError constructor
        # @param parameter [String]
        def initialize(parameter)
          message = "Unknown referenced parameter #{parameter}"
          super(message)
        end
      end
    end
  end
end
