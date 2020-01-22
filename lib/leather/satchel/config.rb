# frozen_string_literal: true

module Leather
  module Satchel
    class Config
      attr_reader :parameters, :services, :require_libs

      # @param parameters [Hash]
      # @param services [Hash]
      # @param require_libs [Array]
      def initialize(parameters, services, require_libs)
        @parameters = parameters
        @services = services
        @require_libs = require_libs
      end
    end
  end
end
