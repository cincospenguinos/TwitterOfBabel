module TwitterOfBabel
  MAX_TWEET_LENGTH = 160

  class BabelTweet
    CHARS = 'abcdefghijklmnopqrstuvwxyz., '

    attr_reader :prepped_rando

    def initialize(address)
      @address = address.to_i(16)
      @prepped_rando = Random.new(@address)
      @str = ''
    end

    def to_s
      while @str.length < TwitterOfBabel::MAX_TWEET_LENGTH do
        idx = prepped_rando.rand(CHARS.length)
        @str += CHARS[idx]
      end
      
      @str
    end
  end
end
