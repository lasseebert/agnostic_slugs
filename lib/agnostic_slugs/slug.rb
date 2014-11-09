module AgnosticSlugs
  class Slug
    attr_reader :original, :counter

    def self.step(name, &block)
      new(name).step(&block)
    end

    def initialize(original, counter = 1)
      @original = original
      @counter  = counter
    end

    def next
      self.class.new(original, counter + 1)
    end

    def step
      instance = self
      loop do
        break if yield(instance.to_s)
        instance = instance.next
      end
      instance.to_s
    end

    def to_s
      @slug ||= generate
    end

    private

    def generate
      result = original
      result = result.downcase
      result = replace_accents(result)
      result = result.gsub(/[\s_\-]+/, '-')
      result = result.gsub(/[^a-z0-9\-]/, '')

      # Remove leading and trailing dash
      result = result.sub(/^-/, '').sub(/-$/, '')

      if counter > 1
        "#{result}-#{counter}"
      else
        result
      end
    end

    def replace_accents(string)
      # This was originally taken from https://github.com/ericboehs/to_slug
      # Thanks, ericboehs :)

      # Define which accents map to which ascii characters
      accents = {
        'aa'  => %w(å),
        'a'   => %w(à á â ã ā ă ȧ ä ả ǎ ȁ ȃ ą ạ ḁ ẚ ầ ấ ẫ ẩ ằ ắ ẵ ẳ ǡ ǟ ǻ ậ ặ),
        'ae'  => %w(æ ǽ ǣ),
        'b'   => %w(ḃ ɓ ḅ ḇ ƀ ƃ ƅ),
        'c'   => %w(ć ĉ ċ č ƈ ç ḉ),
        'd'   => %w(ḋ ɗ ḍ ḏ ḑ ḓ ď đ ƌ ȡ),
        'e'   => %w(è é ê ẽ ē ĕ ė ë ẻ ě ȅ ȇ ẹ ȩ ę ḙ ḛ ề ế ễ ể ḕ ḗ ệ ḝ ɛ),
        'f'   => %w(ḟ ƒ),
        'g'   => %w(ǵ ĝ ḡ ğ ġ ǧ ɠ ģ ǥ),
        'h'   => %w(ĥ ḣ ḧ ȟ ƕ ḩ ḫ ẖ ħ),
        'i'   => %w(ì í î ĩ ī ĭ ı ï ỉ ǐ į į ȋ ḭ ɨ ḯ),
        'ij'  => %w(ĳ),
        'j'   => %w(ĵ ǰ),
        'k'   => %w(ḱ ǩ ƙ ḳ ķ),
        'l'   => %w(ĺ ḻ ḷ ļ ḽ ľ ŀ ł ƚ ḹ ȴ),
        'm'   => %w(ḿ ṁ ṃ ɯ),
        'n'   => %w(ǹ ń ñ ṅ ň ŋ ɲ ṇ ņ ṋ ṉ ŉ ȵ),
        'o'   => %w(ò ó ô õ ō ŏ ȯ ö ỏ ő ǒ ȍ ȏ ơ ǫ ọ ɵ ồ ố ỗ ổ ȱ ȫ ȭ ṍ ṏ ṑ ṓ ờ ớ ỡ ở ợ ǭ ộ ǿ ɔ),
        'oe'  => %w(œ ø),
        'p'   => %w(ṕ ṗ ƥ),
        'r'   => %w(ŕ ṙ ř ȑ ȓ ṛ ŗ ṟ ṝ),
        's'   => %w(ś ŝ ṡ š ṣ ș ş ṥ ṧ ṩ ß ſ ẛ),
        't'   => %w(ṫ ẗ ť ƭ ʈ ƫ ṭ ț ţ ṱ ṯ ŧ ȶ),
        'u'   => %w(ù ú û ũ ū ŭ ü ủ ů ű ǔ ȕ ȗ ư ụ ṳ ų ṷ ṵ ṹ ṻ ǖ ǜ ǘ ǖ ǚ ừ ứ ữ ử ự),
        'v'   => %w(ṽ ṿ),
        'w'   => %w(ẁ ẃ ŵ ẇ ẅ ẘ ẉ),
        'x'   => %w(ẋ ẍ),
        'y'   => %w(ỳ ý ŷ ỹ ȳ ẏ ÿ ỷ ẙ ƴ ỵ),
        'z'   => %w(ź ẑ ż ž ȥ ẓ ẕ ƶ),

        # Not sure what to do with these
        ''    => %w(Ð Þ Ə Ɣ Ɩ Ƣ Ƨ Ʃ Ʊ Ʒ Ǯ Ƹ Ȝ ƿ Ȣ ð þ ə ɣ ɩ ƣ ƨ ʃ ƪ ʊ ʒ ǯ ƹ ƺ ȝ Ƿ ȣ Ǳ ǲ ǳ Ǆ ǅ ǆ Ǉ ǈ ǉ Ǌ ǋ ǌ ĸ ƍ ƛ ƾ ƻ Ƽ ƽ)
      }

      accents.each do |replacement, accent|
        regex = Regexp.new("[#{accent.join("|")}]")
        string = string.gsub(regex, replacement)
      end
      string
    end
  end
end
