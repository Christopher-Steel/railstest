require 'test_helper'

class FizzBuzzNumberTest < ActiveSupport::TestCase
  CHECKS = [
    [3, 'Fizz'],
    [5, 'Buzz'],
    [15, 'FizzBuzz'],
    [1, '1'],
    [999999, 'Fizz'],
    [300000, 'FizzBuzz'],
    [100000000000000000000, 'Buzz'] # extra zeros for good measure
  ].freeze

  CHECKS.each do |number, expected|
    test "#{number} returns #{expected}" do
      assert_equal(FizzBuzzNumber.new(number).to_s, expected)
    end
  end
end
