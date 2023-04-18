# Problem:

# Write a program to determine whether a triangle is equilateral, 
# isosceles, or scalene.

# An equilateral triangle has all three sides the same length.

# An isosceles triangle has exactly two sides of the same length.

# A scalene triangle has all sides of different lengths.

# Note: For a shape to be a triangle at all, all sides must be of length > 0, 
# and the sum of the lengths of any two sides must be greater than the length 
# of the third side.

# Input: 3 integers/floats
# Edge Cases: 0 or negative or doesnt equal triangle => throw argument error integers
# initialization

# Output
# triangle.kind => string for type

# Data Structures:

# Sorted array of values (ints or floats)

# Algorithm

# public:

# kind
# uses sorted, valid array of values
# if unique length = 1 return 'equilateral'
# if unique length = 2 return 'isosceles'
# else return scalene

# Initialize
# loads values into array
# sorts array
# raises exception (Argument Error) unless valid

# valid_triangle?
# false unless checks all values of type float or integer
# false unless checks min is greater than 0
# false unless checks max < other two sides
# returns true

class Triangle
  def initialize(a, b, c)
    @array = [a, b, c].sort
    raise ArgumentError.new "Invalid triangle lengths" unless valid_triangle?
  end

  def kind
    case @array.uniq.length
    when 1 then 'equilateral'
    when 2 then 'isosceles'
    when 3 then 'scalene'
    end
  end

  private 

  def valid_triangle?
    return false unless @array.all? { |val| val.is_a?(Float) || val.is_a?(Integer) }
    return false unless @array[0] > 0
    return false unless @array[0] + @array[1] > @array[2]
    true
  end
end