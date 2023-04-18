# Problem: Convert integers 1-3000 to roman Roman Numerals

# Input: Integer (1-3000)
# Output: Roman Numeral

# D

# Backwards sorted 2 element sub array array Dictionary

# A

# initialize
# remaining value






class RomanNumeral
  DICTIONARY = {1000 => 'M', 500 => 'D', 100 => 'C', 50 => 'L', 10 => 'X', 5 => 'V', 1 => 'I'}
  DIGITS = DICTIONARY.keys.sort.reverse

  def initialize(val)
    @val = val
  end

  def to_roman
    string = ""
    remaining_val = @val
    index = 0

    while remaining_val > 0
      digit, remaining_val = remaining_val.divmod(DIGITS[index])
      modifier = 1
      change, digit = digit.divmod(5)
      modifier += change
      if digit == 4
        string += DICTIONARY[DIGITS[index]] + DICTIONARY[DIGITS[index - modifier]]
      else
        string += DICTIONARY[DIGITS[index - 1]] * change + (DICTIONARY[DIGITS[index]]) * digit
      end
      index += 2
    end

    string
  end
end