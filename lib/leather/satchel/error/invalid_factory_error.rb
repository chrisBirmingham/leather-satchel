# frozen_string_literal: true

module Leather
  module Satchel
    module Error
      # Error raised if the provided factory is not the correct type
      class InvalidFactoryError < StandardError
        # InvalidFactoryError constructor
        # @param type [String]
        def initialize(type)
          message = "Invalid factory service of type #{type} provided. Must be either a lambda or proc"
          super(message)
        end
      end
    end
  end
end
