# Input
# Wrong input?
# Edge Cases
# Empty input?
# Caps?

# Output
# Return value
# Side effects
#   Output
#   Mutation?


class Series
  def initialize(string)
    @string = string
  end

  def slices(sub_length)
    raise ArgumentError.new "Invalid sublength" if @string.length < sub_length
    @string.chars.map(&:to_i).each_cons(sub_length).to_a
  end
end