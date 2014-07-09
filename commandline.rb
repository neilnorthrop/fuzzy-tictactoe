#! /usr/bin/env ruby
require './game.rb'

def enter_game
  puts "Do you want to play a game? Please type 'yes' or 'no'"
  answer = gets.chomp.downcase
  puts

  case answer
  when 'yes'
    puts "okay, lets play\n\n" + "*" * 30 + "\n\n"
    puts "You'll start first and be the letter 'x'\n\n"
    puts "\n\n" + "*" * 30 + "\n\n"
    @game = Game.new
    game_loop
  when 'no'
    print `clear`
    puts "too bad dude/dudette\n\n"
    exit
  else
    puts "you need to pick 'yes' or 'no'\n\n"
    enter_game
  end
end

def display(board)
  print "[#{board[0]}, #{board[1]}, #{board[2]}]\n[#{board[3]}, #{board[4]}, #{board[5]}]\n[#{board[6]}, #{board[7]}, #{board[8]}]\n"
end

def player_turn
  print `clear`
  puts "Please pick the number to where you want to play:\n"

  display(@game.display_board)

  gets.chomp

  player_position = if $_ =~ /\d/
                      if $_.to_i < 10
                        $_.to_i
                      else
                        puts "* " * 15 + "Please pick a number 1-9" + " *" * 15
                        player_turn
                      end
                    else
                      puts "* " * 15 + "Please pick a number 1-9" + " *" * 15
                      player_turn
                    end

  if @game.play(player_position, "X") == nil
    player_turn
  else
    @game.play(player_position, "X")
  end
end

def game_win
  if @game.check_game == "PLAYER WINS!"
    puts "PLAYER WINS!"
    enter_game
  elsif @game.check_game == "COMPUTER WINS!"
    puts "COMPUTER WINS!"
    enter_game
  elsif @game.check_game == "IT IS A DRAW!"
    puts "IT IS A DRAW!"
    enter_game
  end
end

def game_loop
  print `clear`
  player_turn
  game_win

  @game.computer_turn
  game_win

  game_loop
end

enter_game

__END__

