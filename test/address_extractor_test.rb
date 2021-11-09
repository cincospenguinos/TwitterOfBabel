# frozen_string_literal: true

require "test_helper"

class AddressExtractorTweetTest < Minitest::Test
  def test_accepts_a_valid_address
    assert TwitterOfBabel::AddressExtractor.new('0xffaabbcc11002299').valid?
  end

  def test_extracts_valid_address_in_tweet
    addr = TwitterOfBabel::AddressExtractor.new('What is #TwitterOfBabel? Do I type 0xffabc?')
    assert addr.valid?
    assert_equal '0xffabc', addr.to_s
  end

  def test_rejects_invalid_address
    refute TwitterOfBabel::AddressExtractor.new('no').valid?
    refute TwitterOfBabel::AddressExtractor.new('No address here.').valid?
  end
end