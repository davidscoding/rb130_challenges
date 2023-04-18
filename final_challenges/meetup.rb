# p

# create a class that is initialized with the year and date
# class has a day instance method that takes in string (weekday, number)
#   method returns a date object corresponding to the day
#   caps are not important
#   returns nill if day doesn;t exist

# options : Monday - Sunday, first second third fourth fifth last teenth

# e

# we saw

# D

# int for month and year
# weekdays array of strings
# descriptors array of strings
# Date objects

# A

# initialized
# month + year
# start_day = first weekday num

# day(weekday, descriptor)
# check if valid
# call descriptor method(weekday)

# first(weekday)
# gap
# return first weekday date object

# etc.

# fifth
# gap + 28
# return nil if doesn't exist

# gap(weekday)
# convert to integer
# (target - start_day) % 7 + 1

require 'date'
require 'pry'
require 'pry-byebug'

class Meetup
  WEEKDAYS = %w(sunday monday tuesday wednesday thursday friday saturday)
  DESCRIPTORS = %w(first second third fourth fifth teenth last)

  def initialize(year, month)
    @year = year
    @month = month
    @first_day = Date.new(year, month, 1).wday
  end

  def day(weekday, descriptor)
    return nil unless WEEKDAYS.include?(weekday.downcase)
    return nil unless DESCRIPTORS.include?(descriptor.downcase)

    send(descriptor.downcase.to_sym, WEEKDAYS.index(weekday.downcase))
  end

  def first(weekday)
    simple_date = gap(weekday)
    Date.new(@year, @month, simple_date)
  end

  def second(weekday)
    simple_date = gap(weekday) + 7
    Date.new(@year, @month, simple_date)
  end

  def third(weekday)
    simple_date = gap(weekday) + 14
    Date.new(@year, @month, simple_date)
  end

  def fourth(weekday)
    simple_date = gap(weekday) + 21
    Date.new(@year, @month, simple_date)
  end

  def fifth(weekday)
    simple_date = gap(weekday) + 28
    if Date.valid_date?(@year, @month, simple_date)
      return Date.new(@year, @month, simple_date)
    end
    nil
  end

  def teenth(weekday)
    simple_date = gap(weekday) + 7
    simple_date += 7 if simple_date < 13
    Date.new(@year, @month, simple_date)
  end

  def gap(weekday)
    ( weekday - @first_day ) % 7 + 1
  end

  def last(weekday)
    return fifth(weekday) if fifth(weekday)
    fourth(weekday)
  end
end










