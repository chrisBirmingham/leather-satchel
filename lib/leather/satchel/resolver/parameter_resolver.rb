# frozen_string_literal: true

module Leather
  module Satchel
    module Resolver
      class ParameterResolver
        PARAMETER_TOKEN = '%'
        SERVICE_TOKEN = '@'

        private_constant :PARAMETER_TOKEN, :SERVICE_TOKEN

        # @param parameters [Hash]
        # @param parameter [Object]
        # @return [Object]
        # @raise [Error::UnknownParameterError]
        def resolve(parameters, parameter)
          return parameter unless parameter.is_a?(String) || parameter.is_a?(Array)

          # Don't process services
          return parameter if parameter[0] == SERVICE_TOKEN

          return resolve_array(parameters, parameter) if (parameter.is_a?(Array) || parameter.is_a?(Hash))

          replace_parameter(parameters, parameter)
        end

        protected

        # @param global_parameters [Hash]
        # @param parameters [Array]
        # @raise [Error::UnknownParameterError]
        def resolve_array(global_parameters, parameters)
          p parameters
          parameters.map! do |param|
            param.is_a?(Array) || param.is_a?(Hash) ? resolve_array(global_parameters, param) : resolve(global_parameters, param)
          end
          parameters
        end

        # Replaces all references to parameters in a parameter value
        # @param parameters [Hash]
        # @param parameter [String]
        # @return [String]
        # @raise [Error::UnknownParameterError]
        def replace_parameter(parameters, parameter)
          return parameter if parameter.index(PARAMETER_TOKEN).nil?

          until parameter.index(PARAMETER_TOKEN).nil?
            index = parameter.index(PARAMETER_TOKEN) + 1
            last_index = parameter.index(PARAMETER_TOKEN, index)
            parameter_name = parameter[index...last_index]

            raise Error::UnknownParameterError, parameter_name unless parameters.key?(parameter_name)

            parameter = parameter.gsub("\%#{parameter_name}\%", parameters[parameter_name])
          end
          parameter
        end
      end
    end
  end
end
