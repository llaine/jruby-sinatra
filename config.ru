require 'bundler'
Bundler.require

require 'lib/stocks'

class App < Sinatra::Base
  post '/stockify' do
    response.headers['Transfer-Encoding'] = 'chunked'
    async = env['java.servlet_request'].start_async
    text = request.body.read.to_s

    Thread.new do
      begin
        puts "Thread(async)! #{Thread.current.object_id}"
        stocks = Stocks.parse_for_stocks(text)
        quotes = Stocks.get_quotes(stocks)
        new_text = Stocks.sub_quotes(text, quotes)
        async.response.output_stream.println(new_text)
      ensure
        async.complete
      end
    end
    puts "Thread(main) #{Thread.current.object_id}"

  end
end

run App
