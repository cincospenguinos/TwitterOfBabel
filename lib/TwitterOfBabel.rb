# frozen_string_literal: true
require 'twitter'

require_relative "TwitterOfBabel/version"
require_relative "TwitterOfBabel/babel_tweet"
require_relative "TwitterOfBabel/address_extractor"

module TwitterOfBabel
  class TwitterOfBabel
    def respond_to_tweets
      twitter_client.mentions_timeline
        .map { |t| { addr: AddressExtractor.new(t.full_text), tweet: t} }
        .select { |h| h[:addr].valid? && h[:tweet].user.screen_name }
        .map { |h| twitter_client.favorite(h[:tweet]) ; BabelTweet.new(h[:addr].to_s).response_to(h[:tweet].user.screen_name) }
        .each { |t| twitter_client.update(t) }
    end

    private

    def twitter_client
      @twitter_client ||= Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['TOB_API_KEY']
        config.consumer_secret = ENV['TOB_SECRET']
        config.access_token = ENV['TOB_ACCESS']
        config.access_token_secret = ENV['TOB_ACCESS_SECRET']
      end
    end
  end
end
