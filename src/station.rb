class Station
  attr_reader :name, :type, :zones

  def initialize(name, type, zones)
    @name = name
    @type = type
    @zones = zones
  end

  def entry_swipe(card)
    card.boarding_station = self
    card.debit(max_fare)
  end

  def exit_swipe(card)
    card.credit(max_fare)
    card.debit(actual_fare(card.boarding_station))
  end

  private

  def max_fare
    FareCalculator.max_fare(@type)
  end

  def actual_fare(boarding_station)
    FareCalculator.compute(boarding_station, self)
  end
end