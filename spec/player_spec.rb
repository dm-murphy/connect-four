#spec/player_spec.rb
require './lib/player'

describe Player do

  describe '#ask_player' do
 
    context 'when player chooses a valid position' do
      it 'returns position' do
        player = Player.new('X')
        allow(player).to receive(:ask_player).and_return(3)
        expect(player.ask_player).to eq(3)
      end
    end

    context 'when player chooses an invalid position' do
      it 'returns nil' do
        player = Player.new('X')
        allow(player).to receive(:ask_player).and_return(nil)
        expect(player.ask_player).to eq(nil)
      end
    end
  end
end