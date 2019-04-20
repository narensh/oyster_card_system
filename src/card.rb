include Util

# TODO2 a lot to fix in this class
class Card
  attr_reader :balance

  INSUFFICIENT_FUNDS_ERROR = 'INSUFFICIENT FUNDS ERROR'

  def initialize(amount)
    @balance = amount | 0
  end

  # TODO2 should have deduct method only
  def debit(amount)
    if @balance >= amount
      @balance -= amount

    else
      raise INSUFFICIENT_FUNDS_ERROR
    end
  end

  def set_boarding_station(station)
    @boarding_station = station
  end

  # TODO2 here
  def credit(amount)

  end

  def make_max_transaction(station)

  end

  def rollback_max_transaction
    @balance += MAX_FARE
  end

  # TODO2 Move out of here
  def compute_cost_for_journey
    fare = FareCalculator.compute(@boarding_station, @deboarding_station)
    puts "Fare Deducted - " + fare.to_s
    fare
  end

  def make_actual_transaction(deboarding_station)
    rollback_max_transaction
    @deboarding_station = deboarding_station
    @balance -= compute_cost_for_journey
    refresh_station_details
  end

  def refresh_station_details
    @boarding_station = @deboarding_station = nil
  end
end