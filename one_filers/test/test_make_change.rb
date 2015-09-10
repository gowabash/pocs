require "test_helper"
require "minitest/autorun"

module Currency
  def make_change(amount)
    quarters = amount / 25
    left_over = amount % 25
    dimes = left_over / 10
    left_over = left_over % 10
    nickles = left_over / 5
    pennies = left_over % 5
    {
     :quarters => quarters,
     :dimes => dimes,
     :nickles => nickles,
     :pennies => pennies
    }
  end
end

class TestMakeChange < Minitest::Test
  include Currency
  def test_just_quarters
    # $1.00
    change = make_change(100)
    assert_equal 4, change[:quarters]
    assert_equal 0, change[:dimes]
    assert_equal 0, change[:nickles]
    assert_equal 0, change[:pennies]
  end

  def test_just_dimes
    change = make_change(20)
    assert_equal 0, change[:quarters]
    assert_equal 2, change[:dimes]
    assert_equal 0, change[:nickles]
    assert_equal 0, change[:pennies]
  end

  def test_just_nickles
    change = make_change(5)
    assert_equal 0, change[:quarters]
    assert_equal 0, change[:dimes]
    assert_equal 1, change[:nickles]
    assert_equal 0, change[:pennies]
  end

  def test_just_pennies
    change = make_change(4)
    assert_equal 0, change[:quarters]
    assert_equal 0, change[:dimes]
    assert_equal 0, change[:nickles]
    assert_equal 4, change[:pennies]
  end

  def test_all
    change = make_change(92)
    assert_equal 3, change[:quarters], "quarters wrong"
    assert_equal 1, change[:dimes], "dimes wrong"
    assert_equal 1, change[:nickles], "nickles wrong"
    assert_equal 2, change[:pennies], "pennies wrong"
  end
end
