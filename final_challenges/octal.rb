require 'pry'
require 'pry-byebug'


class Octal
  def initialize(string)
    @octal_string = string
  end

  def to_decimal
    sum = 0
    # binding.pry
    reversed = @octal_string.chars.reverse
    reversed.each_with_index do |digit, dex|
      return 0 unless valid?(digit)
      # binding.pry
      sum += digit.to_i * (8 ** (dex))
    end
    sum
  end

  def valid?(char)
    char.match?(/[0-7]/)
  end
end