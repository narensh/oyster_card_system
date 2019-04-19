require_relative '../zone'
include Zone

module Util
  class FareCalculator

    def self.compute(boarding_station, deboarding_station)
      return FARES[:BUS] if (boarding_station.type == BUS)

      zones_covered = zones_covered(boarding_station, deboarding_station)
      return FARES[boarding_station.type.to_sym][zones_covered.sort]
    end

    private

    FARES = {
        TUBE: {
            [ONE] => 2.50,
            [TWO] => 2.00,
            [THREE] => 2.00,
            [ONE, TWO] => 3.00,
            [ONE, THREE] => 3.00,
            [TWO, THREE] => 2.25,
            [ONE, TWO, THREE] => 3.20
        },
        BUS: 1.80
    }

    def self.zones_covered(boarding_station, deboarding_station)
      common_zones = boarding_station.zones & deboarding_station.zones
      return common_zones if common_zones.size > 0
      return boarding_station.zones + deboarding_station.zones
    end
  end
end