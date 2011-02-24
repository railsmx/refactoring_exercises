# Extensions to the core Array class
class Array

  # Returns the sum of all items in array.
  # They must respond to the :+ (plus) method and must be able to be added each other
  def sum
    inject(0) { |acum, item| acum + item }
  end
  
end