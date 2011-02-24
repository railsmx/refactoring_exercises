module Fillers
  module SiameseMethod

    class << self

      # Fills a MagicSquare with the Siamese Method, also known as Kraitchik method
      def fill!(square)
        size = square.size
        x, y = 0, size / 2 # Start at the middle top square
        1.upto(size ** 2) do |i|
          square[x][y] = i

          # Move up right
          x = (x - 1) % size
          y = (y + 1) % size
          # If the new square is not empty, return to the inmediate empty
          # square below the former.
          unless square[x][y].nil?
            x = (x + 2) % size
            y = (y - 1) % size
          end
        end
      end

    end

  end
end