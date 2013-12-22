module TicTacToe
  class AbstractPlayer
    attr_reader :mark
    def initialize(mark)
      @mark = mark
    end
  end
end