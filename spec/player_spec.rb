# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  subject(:player_test) { described_class.new('Test') }

  describe '#win' do
    it 'changes wins by 1' do
      expect { player_test.win }.to change { player_test.wins }.by(1)
    end
  end

  describe '#tie' do
    it 'changes ties by 1' do
      expect { player_test.tie }.to change { player_test.ties }.by(1)
    end
  end

  describe '#lose' do
    it 'changes losses by 1' do
      expect { player_test.lose }.to change { player_test.losses }.by(1)
    end
  end
end
