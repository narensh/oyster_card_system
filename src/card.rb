include Util

class Card
  attr_reader :balance
  attr_accessor :boarding_station
  INSUFFICIENT_FUNDS_ERROR = 'INSUFFICIENT_FUNDS_ERROR'

  def initialize(amount)
    @balance = amount || 0
  end

  def debit(amount)
    if @balance >= amount
      @balance -= amount
    else
      raise INSUFFICIENT_FUNDS_ERROR
    end
  end

  def credit(amount)
    @balance += amount
  end
end