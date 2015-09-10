require "test_helper"
require "minitest/autorun"

module Currency
  class Change
    attr_reader :quarters, :nickles, :dimes, :pennies
    @amount = 0

    def initialize(q, d, n, p)
      @quarters = q
      @dimes = d
      @nickles = n
      @pennies = p
    end

    def self.get_coins(value)
      coins = @amount / value
      @amount = @amount % value
      coins
    end

    def self.make_change(amount)
      @amount = amount
      quarters = get_coins(25)
      dimes = get_coins(10)
      nickles = get_coins(5)
      pennies = get_coins(1)

      Change.new(quarters, dimes, nickles, pennies)
    end
  end
end

class TestMakeChange < Minitest::Test
  include Currency
  def test_just_quarters
    # $1.00
    change = Change.make_change(100)
    assert_equal 4, change.quarters
    assert_equal 0, change.dimes
    assert_equal 0, change.nickles
    assert_equal 0, change.pennies
  end

  def test_just_dimes
    change = Change.make_change(20)
    assert_equal 0, change.quarters
    assert_equal 2, change.dimes
    assert_equal 0, change.nickles
    assert_equal 0, change.pennies
  end

  def test_just_nickles
    change = Change.make_change(5)
    assert_equal 0, change.quarters
    assert_equal 0, change.dimes
    assert_equal 1, change.nickles
    assert_equal 0, change.pennies
  end

  def test_just_pennies
    change = Change.make_change(4)
    assert_equal 0, change.quarters
    assert_equal 0, change.dimes
    assert_equal 0, change.nickles
    assert_equal 4, change.pennies
  end

  def test_all
    change = Change.make_change(92)
    assert_equal 3, change.quarters
    assert_equal 1, change.dimes
    assert_equal 1, change.nickles
    assert_equal 2, change.pennies
  end
end
