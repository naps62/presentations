#!/usr/bin/env ruby

require 'benchmark'
GC.disable

class WithDefaultAccessor
  attr_accessor :x
end

class WithCustomAccessor
  def x
    @x
  end

  def x=(value)
    @x = value
  end
end

Benchmark.bm do |bench|
  bench.report "default reader:" do
    instance = WithDefaultAccessor.new
    1000000.times { instance.x }
  end

  bench.report "custom reader: " do
    instance = WithCustomAccessor.new
    1000000.times { instance.x }
  end

  bench.report "default writer:" do
    instance = WithDefaultAccessor.new
    1000000.times { instance.x = 0 }
  end

  bench.report "custom writer: " do
    instance = WithCustomAccessor.new
    1000000.times { instance.x = 0 }
  end
end
