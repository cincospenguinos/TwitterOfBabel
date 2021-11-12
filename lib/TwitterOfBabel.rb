# frozen_string_literal: true
require 'twitter'
require 'yaml'

require_relative "TwitterOfBabel/version"
require_relative "TwitterOfBabel/babel_tweet"
require_relative "TwitterOfBabel/address_extractor"

module TwitterOfBabel
  class TwitterOfBabel
    def respond_to_tweets
      client = twitter_client
      tweets = client.mentions_timeline
        .map { |t| { addr: AddressExtractor.new(t.full_text), tweet: t} }
        .select { |h| h[:addr].valid? && h[:tweet].user.screen_name }
        .reject { |h| previous_tweets.include?(h[:tweet].id) }
        .map { |h|
          h.merge({ tweet_text: BabelTweet.new(h[:addr].to_s).response_to(h[:tweet].user.screen_name) })
        }

      tweets.each do |t|
        twitter_client.update(t[:tweet_text])
        previous_tweets << t[:tweet].id
      end

      save_previous_tweets
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

    def previous_tweets
      @previous_tweets ||= []
    end

    def save_previous_tweets
      File.open(ENV['TOB_MEMOIZE_FILE'], 'w') do |f|
        f.write(previous_tweets.to_yaml)
      end
    end
  end
end
