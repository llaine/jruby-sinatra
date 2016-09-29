Warbler::Config.new do |config|
  config.features = %w(executable)
  config.jar_name = 'stock-service'
  config.webxml.servlet_filter_async = true
end
