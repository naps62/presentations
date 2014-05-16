#!/usr/bin/env ruby

require 'benchmark'
GC.disable

class WithDefaultReader
  def initialize
    @x = 1
  end

  attr_reader :x
end

class WithCustomReader
  def initialize
    @x = 2
  end

  def x
    @x
  end
end

def large_sum(class_with_x)
  (1..10000000).each do |i|
    class_with_x.x
  end
end

bench_with_reader = Benchmark.measure do
  large_sum(WithCustomReader.new)
end

bench_without_reader = Benchmark.measure do
  large_sum(WithCustomReader.new)
end

puts "WithDefaultReader:"
puts bench_with_reader

puts "WithCustomReader:"
puts bench_without_reader
