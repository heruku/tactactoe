require 'spec_helper'
describe Game do
  let(:player1) { double() }
  let(:player2) { double() }
  subject(:game) { Game.new(player1: player1,
                            player2: player2) }
  before do
    player1.stub(mark: "X")
    player2.stub(mark: "O")
  end


  describe '#make_move' do
    it 'marks the correct cell' do
      game.make_move(1)
      game.board[1].should eq "X"
    end

    it 'switches the turn' do
      game.make_move(1)
      game.turn.should eq player2
    end
  end

  describe '#over?' do
    context 'not over' do
      it 'returns a falsey falue' do
        game.over?.should be_false
      end
    end

    context 'horizontal win' do
      let(:board) {        ["X", "X", "X",
                            " ", " ", " ",
                            " ", " ", " "] }
      before{ game.board = board }


      it 'is truthy' do
        game.over?.should eq true
      end

      it 'sets the winner' do
        game.over?
        game.winner.should eq player1
      end
    end

    context 'vertical win' do
      before do
        game.stub(:columns).and_return(["O", "O", "O"])
      end

      it 'is truthy' do
        game.over?.should eq true
      end

      it 'sets the winner' do
        game.over?
        game.winner.should eq player2
      end
    end

    context 'diagonal win' do
      before do
        game.stub(:diagonals).and_return(["X", "X", "X"])
      end

      it 'is truthy' do
        game.over?.should eq true
      end

      it 'sets the winner' do
        game.over?
        game.winner.should eq player1
      end
    end

    context 'draw' do
      before do
        game.stub(:win?).and_return(:false)
        game.stub(:board).and_return(["X", "X", "O"])
      end

      it 'recognises draw when all cells are marked' do

        game.over?.should be_true
        game.winner.should be_false
      end
    end
  end
end
