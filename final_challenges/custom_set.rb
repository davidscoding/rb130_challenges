require 'pry'
require 'pry-byebug'


class CustomSet
  def initialize(arr = [])
    @set = arr.uniq.sort
  end

  def intersection(other)
    intersection_arr = @set.select { |val| other.contains?(val) }
    CustomSet.new(intersection_arr)
  end

  def difference(other)
    @set = @set.reject { |val| other.contains?(val) }
    self
  end

  def union(other)
    @set += other.set
    @set = @set.uniq.sort
    self
  end

  def add(val)
    @set << val
    @set = @set.uniq.sort
    self
  end

  def contains?(val)
    @set.include?(val)
  end

  def empty?
    @set.empty?
  end

  def subset?(other)
    @set.all? do |val|
      other.contains?(val)
    end
  end

  def disjoint?(other)
    !@set.any? do |val|
      other.contains?(val)
    end
  end

  def eql?(other)
    @set == other.set
  end

  alias :== :eql?

  protected

  attr_reader :set
end

