class CountdownSong
  attr_reader :verse_template, :max, :min

  def initialize(verse_template:, max: verse_template.max, min: verse_template.min)
    @verse_template = verse_template
    @max, @min = max, min
  end

  def song
    verses(max, min)
  end

  def verses(upper, lower)
    upper.downto(lower).collect {|i| verse(i)}.join("\n")
  end

  def verse(number)
    verse_template.lyrics(number, max: max)
  end
end


class BottleVerse
  class << self
    def max
      99
    end

    def min
      0
    end

    def lyrics(number, max: self.max)
      new(BottleNumber.for(number, max: max)).lyrics
    end
  end

  attr_reader :bottle_number

  def initialize(bottle_number)
    @bottle_number = bottle_number
  end

  def lyrics
    "#{bottle_number} of beer on the wall, ".capitalize +
    "#{bottle_number} of beer.\n" +
    "#{bottle_number.action}, " +
    "#{bottle_number.successor} of beer on the wall.\n"
  end
end


class BottleNumber
  def self.for(number, max:)
    case number
    when 0
      BottleNumber0
    when 1
      BottleNumber1
    when 6
      BottleNumber6
    else
      BottleNumber
    end.new(number, max: max)
  end

  attr_reader :number, :max
  def initialize(number, max:)
    @number = number
    @max = max
  end

  def to_s
    "#{quantity} #{container}"
  end

  def quantity
    number.to_s
  end

  def container
    "bottles"
  end

  def action
    "Take #{pronoun} down and pass it around"
  end

  def pronoun
    "one"
  end

  def successor
    BottleNumber.for(number - 1, max: max)
  end
end

class BottleNumber0 < BottleNumber
  def quantity
    "no more"
  end

  def action
    "Go to the store and buy some more"
  end

  def successor
    BottleNumber.for(max, max: max)
  end
end

class BottleNumber1 < BottleNumber
  def container
    "bottle"
  end

  def pronoun
    "it"
  end
end

class BottleNumber6 < BottleNumber
  def quantity
    "1"
  end

  def container
    "six-pack"
  end
end
