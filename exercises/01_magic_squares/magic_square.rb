#! /usr/bin/ruby

# Refactoring Exercise for Rails.mx group meeting
# 24 / 02 / 2011
# Original rescued from http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/252561,
# added test suite.
#
# ================================

# Ruby quiz 124 - Magic Squares
# Author: Ruben Medellin

class Array
  def sum
    inject(0){|a,v|a+=v}
  end
end

class MagicSquare

  attr_accessor :grid
  SHAPES = {:L => [3, 0, 1, 2], :U => [0, 3, 1, 2], :X => [0, 3, 2, 1]}

  # Validates the size, and then fills the grid
  # according to its size.
  # For reference, see
  # Weisstein, Eric W. "Magic Square." From MathWorld--A Wolfram Web Resource.
  # http://mathworld.wolfram.com/MagicSquare.html
  def initialize(n)
    raise ArgumentError if n < 3
    @grid = Array.new(n){ Array.new(n) }
    if n % 2 != 0
      initialize_odd(n)
    else
      if n % 4 == 0
        initialize_double_even(n)
      else
        initialize_single_even(n)
      end
    end
  end

  def [](x, y)
    row = @grid[x]
    row[y] if row
  end

  def to_s
    result = ""
    n = @grid.size
    space = (n**2).to_s.length
    sep = '+' + ("-" * (space+2) + "+") * n
    @grid.each do |row|
      result << sep << "\n|"
      row.each{|number| result << " " + ("%#{space}d" % number) + " |"}
      result << "\n"
    end
    result << sep
  end

  private

  # Fill by crossing method
  def initialize_double_even(n)
    current = 1
    max = n**2
    for x in 0...n
      for y in 0...n
        if is_diag(x) == is_diag(y)
          @grid[x][y] = current
        else
          @grid[x][y] = max - current + 1
        end
        current += 1
      end
    end
  end

  def is_diag(n)
    n % 4 == 0 || n % 4 == 3
  end

  # Fill by LUX method
  def initialize_single_even(n)
    # Build an odd magic square and fill the new one based on it
    # according to the LUX method
    square = MagicSquare.new(n/2)
    m = (n+2)/4
    for x in 0...(n/2)
      for y in 0...(n/2)
        if(x < m)
          shape = (x == m-1 and x == y) ? :U : :L
          fill(x, y, square[x,y], shape)
        elsif ( x == m )
          shape = (x == y+1) ? :L : :U
          fill(x, y, square[x,y], shape)
        else
          fill(x, y, square[x,y], :X)
        end
      end
    end
  end

  def fill(x, y, number, shape)
    number = ((number-1) * 4) + 1
    numbers = [* number...(number + 4)]
    @grid[x*2][y*2] = numbers[ SHAPES[shape][0] ]
    @grid[x*2][y*2+1] = numbers[ SHAPES[shape][1] ]
    @grid[x*2+1][y*2] = numbers[ SHAPES[shape][2] ]
    @grid[x*2+1][y*2+1] = numbers[ SHAPES[shape][3] ]
  end

  # Fill by Kraitchik method
  def initialize_odd(n)
    x, y = 0, n/2
    for i in 1..(n**2)
      @grid[x][y] = i
      x = (x-1)%n
      y = (y+1)%n
      # If the new square is not empty, return to the inmediate empty
      # square below the former.
      unless @grid[x][y].nil?
        x = (x+2)%n
        y = (y-1)%n
      end
    end
  end

end

