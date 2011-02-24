#! /usr/bin/ruby

# Refactoring Exercise for Rails.mx group meeting
# 24 / 02 / 2011
# Original rescued from http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/252561,
# added test suite.
#
# ================================

# Ruby quiz 124 - Magic Squares
# Author: Ruben Medellin

require File.dirname(__FILE__) + '/ext/array'
require File.dirname(__FILE__) + '/lib/fillers/siamese_method'
require File.dirname(__FILE__) + '/lib/fillers/crossing_method'
require File.dirname(__FILE__) + '/lib/fillers/lux_method'

class MagicSquare

  # Validates the size, and then fills the grid according to its size.
  # For reference, see Weisstein, Eric W. "Magic Square." From MathWorld--A Wolfram Web Resource.
  # http://mathworld.wolfram.com/MagicSquare.html
  def initialize(size)
    raise ArgumentError if size < 3
    @grid = Array.new(size){ Array.new(size) }
    filler = if size.odd?
      Fillers::SiameseMethod
    elsif size % 4 == 0
      Fillers::CrossingMethod
    else
      Fillers::LuxMethod
    end
    filler.fill!(@grid)
  end

  # Gets the value at the position x, y in the square, or nil if out of bounds
  def [](x, y)
    row = @grid[x]
    row[y] if row
  end

  def size
    @grid.size
  end

  def to_s
    result = ""
    max_length = (size ** 2).to_s.length # Length of the biggest number (e.g., in a 10x10 square is "100.length" => 3)
    row_separator = '+' + ("-" * (max_length + 2) + "+") * size
    @grid.each do |row|
      result << row_separator << "\n|"
      row.each{|number| result << " " + ("%#{max_length}d" % number) + " |"}
      result << "\n"
    end
    result << row_separator
  end

end

