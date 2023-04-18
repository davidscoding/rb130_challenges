# Problem:

# Find the number of non - matching characters between two sequences.
# check over the shorter of the two sequences lengths

# Input: String initialized
# Edge cases: Dont worry about invalid inputs

# Outputs
# Return integer distance


# Data structures:

# Object DNA
# Comparison string

# Algorithms

# initialize
# set strand to string

# hamming distance:

# set distance to 0
# get smaller length of two strings
# iterate over string
#   compare at each index
#     if different, increment distance
    # break if at max comparison index
# return distance

class DNA
  def initialize(strand)
    @strand = strand
  end

  def hamming_distance(other_strand)
    distance = 0
    max_index = [other_strand.length, @strand.length].min - 1

    @strand.chars.each_with_index do |base, index|
      unless base == other_strand[index]
        distance += 1
      end
      break if max_index == index
    end

    distance
  end
end
