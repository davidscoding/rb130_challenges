# Problem
# make diamond (we saw examples)
# assume valid input (char, uppercase)

# output:
# return string

# class method of class Diamond.

# Data Structures

# Array of rows

# make_diamond(letter)
#   return A if A
#   array = []
#   width = gap(Letter) + 2
#   (A...letter)
#     array << make_row of current
#   (letter..A)
#     array << make_row of current
#   return array.join(\n)
# end

# make_row(Letter, width)
#   letter.center(width if A)
#   (letter + gap(letter) + letter).center(width)
# end

# gap(letter)
#   (A..Z).to_a.index(letter) * 2 - 1
# end


class Diamond
  def self.make_diamond(letter)
    width = self.gap(letter) + 2
    rows = ('A'..letter).to_a + ('A'...letter).to_a.reverse
    rows.map { |letter| self.row(letter, width) }.join
  end

  def self.row(letter, width)
    return 'A'.center(width) + "\n" if letter == 'A'
    (letter + ' ' * self.gap(letter) + letter).center(width) + "\n"
  end

  def self.gap(letter)
    ('A'..'Z').to_a.index(letter) * 2 - 1
  end

  private_class_method :gap, :row
end

puts Diamond.make_diamond("Y")