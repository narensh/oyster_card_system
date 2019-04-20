require 'spec_helper'

RSpec.describe User do
  let(:user) {User.new('user1')}

  it 'should create a new user with the given name' do
    expect(user.name).to eq('user1')
  end

  context :buy_card do
    it 'should create a new card with the given balance' do
      card = user.buy_card(20)

      expect(card.balance).to eq(20)
    end
  end

  context :enter_station do
    let (:card) {user.buy_card(20)}
    let (:station) {double(Station, name: 'A', entry_swipe: true)}

    it 'should swipe the card at entry' do
      expect(station).to receive(:entry_swipe).with(card)

      user.enter_station(station)
    end
  end

  context :exit_station do
    let (:card) {user.buy_card(20)}
    let (:station) {double(Station, name: 'B', exit_swipe: true)}

    it 'should swipe the card at exit' do
      expect(station).to receive(:exit_swipe).with(card)

      user.exit_station(station)
    end
  end
end