require 'sinatra'
require 'json'
require 'base64'

get '/' do
  erb :index
end

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
  if request.body.size > 0
    request.body.rewind
    req = JSON.parse(request.body.read)

    req['tweet_create_events'].each do |tweet|
      next if tweet['user']['screen_name'] == ENV['TOB_SCREEN_NAME']
      TwitterOfBabel.new.respond_to(tweet['text'], tweet['id'], tweet['user']['screen_name'])
    end
  end

  {}.to_json
end