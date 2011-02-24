!SLIDE

# The process #

!SLIDE bullets incremental

# The process

* TESTS!
* Good use of control version systems
* Small refactorings. Only one change at a time

!SLIDE

# Refactoring patterns #

!SLIDE smaller code

# Extract-ing (methods, classes) #

    @@@ruby
    def print_slide
      puts "<h1> #{@title} </h1>"
      puts "<p> #{@contents} </p>"
    end

###becomes:

    @@@ruby
    def print_slide
      print_title
      print_contents
    end

    def print_title
      # ...
    end

    def print_contents
      # ...
    end

!SLIDE smaller code

# Introduce variables - split code #

    @@@ruby
    def calculate_total(quantity, price)
      quantity * price * 1.16 -
            (quantity > 100 ? quantity * (price * 0.05) : 0)
    end

###becomes:

    @@@ruby
    def calculate_total(quantity, price)
      subtotal = quantity * price
      taxed_subtotal = subtotal * 1.16
      if quantity > 100
        taxed_subtotal -= subtotal * 0.05
      end
      taxed_subtotal
    end

!SLIDE smaller code

# Rename magic methods / variables #

    @@@ruby
    def calculate_total(quantity, price)
      subtotal = quantity * price
      taxed_subtotal = subtotal * TAX_RATE
      if quantity > 100
        taxed_subtotal -= subtotal * VOLUME_DISCOUNT
      end
      taxed_subtotal
    end

!SLIDE smaller code

# Move responsibilities (1) #

    @@@ruby
    def print_slide(format)
      if format == PLAIN
        puts @title
        puts @contents
      elsif format == HTML
        puts "<h1> #{@title} </h1>"
        puts "<p> #{@contents} </p>"
      end
    end

!SLIDE smaller code

# Move responsibilities (2) #

### becomes:

    @@@ruby
    def print_slide(format)
      renderer = RENDERERS[format]
      renderer.print_slide(slide)
    end

    class PlainRenderer
      def print_slide(slide)
        puts slide.title
        puts slide.contents
      end
    end

    class HTMLRenderer
      def print_slide(slide)
        puts "<h1> #{@title} </h1>"
        puts "<p> #{@contents} </p>"
      end
    end

!SLIDE smaller code

# Encapsulating data / behavior (1) #

    @@@ruby
    def show_person_info(attributes)
      puts "Name: #{attributes[:name]}"
      puts "Birthday: #{attributes[:birthday]}"
      puts "Age: #{(Date.today - attributes[:birthday]).in_years}"
      puts "Telephone: #{attributes[:telephone]}"
    end

    show_person_info(
        :name => "John Doe",
        :birthday => Date.parse("10/05/1988"),
        :telephone => "123-4567"
    )

!SLIDE smaller code

# Encapsulating data / behavior (2) #

    @@@ruby
    def show_person_info(person)
      puts "Name: #{person.name}"
      puts "Birthday: #{person.birthday}"
      puts "Age: #{person.age}"
      puts "Telephone: #{person.telephone}"
    end

    class Person
      def initialize(attributes)
        # ...
      end

      def birthday
        # ...
      end
    end

    john = Person.new(
        :name => "John Doe",
        :birthday => Date.parse("10/05/1988"),
        :telephone => "123-4567"
    )
    show_person_info(john)

!SLIDE smaller

# Many other refactorings:

## Simplify complicated conditionals
## Remove derived attributes
## Replace primitives with objects (like Exceptions)
## Replace inheritance with delegation
## Change visibility of properties / methods
### etc... Only practice will provide all of them