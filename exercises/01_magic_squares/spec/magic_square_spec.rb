require File.join(File.dirname(__FILE__), '../../../spec_helper.rb')
require File.join(File.dirname(__FILE__), '../magic_square')

module MagicSquareHelper

  # Validates that a magic square of size `size` has the values
  # specified by `array` in left to right, top to bottom order.
  # Ex:
  #  a square +---+---+---+
  #           | 8 | 1 | 6 |
  #           +---+---+---+
  #           | 3 | 5 | 7 |
  #           +---+---+---+
  #           | 4 | 9 | 2 |
  #           +---+---+---+
  # will validate true with
  #     validate_square_values(square, 3, [8, 1, 6, 3, 5, 7, 4, 9, 2])
  #
  def validate_square_values(square, size, array)
    values = array.dup.reverse
    0.upto(size - 1) do |row|
      0.upto(size - 1) do |col|
        square[row, col].should be == values.pop
      end
    end
  end

  def validate_square_is_magic(square, size)
    magic_number = (size * (size**2 + 1)) / 2 # Formula for the "magic number" of a square
    for row in 0...size
      # The sum of row `row`
      (0...size).map { |col| square[row, col] }.sum.should be == magic_number
    end
    for col in 0...size
      # The sum of column `col`
      (0...size).map { |row| square[row, col] }.sum.should be == magic_number
    end
    # The diagonal going top-left to bottom-right
    (0...size).map { |i| square[i, i] }.sum.should be == magic_number
    # The diagonal going bottom-left to top-right
    (0...size).map { |i| square[size - i - 1, i] }.sum.should be == magic_number
  end
end

describe MagicSquare do

  include MagicSquareHelper

  it "should not accept values lesser than 3" do
    -1.upto(2) do |size|
      expect { MagicSquare.new(size) }.to raise_error
    end
    expect { MagicSquare.new(3).to_not raise_error }
  end

  describe "behaving like a grid" do
    before { @square = MagicSquare.new(4) }
    subject { @square }
    it "should allow to get valid coordinates" do
      @square[0, 0].should_not be_nil
      @square[0, 3].should_not be_nil
      @square[3, 0].should_not be_nil
      @square[3, 3].should_not be_nil
    end

    it "should return nil on tiles outside the square" do
      @square[4, 0].should be_nil
      @square[0, 4].should be_nil
    end
  end

  describe "generating even sized squares" do
    it "should build double-even sized squares by crossing method" do
      square = MagicSquare.new(4)
      validate_square_values(square, 4,
        [
           1, 15, 14,  4,
          12,  6,  7,  9,
           8, 10, 11,  5,
          13,  3,  2, 16
        ]
      )
    end

    it "should build single-even sized squares by LUX method" do
      square = MagicSquare.new(6)
      validate_square_values(square, 6,
        [
          32, 29,  4,  1, 24, 21,
          30, 31,  2,  3, 22, 23,
          12,  9, 17, 20, 28, 25,
          10, 11, 18, 19, 26, 27,
          13, 16, 36, 33,  5,  8,
          14, 15, 34, 35,  6,  7
        ]
      )
    end
  end

  describe "generating odd sized squares" do
    it "should build odd size squares by Kraitchick method" do
      square = MagicSquare.new(5)
      validate_square_values(square, 5,
        [
          17, 24,  1,  8, 15,
          23,  5,  7, 14, 16,
           4,  6, 13, 20, 22,
          10, 12, 19, 21,  3,
          11, 18, 25,  2,  9
        ]
      )
    end
  end

  describe "'magic' of Magic Squares" do
    it "should validate magic properties of squares" do
      validate_square_is_magic(MagicSquare.new(4), 4)
      validate_square_is_magic(MagicSquare.new(5), 5)
      validate_square_is_magic(MagicSquare.new(6), 6)
    end
  end

  describe "displaying data" do
    it "should return a tabulated display of the data" do
      square = MagicSquare.new(6)
      square.to_s.should be == <<-SQUARE.strip
+----+----+----+----+----+----+
| 32 | 29 |  4 |  1 | 24 | 21 |
+----+----+----+----+----+----+
| 30 | 31 |  2 |  3 | 22 | 23 |
+----+----+----+----+----+----+
| 12 |  9 | 17 | 20 | 28 | 25 |
+----+----+----+----+----+----+
| 10 | 11 | 18 | 19 | 26 | 27 |
+----+----+----+----+----+----+
| 13 | 16 | 36 | 33 |  5 |  8 |
+----+----+----+----+----+----+
| 14 | 15 | 34 | 35 |  6 |  7 |
+----+----+----+----+----+----+
      SQUARE
    end
  end

end