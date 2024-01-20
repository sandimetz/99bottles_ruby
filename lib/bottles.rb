class CountdownSong
  attr_reader :verse_template, :max, :min

  def initialize(verse_template:, max: 999999, min: 0)
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
    verse_template.lyrics(number)
  end
end


class BottleVerse
  def self.lyrics(number)
    new(BottleNumber.new(number)).lyrics
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
  attr_reader :number
  def initialize(number)
    @number = number
  end

  def to_s
    "#{quantity} #{container}"
  end

  def quantity
    BOTTLE_NUMBER_DEFAULTS[number]&.[](:quantity) || number.to_s
  end

  def container
    BOTTLE_NUMBER_DEFAULTS[number]&.[](:container) || "bottles"
  end

  def action
    BOTTLE_NUMBER_DEFAULTS[number]&.[](:action) || "Take #{pronoun} down and pass it around"
  end

  def pronoun
    BOTTLE_NUMBER_DEFAULTS[number]&.[](:pronoun) || "one"
  end

  def successor
    BOTTLE_NUMBER_DEFAULTS[number]&.[](:successor) ?  BottleNumber.new(BOTTLE_NUMBER_DEFAULTS[number]&.[](:successor)) : BottleNumber.new(number - 1)
  end
end

BOTTLE_NUMBER_DEFAULTS = {
  0 => {
    quantity: "no more",
    action: "Go to the store and buy some more",
    successor: 99
  },
  1 => {
    container: "bottle",
    pronoun: "it"
  },
  6 => {
    quantity: "1",
    container: "six-pack"
  }
}

pp BOTTLE_NUMBER_DEFAULTS[9]&.[](:quantity)