# frozen_string_literal: true
require 'twitter'
require 'yaml'

require_relative "TwitterOfBabel/version"
require_relative "TwitterOfBabel/babel_tweet"
require_relative "TwitterOfBabel/address_extractor"

module TwitterOfBabel
  class TwitterOfBabel
    def initialize(opts = {})
      @consumer_key = opts[:consumer_key]               || ENV['TOB_API_KEY']
      @consumer_secret = opts[:consumer_secret]         || ENV['TOB_SECRET']
      @access_token = opts[:access_token]               || ENV['TOB_ACCESS']
      @access_token_secret = opts[:access_token_secret] || ENV['TOB_ACCESS_SECRET']
    end

    def respond_to(text, tweet_id, screen_name)
      address = AddressExtractor.new(text)
      return not_valid_address(screen_name, tweet_id) unless address.valid? && screen_name

      b_tweet = BabelTweet.new(address.to_s).response_to(screen_name)
      twitter_client.update(b_tweet, in_reply_to_status_id: tweet_id)
      true
    end

    private

    def twitter_client
      @twitter_client ||= Twitter::REST::Client.new do |config|
        config.consumer_key        = @consumer_key
        config.consumer_secret     = @consumer_secret
        config.access_token        = @access_token
        config.access_token_secret = @access_token_secret
      end
    end

    def not_valid_address(screen_name, tweet_id)
      tweet.update("@#{screen_name} the address you provided is invalid.",
        in_reply_to_status_id: tweet_id)
    end
  end
end
