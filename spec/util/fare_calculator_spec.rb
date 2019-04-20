require_relative '../spec_helper'

include StationType

RSpec.describe FareCalculator do
  context :max_fare do
    context 'BUS Journey' do
      it 'should return the max possible fare' do
        max_fare = FareCalculator.max_fare(BUS)

        expect(max_fare).to eq(1.8)
      end
    end

    context 'TUBE Journey' do
      it 'should return the max possible fare' do
        max_fare = FareCalculator.max_fare(TUBE)

        expect(max_fare).to eq(3.2)
      end
    end
  end

  context :compute do
    context 'BUS Journey' do
      let(:boarding_station) {double('Station', name: 'A', type: BUS)}
      let(:deboarding_station) {double('Station', name: 'B', type: BUS)}

      it 'should compute the fare' do
        actual_fare = FareCalculator.compute(boarding_station, deboarding_station)

        expect(actual_fare).to eq(1.8)
      end
    end

    context 'TUBE Journey' do
      context 'when travel within zone 1' do
        let(:boarding_station) {double('Station', name: 'A', type: TUBE, zones: [ONE])}
        let(:deboarding_station) {double('Station', name: 'B', type: TUBE, zones: [ONE, TWO])}

        it 'should compute the fare' do
          actual_fare = FareCalculator.compute(boarding_station, deboarding_station)

          expect(actual_fare).to eq(2.5)
        end
      end

      context 'when travel within zone 2' do
        let(:boarding_station) {double('Station', name: 'A', type: TUBE, zones: [TWO])}
        let(:deboarding_station) {double('Station', name: 'B', type: TUBE, zones: [TWO])}

        it 'should compute the fare' do
          actual_fare = FareCalculator.compute(boarding_station, deboarding_station)

          expect(actual_fare).to eq(2.00)
        end
      end

      context 'when travel within zone 3' do
        let(:boarding_station) {double('Station', name: 'A', type: TUBE, zones: [THREE])}
        let(:deboarding_station) {double('Station', name: 'B', type: TUBE, zones: [THREE])}

        it 'should compute the fare' do
          actual_fare = FareCalculator.compute(boarding_station, deboarding_station)

          expect(actual_fare).to eq(2.00)
        end
      end

      context 'when travel within zone 1 and 2' do
        let(:boarding_station) {double('Station', name: 'A', type: TUBE, zones: [ONE])}
        let(:deboarding_station) {double('Station', name: 'B', type: TUBE, zones: [TWO])}

        it 'should compute the fare' do
          actual_fare = FareCalculator.compute(boarding_station, deboarding_station)

          expect(actual_fare).to eq(3.00)
        end
      end

      context 'when travel within zone 1 and 3' do
        let(:boarding_station) {double('Station', name: 'A', type: TUBE, zones: [ONE])}
        let(:deboarding_station) {double('Station', name: 'B', type: TUBE, zones: [THREE])}

        it 'should compute the fare' do
          actual_fare = FareCalculator.compute(boarding_station, deboarding_station)

          expect(actual_fare).to eq(3.00)
        end
      end

      context 'when travel within zone 2 and 3' do
        let(:boarding_station) {double('Station', name: 'A', type: TUBE, zones: [TWO])}
        let(:deboarding_station) {double('Station', name: 'B', type: TUBE, zones: [THREE])}

        it 'should compute the fare' do
          actual_fare = FareCalculator.compute(boarding_station, deboarding_station)

          expect(actual_fare).to eq(2.25)
        end
      end

      context 'when travel across zone 1, 2 and 3' do
        let(:boarding_station) {double('Station', name: 'A', type: TUBE, zones: [ONE])}
        let(:deboarding_station) {double('Station', name: 'B', type: TUBE, zones: [TWO, THREE])}

        it 'should compute the fare' do
          actual_fare = FareCalculator.compute(boarding_station, deboarding_station)

          expect(actual_fare).to eq(3.20)
        end
      end
    end
  end
end