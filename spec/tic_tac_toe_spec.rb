require './lib/tic_tac_toe'

describe Game do
  # testing the Tic Tac Toe game class
  context 'test the class methods' do 
    context 'testing game win' do 
      let(:player) {double('Player')}
      subject(:tic_game) {described_class.new}
      # The multiple allow statments are for the extra method calls in the class
      before do
        allow(tic_game).to receive(:win_message).and_return(nil)
        allow(player).to receive(:name).and_return('default')
        allow(player).to receive(:add_score).and_return(1)
      end
      it 'wins when it matches horizontally' do
        values = [1,2,3]
        allow(player).to receive(:spots).and_return(values)
        expect(tic_game.won?(player)).to be true
      end
      it 'wins when it mathches diagonally' do
        values = [1,5,9]
        allow(player).to receive(:spots).and_return(values)
        expect(tic_game.won?(player)).to be true
      end
      it 'wins when it matches vertically' do 
        values = [3,6,9]
        allow(player).to receive(:spots).and_return(values)
        expect(tic_game.won?(player)).to be true
      end
      it 'return false when not a match' do 
        values = [2,6,9]
        allow(player).to receive(:spots).and_return(values)
        expect(tic_game.won?(player)).to be false
      end    
    end
  end
end