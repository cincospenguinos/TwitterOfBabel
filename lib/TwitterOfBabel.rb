# frozen_string_literal: true
require 'twitter'

require_relative "TwitterOfBabel/version"
require_relative "TwitterOfBabel/babel_tweet"
require_relative "TwitterOfBabel/address_extractor"

module TwitterOfBabel
  class TwitterOfBabel
    def twitter_client
      @twitter_client ||= Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['TOB_API_KEY']
        config.consumer_secret = ENV['TOB_SECRET']
        config.access_token = ENV['TOB_ACCESS']
        config.access_token_secret = ENV['TOB_ACCESS_SECRET']
      end
    end

    def respond_to_tweets
      twitter_client.update('This is a tweet from #TwitterOfBabel')
    end
  end
end
