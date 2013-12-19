require 'spec_helper'

describe ComputerPlayer do
  describe 'get_move' do
    before do
      @computer = ComputerPlayer.new(:hard, "O")
      @opponent = AbstractPlayer.new("X")
      @game = Game.new(player1: @opponent,
                       player2: @computer)
    end

    def computer_turn
      @game.players = [@computer, @opponent]
    end

    def opponent_turn
      @game.players = [@opponent, @computer]
    end

    def corners
      [0, 2, 6, 8]
    end

    context 'computer goes first' do
      it 'plays a corner' do
        computer_turn
        corners.should include @game.player2.get_move(@game)
      end
    end

    context "computer goes second" do
      context "countering a center move" do
        it 'plays a corner' do
          @game.make_move(4)
          corners.should include @game.player2.get_move(@game)
        end
      end
    end
  end
end
