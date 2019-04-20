require 'spec_helper'

RSpec.describe Card do
  context :initialize do
    it 'should create a new card with the given amount' do
      card = Card.new(11)

      expect(card.balance).to eq(11)
    end

    it 'should create a new card with 0 balance if amount is nil' do
      card = Card.new(nil)

      expect(card.balance).to eq(0)
    end
  end

  context :credit do
    let(:card) {Card.new(11)}

    it 'should add the amount to the card' do
      card.credit(5)

      expect(card.balance).to eq(16)
    end
  end

  context :debit do
    let(:card) {Card.new(11)}

    context 'when card has sufficient balance' do
      it 'should debit the amount from the card' do
        card.debit(5)

        expect(card.balance).to eq(6)
      end
    end

    context 'when card has insufficient balance' do
      it 'should raise the insufficient funds error' do
        expect {card.debit(20)}.to raise_error(RuntimeError, Card::INSUFFICIENT_FUNDS_ERROR)
      end
    end
  end
end