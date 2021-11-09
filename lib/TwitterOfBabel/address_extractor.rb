module TwitterOfBabel
  class AddressExtractor
    ADDRESS_REGEX = /0x[a-f0-9]{1,195}/

    attr_reader :address

    def initialize(input_tweet)
      @address = input_tweet.scan(ADDRESS_REGEX).last || ''
    end

    def valid?
      !address.empty?
    end

    def to_s
      address
    end
  end
end
