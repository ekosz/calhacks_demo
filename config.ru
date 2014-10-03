require File.expand_path('../config/environment', __FILE__)

require 'rack/cache'
if memcachier_servers = ENV['MEMCACHIER_SERVERS']
  cache = Dalli::Client.new memcachier_servers.split(','), {
    username: ENV['MEMCACHIER_USERNAME'],
    password: ENV['MEMCACHIER_PASSWORD']
  }

  use Rack::Cache,
    :verbose => true,
    :metastore => cache,
    :entitystore => cache
else
  use Rack::Cache,
    :verbose     => true,
    :metastore   => 'file:tmp/cache/rack/meta',
    :entitystore => 'file:tmp/cache/rack/body'
end

run Springtee::Web
