#spec/game_spec.rb
require './lib/game'
require './lib/player'
require './lib/board'

describe Game do
  describe '#start' do
    # Public Script Method -> No test needed, but check methods inside
  end

  describe '#display_rules' do
    # Query sent to self, puts message, no test needed
  end

  describe '#take_turn' do
    # Looping script method, test
    
    let(:first_player) { double(Player) }
    let(:second_player) { double(Player) }
    let(:game_board) { double(Board) }
    subject(:new_game) { described_class.new(game_board, first_player, second_player) }

    context 'when player enters a valid position' do
      before do
        valid_input = '3'
        allow(first_player).to receive(:ask_player).and_return(valid_input)
      end
  
      it 'stops loop' do
        expect(new_game).to receive(:take_turn).once
        new_game.take_turn
      end
    end
  end

  describe '#game_over?' do
    # Outgoing query message sent to Board object, but #game_over? part of public script in #start so test

    let(:game_board) { double(Board) }
    subject(:test_game) { described_class.new(game_board) }

    context 'when board is full' do
      before do
        allow(game_board).to receive(:full?).and_return(true)
      end

      it 'returns true' do
        expect(test_game.game_over?).to be true
      end
    end

    context 'when board is not full but a winner exists' do
      before do
        allow(game_board).to receive(:full?).and_return(false)
        allow(game_board).to receive(:consecutive?).and_return(true)
      end

      it 'returns true' do
        expect(test_game.game_over?).to be true
      end
    end

    context 'when board is not full and no winner exists' do
      before do
        allow(game_board).to receive(:full?).and_return(false)
        allow(game_board).to receive(:consecutive?).and_return(false)
      end

      it 'returns nil' do
        expect(test_game.game_over?).to be_nil
      end
    end
  end

  describe '#swap_player' do
    # Command sent to self, but #swap_player is part of public script in #start so test

    subject(:test_game) { described_class.new }

    context 'when @current_player is @player_one' do

      it 'sets @current_player to @player_two' do
        first_player = test_game.instance_variable_get(:@player_one)
        second_player = test_game.instance_variable_get(:@player_two)
        test_game.instance_variable_set(:@current_player, first_player)

        expect { test_game.swap_player }.to change { test_game.instance_variable_get(:@current_player) }.from(first_player).to(second_player)
      end
    end

    context 'when @current_player is @player_two' do
      
      it 'sets @current_player to @player_one' do
        first_player = test_game.instance_variable_get(:@player_one)
        second_player = test_game.instance_variable_get(:@player_two)
        test_game.instance_variable_set(:@current_player, second_player)

        expect { test_game.swap_player }.to change { test_game.instance_variable_get(:@current_player) }.from(second_player).to(first_player)
      end
    end

  end

  describe '#tie' do
    # Sends outgoing query message to Board object
    # Puts message sent to self, don't test
  end

  describe '#winner' do
    # Sends outgoing query message to Board object
    # Puts message sent to self, don't test
  end
end