# Oyster card system (a mini solution to the London's Oyster Card System)

## Steps to execute demo
- Install ruby 1.9+
- Unpack the project zip
- Install bundler if not present by running `gem install bundler`
- Run `bundle install`
- Run `ruby src/card_system.rb`

## To execute tests
- Run `bundle exec rspec`

## To try out different journey add following
- `user.enter_station(boarding_station)`
- `user.enter_station(deboarding_station)`

## To define a new station
- Add `Station.new("Liverpool Square", TUBE, [ONE, TWO])`
> where TUBE is the StationType (TUBE / BUS)

> and [ONE, TWO] are the zones for the station, since it is an array it can be any combination of ONE/TWO/THREE.
