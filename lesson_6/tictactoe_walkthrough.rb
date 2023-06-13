# Tic Tac Toe
# Unpolished!

require "pry"
require "pry-byebug"

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(positions, spacer = ', ', word = 'or' )
  if positions.size <= 2
    positions.join(" #{word} ")
  else
    positions[0..-2].join(spacer) + " #{word} #{positions[-1]}"
  end
end

def display_board(brd)
  system 'clear'
  puts "You're #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts ' ' + [brd[1], brd[2], brd[3]].join(' | ') + ' '
  puts "---+---+---"
  puts ' ' + [brd[4], brd[5], brd[6]].join(' | ') + ' '
  puts "---+---+---"
  puts ' ' + [brd[7], brd[8], brd[9]].join(' | ') + ' '
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_turn(brd)
  square = ''
  loop do
    prompt "Choose a square: #{joinor(empty_squares(brd), '; ', 'and')}"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end

  brd[square] = PLAYER_MARKER
end

def computer_turn(brd)
  brd[empty_squares(brd).sample] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    values = brd.values_at(*line)

    if values.all?(PLAYER_MARKER)
      return "Player"
    elsif values.all?(COMPUTER_MARKER)
      return "Computer"
    end
  end

  nil
end

def update_score(scr, name)
  if name == 'Player'
    scr[0] += 1
  else
    scr[1] += 1
  end
end


# Game Start
score = [0, 0]

loop do
  board = initialize_board

  loop do
    display_board(board)

    player_turn(board)
    break if someone_won?(board) || board_full?(board)

    computer_turn(board)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    winner = detect_winner(board)
    update_score(score, winner)
    prompt "#{winner} won!"
  else
    prompt "It's a tie!"
  end

  prompt "Current score: #{score[0]} - #{score[1]}"

  prompt "Keep going? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Good bye!"
