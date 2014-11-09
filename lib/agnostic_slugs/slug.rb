module AgnosticSlugs
  class Slug
    attr_reader :original, :counter

    def initialize(original, counter = 1)
      @original = original
      @counter  = counter
    end

    def next
      self.class.new(original, counter + 1)
    end

    def to_s
      @slug ||= generate
    end

    private

    def generate
      result = original
      result = replace_accents(result)
      result = result.gsub(/[\s_\-]+/, '-')
      result = result.downcase
      result = result.gsub(/[^a-z0-9\-]/, '')

      if counter > 1
        "#{result}-#{counter}"
      else
        result
      end
    end

    def replace_accents(string)
      # This was taken directly from https://github.com/ericboehs/to_slug
      # Thanks, ericboehs :)

      # Define which accents map to which ascii characters
      accents = {
        # Uppercase
        'A'   => %w(À Á Â Ã Ā Ă Ȧ Ả Ä Å Ǎ Ȁ Ȃ Ą Ạ Ḁ Ầ Ấ Ẫ Ẩ Ằ Ắ Ẵ Ẳ Ǡ Ǟ Ǻ Ậ Ặ),
        'AE'  => %w(Æ Ǽ Ǣ),
        'B'   => %w(Ḃ Ɓ Ḅ Ḇ Ƃ Ƅ),
        'C'   => %w(C Ć Ĉ Ċ Č Ƈ Ç Ḉ),
        'D'   => %w(D Ḋ Ɗ Ḍ Ḏ Ḑ Ḓ Ď Đ Ɖ Ƌ),
        'E'   => %w(È É Ê Ẽ Ē Ĕ Ė Ë Ẻ Ě Ȅ Ȇ Ẹ Ȩ Ę Ḙ Ḛ Ề Ế Ễ Ể Ḕ Ḗ Ệ Ḝ Ǝ Ɛ),
        'F'   => %w(Ḟ Ƒ),
        'G'   => %w(Ǵ Ĝ Ḡ Ğ Ġ Ǧ Ɠ Ģ Ǥ),
        'H'   => %w(Ĥ Ḣ Ḧ Ȟ Ƕ Ḥ Ḩ Ḫ Ħ),
        'I'   => %w(Ì Í Î Ĩ Ī Ĭ İ Ï Ỉ Ǐ Ị Į Ȉ Ȋ Ḭ Ɨ Ḯ),
        'IJ'  => %w(Ĳ),
        'J'   => %w(Ĵ),
        'K'   => %w(Ḱ Ǩ Ḵ Ƙ Ḳ Ķ),
        'L'   => %w(Ĺ Ḻ Ḷ Ļ Ḽ Ľ Ŀ Ł Ḹ),
        'M'   => %w(Ḿ Ṁ Ṃ Ɯ),
        'N'   => %w(Ǹ Ń Ñ Ṅ Ň Ŋ Ɲ Ṇ Ņ Ṋ Ṉ Ƞ),
        'O'   => %w(Ò Ó Ô Õ Ō Ŏ Ȯ Ö Ỏ Ő Ǒ Ȍ Ȏ Ơ Ǫ Ọ Ɵ Ø Ồ Ố Ỗ Ổ Ȱ Ȫ Ȭ Ṍ Ṏ Ṑ Ṓ Ờ Ớ Ỡ Ở Ợ Ǭ Ộ Ǿ Ɔ),
        'OE'  => %w(Œ),
        'P'   => %w(Ṕ Ṗ Ƥ),
        'R'   => %w(Ŕ Ṙ Ř Ȑ Ȓ Ṛ Ŗ Ṟ Ṝ Ʀ),
        'S'   => %w(Ś Ŝ Ṡ Š Ṣ Ș Ş Ṥ Ṧ Ṩ),
        'T'   => %w(Ṫ Ť Ƭ Ʈ Ṭ Ț Ţ Ṱ Ṯ Ŧ),
        'U'   => %w(Ù Ú Û Ũ Ū Ŭ Ü Ủ Ů Ű Ǔ Ȕ Ȗ Ư Ụ Ṳ Ų Ṷ Ṵ Ṹ Ṻ Ǜ Ǘ Ǖ Ǚ Ừ Ứ Ữ Ử Ự),
        'V'   => %w(Ṽ Ṿ Ʋ),
        'W'   => %w(Ẁ Ẃ Ŵ Ẇ Ẅ Ẉ),
        'X'   => %w(Ẋ Ẍ),
        'Y'   => %w(Ỳ Ý Ŷ Ỹ Ȳ Ẏ Ÿ Ỷ Ƴ Ỵ),
        'Z'   => %w(Ź Ẑ Ż Ž Ȥ Ẓ Ẕ Ƶ),

        # Lowercase
        'a'   => %w(à á â ã ā ă ȧ ä ả å ǎ ȁ ȃ ą ạ ḁ ẚ ầ ấ ẫ ẩ ằ ắ ẵ ẳ ǡ ǟ ǻ ậ ặ),
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
        'o'   => %w(ò ó ô õ ō ŏ ȯ ö ỏ ő ǒ ȍ ȏ ơ ǫ ọ ɵ ø ồ ố ỗ ổ ȱ ȫ ȭ ṍ ṏ ṑ ṓ ờ ớ ỡ ở ợ ǭ ộ ǿ ɔ),
        'oe'  => %w(œ),
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
