#spec/player_spec.rb
require './lib/player'

describe Player do

  describe '#ask_player' do
    # Incoming query message from Game object, test here

    subject(:new_player) { described_class.new('X') }

    context 'when player chooses a position' do
      it 'returns integer' do
        valid_input = '3'
        allow(new_player).to receive(:gets).and_return(valid_input)
        expect(new_player.ask_player).to eq(3)
      end
    end

    context 'when player chooses an invalid entry' do
      it 'returns 0' do
        invalid_input = 'three'
        allow(new_player).to receive(:gets).and_return(invalid_input)
        expect(new_player.ask_player).to eq(0)
      end
    end
  end
end