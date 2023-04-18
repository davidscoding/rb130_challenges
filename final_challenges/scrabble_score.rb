# Problem:

# Score Strings with each letter having a certain score as defined

# Anything other than a string is 0
# Any characters other then the scoring characters are 0
# Cap insensitive

# D

# Hash with key = letters array, value = value

# A

# Create Character_Score hash

# initialize
# initialize uppercase string

# score
# initialize score = 0
# unless type string return score
# for each character
#   score += value(character)
# end

# value(char)
#   each key in hash
#     if key includes character return hash[key]
#   return 0
# end

class Scrabble
  CHAR_VALUES = { %w(A E I O U L N R S T) =>	1,
    %w(D G) =>	2,
    %w(B C M P) =>	3,
    %w(F H V W Y) =>	4,
    %w(K) =>	5,
    %w(J X) =>	8,
    %w(Q Z) => 10 }

  def initialize(string)
    @string = string
  end

  def self.score(string)
    self.new(string).score
  end

  def score
    return 0 unless @string.is_a?(String)
    
    str_score = 0
    comparison_str = @string.upcase

    comparison_str.each_char do |char|
      str_score += value(char)
    end

    str_score
  end

  def value(char)
    CHAR_VALUES.each_key do |key|
      return CHAR_VALUES[key] if key.include?(char)
    end

    0
  end
end