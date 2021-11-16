module TwitterOfBabel
  class BabelTweet
    MAX_TWEET_LENGTH = 160
    CHARS = 'abcdefghijklmnopqrstuvwxyz., '

    attr_reader :prepped_rando

    def initialize(address)
      @address = address.to_i(36)
      @prepped_rando = Random.new(@address)
      @str = ''
    end

    def response_to(username)
      "@#{username}\n#{self.to_s}\n#TwitterOfBabel"
    end

    def to_s
      while @str.length < MAX_TWEET_LENGTH do
        idx = prepped_rando.rand(CHARS.length)
        @str += CHARS[idx]
      end
      
      @str
    end
  end
end
