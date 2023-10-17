require_relative '../lib/cell'

describe Cell do

  subject(:default_cell) { described_class.new }

  describe '#initialize' do
    it 'has dash mark' do
      expect(default_cell.mark).to eq('-')
    end
  end

  describe '#set' do
    it 'changes mark' do
      new_mark = 'X'
      expect { default_cell.set(new_mark) }.to change { default_cell.mark }.to(new_mark)
    end
  end

  describe '#clear' do
    it 'resets mark' do
      new_mark = 'X'
      default_cell.set(new_mark)
      default_cell.clear
      expect(default_cell.mark).to eq('-')
    end
  end
end
