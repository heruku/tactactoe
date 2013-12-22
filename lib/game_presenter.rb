PRINT_BOARD = <<-STRING.chomp

                             * | * | *
                            ---|---|---
                             * | * | *
                            ---|---|---
                             * | * | *



STRING

class GamePresenter
  attr_accessor :game

  def start
    system 'clear'

    get_options
    until game.over?
      print_board
      move = game.turn.get_move(game)
      if game.valid_move?(move)
        game.make_move(move)
      else
        puts "Invalid move"
        sleep(0.5)
        next
      end
    end
    print_board
    print_results
  end

  def get_options
    print "Choose the first player(1-human, 2-computer): "
    player1 = get_player("X".blue)
    print "Choose the second player(1-human, 2-computer): "
    player2 = get_player("O".red)
    @game = TicTacToe::Game.new(player1: player1,
                                player2: player2)
  end

  def build_board
    print_board = PRINT_BOARD.dup
    game.board.each do |cell|
      print_board.sub!("*", cell)
    end
    print_board
  end

  def print_board
    system('clear')
    console_board = build_board
    puts "\n\n"
    puts "                              #{game.turn.mark} turn"
    puts console_board
  end

  def get_player(mark)
    input = gets.chomp.to_i
    if input == 1
      player = ConsolePlayer.new(mark)
    elsif input == 2
      player = get_computer_player(mark)
    else
      print "Invalid input, try again: "
      get_player(mark)
    end
    player
  end

  def print_results
    puts "#{game.winner.mark} has Won!" if game.winner
    puts "It is a tie" if !game.winner
  end

  def get_computer_player(mark)
    print "Select difficulty(1-easy, 2-hard): "
    input = gets.chomp.to_i
    if input == 1
      player = TicTacToe::ComputerPlayer.new(:easy, mark)
    elsif input == 2
      player = TicTacToe::ComputerPlayer.new(:hard, mark)
    else
      print "Invalid input, try again: "
      get_computer_player(mark)
    end
  end
end
