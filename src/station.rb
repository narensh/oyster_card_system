class Station
  attr_reader :name, :type, :zones

  def initialize(name, type, zones)
    @name = name
    @type = type
    @zones = zones
  end

  def entry_swipe(card)
    card.make_max_transaction(self)
  end

  def exit_swipe(card)
    card.make_actual_transaction(self)
  end
end