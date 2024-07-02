class Bottles
    def verse(number)
      "#{bottles(number)} of beer on the wall, #{bottles(number)} of beer.\n" \
      "Take one down and pass it around, #{bottles(number - 1)} of beer on the wall.\n"
    end
  
    private
  
    def bottles(number)
      "#{number} bottle#{'s' unless number == 1}"
    end
  end