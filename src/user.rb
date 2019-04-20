class User
  attr_reader :name, :card

  def initialize(name)
    @name = name
  end

  def buy_card(amount)
    @card = Card.new(amount)
  end

  def enter_station(station)
    station.entry_swipe(card)
  end

  def exit_station(station)
    station.exit_swipe(card)
  end
end