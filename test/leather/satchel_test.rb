# frozen_string_literal: true

require 'leather/satchel'
require 'minitest/autorun'
require 'ostruct'

module Leather
  class SatchelTest < Minitest::Test
    def setup
      @container = Leather::Satchel::Container.new(
        value1: 1,
        value2: 2,
        value4: 4,
        value5: [],
        value6: proc {
          Leather::Satchel::Container.new
        },
        struct: lambda { |c|
          OpenStruct.new(val1: c[:value1], val2: c[:value2])
        }
      )
    end

    def test_can_get_value1
      assert_equal 1, @container[:value1]
    end

    def test_throw_exception_on_invalid_index
      assert_raises Leather::Satchel::Error::UnknownIdentifierError do
        @container[:value3]
      end
    end

    def test_can_get_object_value
      assert_instance_of Array, @container[:value5]
    end

    def test_caching_services
      container = @container[:value6]
      container2 = @container[:value6]
      assert_equal container, container2
    end

    def test_container_is_passed_to_service
      obj = @container[:struct]
      assert_equal 1, obj.val1
      assert_equal 2, obj.val2
    end

    def test_factory_services_dont_cache
      @container[:value7] = @container.factory(proc {
        Leather::Satchel::Container.new
      })

      container = @container[:value7]
      container2 = @container[:value7]
      refute_equal container, container2
    end

    def test_invalid_factory_service
      assert_raises Leather::Satchel::Error::InvalidFactoryError do
        @container[:invalid] = @container.factory('i am not a valid factory service')
      end
    end

    def test_delete_service
      refute_nil @container[:value4]
      @container.remove(:value4)
      assert_raises Leather::Satchel::Error::UnknownIdentifierError do
        @container[:value4]
      end
    end
  end
end
