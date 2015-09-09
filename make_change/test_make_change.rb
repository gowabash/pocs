require "minitest/autorun"

module Currency
  def make_change(amount)
    quarters = amount / 25
    {
     :quarters => quarters,
     :dimes => 0,
     :nickles => 0,
     :pennies => 0
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
end
