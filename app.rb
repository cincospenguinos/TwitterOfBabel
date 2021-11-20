require 'sinatra'
require 'json'
require 'base64'

get '/' do
  erb :index
end

# https://api.twitter.com/1.1/account_activity/all/prod/webhooks is our magic endpoint
get '/webhooks/twitter' do
  if params['crc_token']
    digest = OpenSSL::HMAC.digest('sha256', ENV['TOB_SECRET'], params['crc_token'])
    response_token = Base64.encode64(digest)

    {
      response_token: "sha256=#{response_token}".chomp
    }.to_json
  else
    {}.to_json
  end
end

post '/webhooks/twitter' do
  request.body.rewind
  puts request.body.read.inspect
end