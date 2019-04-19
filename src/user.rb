require './card'

class User
  attr_reader :name, :card

  def initialize(name)
    @name = name
  end

  def buy_card(amount)
    @card = Card.new(amount)
  end

  def swipe_card(card)
    puts "Swiping Card" + card.to_s
  end

  def enter_station(station)
    puts "#{@name} entered #{station.name} station"
    station.entry_swipe(card)
  end

  def exit_station(station)
    puts "#{@name} exited #{station.name} station"
    station.exit_swipe(card)
  end
end