module TwitterOfBabel
  class AddressExtractor
    ADDRESS_REGEX = /[^a-z0-9]/i
    ACCEPTED_CHARS = /\A[a-z0-9]+\z/

    attr_reader :address

    def initialize(input_tweet)
      @address = input_tweet.downcase.gsub(/\s+/, '').gsub(ADDRESS_REGEX, '')
    end

    def valid?
      !address.empty? && address =~ ACCEPTED_CHARS
    end

    def to_s
      address
    end
  end
end
