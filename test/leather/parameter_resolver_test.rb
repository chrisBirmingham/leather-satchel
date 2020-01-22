# frozen_string_literal: true

require 'leather/satchel'
require 'minitest/autorun'

module Leather
  class ParameterResolverTest < Minitest::Test
    def setup
      @resolver = Leather::Satchel::Resolver::ParameterResolver.new
      @parameters = {
        'param1' => 'hello',
        'param2' => 'world',
        'single_replacement' => '%param1%',
        'multiple_single_replacement' => '%param1% %param1%',
        'different_replacements' => '%param1% %param2%',
        'recursive_replacement' => '%different_replacements%',
        'array' => [
          'hello',
          'world',
          '%param1% %param2%'
        ],
        'hash' => {
          '1' => {
            '1' => '%param1% %param2%'
          }
        }
      }
    end

    def test_resolve_single_replacement
      actual = @resolver.resolve(@parameters, @parameters['single_replacement'])
      assert_equal 'hello', actual
    end

    def test_resolve_multiple_same_replacements
      actual = @resolver.resolve(@parameters, @parameters['multiple_single_replacement'])
      assert_equal 'hello hello', actual
    end

    def test_resolve_multiple_replacements
      actual = @resolver.resolve(@parameters, @parameters['different_replacements'])
      assert_equal 'hello world', actual
    end

    def test_resolve_recursive_parameters
      actual = @resolver.resolve(@parameters, @parameters['recursive_replacement'])
      assert_equal 'hello world', actual
    end

    def test_resolve_array
      actual = @resolver.resolve(@parameters, @parameters['array'])
      assert_equal [], actual
    end

    def test_resolve_hash
      actual = @resolver.resolve(@parameters, @parameters['hash'])
      assert_equal [], actual
    end
  end
end
