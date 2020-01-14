# frozen_string_literal: true

module Leather
  module Satchel
    module Error
      autoload :UnknownIdentifierError, 'leather/satchel/error/unknown_identifier_error'
      autoload :InvalidFactoryError, 'leather/satchel/error/invalid_factory_error'
    end
  end
end
