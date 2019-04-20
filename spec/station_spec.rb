require 'spec_helper'

include StationType

RSpec.describe Station do
  let(:max_fare) {10}
  context 'when the user swipes at the entry' do
    let(:card) {double(Card, debit: true)}
    let(:boarding_station) {Station.new("A", BUS, nil)}

    it 'should debit max possible fare for the journey' do
      expect(FareCalculator).to receive(:max_fare).with(BUS).and_return(max_fare)

      allow(card).to receive(:boarding_station=)
      expect(card).to receive(:debit).with(max_fare)

      boarding_station.entry_swipe(card)
    end

    it 'should set the boarding station' do
      expect(FareCalculator).to receive(:max_fare).with(BUS).and_return(max_fare)

      expect(card).to receive(:boarding_station=).with(boarding_station)

      boarding_station.entry_swipe(card)
    end
  end

  context 'when the user swipes at the exit' do
    let(:actual_fare) {7}
    let(:boarding_station) {Station.new("A", TUBE, [ONE])}
    let(:deboarding_station) {Station.new("B", TUBE, [TWO])}
    let(:card) {double(Card, debit: true, credit: true, boarding_station: boarding_station)}

    it 'should rollback previous max fare and debit actual fare' do
      expect(FareCalculator).to receive(:max_fare).with(TUBE).and_return(max_fare)
      expect(FareCalculator).to receive(:compute).with(boarding_station, deboarding_station).and_return(actual_fare)

      expect(card).to receive(:credit).with(max_fare)
      expect(card).to receive(:debit).with(7)

      deboarding_station.exit_swipe(card)
    end
  end
end