#---
# Excerpted from "Deploying with JRuby 9k",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jkdepj2 for more book information.
#---
require 'net/http'
require 'csv'

module Stocks

  ALL_NASDAQ_STOCKS = {
    "AAPL" => %r{Apple},
    "MSFT" => %r{Microsoft},
    "MU" => %r{Micron Technology},
    "INTC" => %r{Intel},
    "EBAY" => %r{eBay}
  }

  def self.parse_for_stocks(text)
    ALL_NASDAQ_STOCKS.keys.select.each do |symbol|
      ALL_NASDAQ_STOCKS[symbol] =~ text
    end
  end

  def self.get_quotes(stocks)
    unless stocks.empty?
      Net::HTTP.start("download.finance.yahoo.com") do |http|
        params = stocks.join("+")
        http.request_get("/d/quotes.csv?s=#{params}&f=snab") do |resp|
          return CSV.parse(resp.body)
        end
      end
    end
    return []
  end

  def self.sub_quotes(text, quotes)
    quotes.each do |quote|
      symbol = quote[0]
      pattern = ALL_NASDAQ_STOCKS[symbol]
      text.gsub!(pattern, format_stock(quote))
    end
    text
  end

  def self.format_stock(quote)
    "<div class='stock' data-symbol='#{quote[0]}' data-day-high='#{quote[2]}'>#{quote[1]}</div>"
  end
end
