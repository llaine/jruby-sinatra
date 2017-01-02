require_relative "../lib/stocks.rb"
require "test/unit"

class TestSimpleNumber < Test::Unit::TestCase
  def test_parse_for_stocks
    assert_equal(["AAPL"], Stocks.parse_for_stocks("Apple Inc"))
    assert_equal(["MSFT"], Stocks.parse_for_stocks("Microsoft"))

    two_stocks = Stocks.parse_for_stocks("Microsoft and Apple").sort
    assert_equal(2, two_stocks.size)
    assert_equal("AAPL", two_stocks[0])
    assert_equal("MSFT", two_stocks[1])
  end

  def test_get_quotes
    assert_equal([], Stocks.get_quotes([]))

    aapl = Stocks.get_quotes(["AAPL"])
    assert_equal(1, aapl.size)
    assert_equal(4, aapl[0].size)
    assert_equal("AAPL", aapl[0][0])

    aapl = Stocks.get_quotes(["AAPL", "MU"])
    assert_equal(2, aapl.size)
    assert_equal(4, aapl[0].size)
    assert_equal("AAPL", aapl[0][0])
    assert_equal(4, aapl[1].size)
    assert_equal("MU", aapl[1][0])
  end
end
