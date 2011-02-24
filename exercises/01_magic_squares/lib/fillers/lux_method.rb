module Fillers
  module LuxMethod

    class << self

      # Fill by LUX method
      def fill!(square)
        # Build an odd magic square and fill the new one based on it
        # according to the LUX method
        helper_square = MagicSquare.new(square.size / 2)
        0.upto(helper_square.size - 1) do |helper_square_row|
          0.upto(helper_square.size - 1) do |helper_square_column|
            fill_four_by_four_square(square, helper_square, helper_square_row, helper_square_column)
          end
        end
      end

      def fill_four_by_four_square(square, helper_square, helper_square_row, helper_square_column)
        n = (helper_square[helper_square_row, helper_square_column] - 1) * 4 + 1
        block_numbers = n.upto(n + 3).to_a
        order = case shape_for(helper_square_row, helper_square_column, helper_square.size)
          when :L
            [3, 0, 1, 2]
          when :U
            [0, 3, 1, 2]
          when :X
            [0, 3, 2, 1]
        end
        square[helper_square_row * 2][helper_square_column * 2]         = block_numbers[order[0]]
        square[helper_square_row * 2][helper_square_column * 2 + 1]     = block_numbers[order[1]]
        square[helper_square_row * 2 + 1][helper_square_column * 2]     = block_numbers[order[2]]
        square[helper_square_row * 2 + 1][helper_square_column * 2 + 1] = block_numbers[order[3]]
      end

      def shape_for(helper_square_row, helper_square_column, helper_square_size)
        middle = helper_square_size / 2
        if helper_square_row < middle
          :L
        elsif helper_square_row == middle
          helper_square_column == middle ? :U : :L
        elsif helper_square_row == middle + 1
          helper_square_column == middle ? :L : :U
        else
          :X
        end
      end

    end

  end
end