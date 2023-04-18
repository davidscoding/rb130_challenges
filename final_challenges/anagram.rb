# For example, given the word "listen" and a list of candidates
# like "enlists", "google", "inlets", and "banana", the
# program should return a list containing "inlets".
# Please read the test suite for the exact rules of 
# anagrams.

# Input: anagram word + array of potential strings
# capitalization doesnt matter
# assume strings
# letters rearranged 

# Output: array of valid strings

# D

# array
# string sorted

# a

# initialize
# sorted string array

# match
# select valid strings

# valid?
# split + lowercase + sort
# compare

class Anagram
  def initialize(string)
    @string = string
    @comparison_sorted_arr = string.downcase.chars.sort
  end

  def match(array)
    array.select{|word| valid?(word)}
  end

  private

  def valid?(word)
    return false if @string.downcase == word.downcase
    char_arr = word.downcase.chars.sort
    @comparison_sorted_arr == char_arr
  end
end