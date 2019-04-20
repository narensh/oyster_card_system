Dir[File.join(__dir__, "**/*.rb")].each {|file| require File.expand_path(file) unless file.include?("card_system.rb") }

include StationType
include Zone

RELOAD_AMOUNT = 30

HOLBORN_TUBE_STATION = Station.new("Holborn", TUBE, [ONE])
EARL_COURT_TUBE_STATION = Station.new("Earl’s Court", TUBE, [ONE, TWO])
WIMBLEDON_TUBE_STATION = Station.new("Wimbledon", TUBE, [THREE])
HAMMERSMITH_TUBE_STATION = Station.new("Hammersmith", TUBE, [TWO])

HOLBORN_BUS_STATION = Station.new("Holborn", BUS, nil)
EARL_COURT_BUS_STATION = Station.new("Earl’s Court", BUS, nil)
WIMBLEDON_BUS_STATION = Station.new("Wimbledon", BUS, nil)
HAMMERSMITH_BUS_STATION = Station.new("Hammersmith", BUS, nil)

class CardSystem
  def demo
    user = User.new("Traveler1")
    card = user.buy_card(RELOAD_AMOUNT)

    user.enter_station(HOLBORN_TUBE_STATION)
    user.exit_station(EARL_COURT_TUBE_STATION)

    user.enter_station(EARL_COURT_BUS_STATION)
    user.exit_station(WIMBLEDON_BUS_STATION)

    user.enter_station(EARL_COURT_TUBE_STATION)
    user.exit_station(HAMMERSMITH_TUBE_STATION)

    user.enter_station(EARL_COURT_TUBE_STATION)
    user.exit_station(WIMBLEDON_TUBE_STATION)

    puts "card - balance " + card.balance.to_s
  end
end

card_system = CardSystem.new
card_system.demo()