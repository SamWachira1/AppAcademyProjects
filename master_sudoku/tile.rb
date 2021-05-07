require "colorize"

class Tile

    attr_reader :value 
    def initialize(value)
        @value = value
        @given = value == 0 ? false : true 
    end

    def color
        given? ? :blue : :red    
    end

    def given?
        @given
    end

    def to_s
        value == 0 ? " " : value.to_s.colorize(color)
    end

    def value=(new_val) 
        if given?
            puts "You cannot change the value of the given tile"
        else
            @value = new_val 
        end
    end
end




