#spec/board_spec.rb
require './lib/board'

describe Board do

  describe '#available?' do
    # Should I not have tested this either?
    context 'when player choose an open column' do

      it 'returns true' do
        board = Board.new
        column = 3
        allow(board).to receive(:available?).and_return(true)
        expect(board.available?(column)).to eq(true)
      end
    end
  end
  
  describe '#update' do
    # Command incoming from Game

    context 'when third column is picked and available' do

      it 'updates third column with player marker' do
        board = Board.new
        marker = 'X'
        board.update(3, marker)
        expect(board.three).to eq(['X'])
      end

    end
  end

  describe '#display' do
    # Puts no test
  end

  describe '#consecutive?' do
    # Query incoming from Game
    context 'when a Player marker appears 4 consecutive times in a horiztonal line' do
      
      it 'returns true' do
        board = Board.new
        allow(board).to receive(:four_in_row?).and_return(true)
        expect(board.consecutive?).to be true
      end

    end

    context 'when a Player marker appears 4 consecutive times in a diagonal line' do

      it 'returns true' do
        board = Board.new
        allow(board).to receive(:diagonal?).and_return(true)
        expect(board.consecutive?).to be true
      end
    end

    context 'when a Player marker appears 4 consecutive times in a vertical line' do
      
      it 'returns true' do
        board = Board.new
        allow(board).to receive(:four_in_row?).and_return(true)
        expect(board.consecutive?).to be true
      end
    end

    context 'when no Player marker appears 4 consecutive times in any direction' do

      it 'returns false' do
        board = Board.new
        allow(board).to receive(:four_in_row?).and_return(false)
        allow(board).to receive(:four_in_row?).and_return(false)
        allow(board).to receive(:diagonal?).and_return(false)
        expect(board.consecutive?).to be false
      end
    end

  end

  describe '#full?' do
    # Query incoming from Game
    context 'when all columns have a count of 6' do
      it 'returns true' do
        board = Board.new
        one = board.instance_variable_get(:@one)
        one.push('X', 'O', 'X', 'O', 'X', 'O')
        two = board.instance_variable_get(:@two)
        two.push('X', 'O', 'X', 'O', 'X', 'O')
        three = board.instance_variable_get(:@three)
        three.push('X', 'O', 'X', 'O', 'X', 'O')
        four = board.instance_variable_get(:@four)
        four.push('X', 'O', 'X', 'O', 'X', 'O')
        five = board.instance_variable_get(:@five)
        five.push('X', 'O', 'X', 'O', 'X', 'O')
        six = board.instance_variable_get(:@six)
        six.push('X', 'O', 'X', 'O', 'X', 'O')
        seven = board.instance_variable_get(:@seven)
        seven.push('X', 'O', 'X', 'O', 'X', 'O')

        expect(board.full?).to be true
      end
    end

    context 'when one or more columns do not have a count of 6' do
      it 'returns false' do
        board = Board.new
        one = board.instance_variable_get(:@one)
        one.push('X', 'O')
        two = board.instance_variable_get(:@two)
        two.push('X', 'O', 'X', 'O', 'X', 'O')
        three = board.instance_variable_get(:@three)
        three.push('X', 'O', 'X', 'O', 'X', 'O')
        four = board.instance_variable_get(:@four)
        four.push('X', 'O', 'X', 'O', 'X', 'O')
        five = board.instance_variable_get(:@five)
        five.push('X', 'O', 'X', 'O', 'X', 'O')
        six = board.instance_variable_get(:@six)
        six.push('X', 'O', 'X', 'O', 'X', 'O')
        seven = board.instance_variable_get(:@seven)
        seven.push('X', 'O')

        expect(board.full?).to be false
      end
    end
  end
end
