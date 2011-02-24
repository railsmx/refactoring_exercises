module Fillers
  module CrossingMethod

    class << self
      # Fills a magic square by crossing method
      def fill!(square)
        max = square.size ** 2
        current = 1
        0.upto(square.size - 1) do |row|
          0.upto(square.size - 1) do |column|
            if is_crossed?(row, column)
              square[row][column] = current
            else
              square[row][column] = max - current + 1
            end
            current += 1
          end
        end
      end

     private

      def is_crossed?(row, column)
        (row % 4 == 0 || row % 4 == 3) == (column % 4 == 0 || column % 4 == 3)
      end

    end

  end
end