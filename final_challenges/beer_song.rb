# # Problem:

# # return beer song lyrics based on lyerics and integer input

# # Class Methods:

# # verse(integer) #> just this verse (99) 99 until 98
# # verse(start finish) #start to finish all verses (inclusive)
# # edge cases: 0 and 1 has some funky stuff, will make a guard claus
# # we can check but dont have to

# lyrics
# return verse(99 to 0)

# verse

# return "Invalid entry" unless valid?(first and second)

# if second not nil
#   return multiple_lines(start finish)
# end

# single_line(first)

# private


# multiple_lines(start, end)
#   lyrics = ""
#     iterate start down to second
#       lyrics << single_line
#       lyrics += "\n"
#     return lyrics

# single_line(val)
#   return custom if val 0  
#   current = val
#   upcoming = val == 1 ? "No more" : val - 1
#   interpolated string
# end  

# "3 bottles of beer on the wall, 3 bottles of beer.\n" \
#       "Take one down and pass it around, 2 bottles of beer on the wall.\n"


require 'pry'
require 'pry-byebug'

class BeerSong
  VALID_NUMS = [0..99]

  def self.lyrics
    verses(99, 0)
  end

  def self.verses(start, finish)
    lyrics = []
    start.downto(finish) do |num|
      lyrics << verse(num)
    end
    lyrics.join("\n")
  end

  def self.verse(num)
    # raise StandardError "Invalid number of beers!" unless valid?(num)

    return "No more bottles of beer on the wall, no more bottles of beer.\n" \
    "Go to the store and buy some more, 99 bottles of beer on the wall.\n" if num == 0

    # binding.pry
    current = bottles(num)
    upcoming = bottles(num - 1)
    it = it?(num)

    return "#{current} of beer on the wall, #{current} of beer.\n" \
    "Take #{it} down and pass it around, #{upcoming} of beer on the wall.\n"
  end

  def self.bottles(num)
    case num
    when 1 then "1 bottle"
    when 0 then "no more bottles"
    else "#{num} bottles"
    end
  end

  def self.it?(num)
    return "it" if num == 1
    "one"
  end
  def self.valid?(val)
    VALID_NUMS.include?(val)
  end

  private_class_method :valid?, :bottles
end
