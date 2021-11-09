# frozen_string_literal: true

require "test_helper"

class BabelTweetTest < Minitest::Test
  def test_creates_tweet_160_chars
    t = TwitterOfBabel::BabelTweet.new('0xff')
    assert_equal 160, t.to_s.size
  end

  def test_tweets_are_address_dependent
    t1 = TwitterOfBabel::BabelTweet.new('0xab')
    t2 = TwitterOfBabel::BabelTweet.new('0xba')

    assert_equal 160, t1.to_s.size
    assert_equal 160, t2.to_s.size
    refute_equal t1.to_s, t2.to_s
  end
end