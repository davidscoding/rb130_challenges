# P: create a clock object

# methods: to_s => returns string of format "00:00"
# class method at(hour, min = 0) => returns new clock item of given time
# - takes int as arg (minutes) returns clock object
# + takes int as arg (minutes) returns clock object

# Things to note: wraps arround backwords

# D

# constants: Minutes and HOURS
# time in minutes

class Clock
  include Comparable

  MINUTES = 60
  HOURS = 24
  TOTAL_MINUTES = HOURS * MINUTES

  def initialize(minutes)
    @minutes = minutes
  end

  def self.at(hours = 0, minutes = 0)
    minutes += hours * MINUTES
    minutes %= (TOTAL_MINUTES)
    Clock.new(minutes)
  end

  def to_s
    hr, min = @minutes.divmod(MINUTES)
    sprintf('%02d:%02d', hr, min)
  end

  def -(val)
    Clock.new ((@minutes - val) % TOTAL_MINUTES)
  end
  
  def +(val)
    Clock.new ((@minutes + val) % TOTAL_MINUTES)
  end

  def <=>(other)
    @minutes <=> other.minutes
  end

  protected

  attr_reader :minutes
end