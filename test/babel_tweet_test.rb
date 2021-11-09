# frozen_string_literal: true

require "test_helper"

class BabelTweetTest < Minitest::Test
  def test_creates_tweet_160_chars
    t = TwitterOfBabel::BabelTweet.new('some_key')
    assert_equal 160, t.to_s.size
  end
end