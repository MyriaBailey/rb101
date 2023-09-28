# Tic Tac Toe
# NOT FINISHED. DOES NOT HAVE WIN CONDITION CHECK
# OR PROPER COMPUTER CHIP PLACEMENT YET.
# It does have an expandable board and player count, however.

# Scrapped in favor of ttt_assignment_2 to start from scratch.
# Only kept here for record's sake.

require "pry"
require "pry-byebug"

# Global Constants
EMPTY_MARKER = ' '
LETTERS = ('A'..'Z').to_a

INVALID_CHOICE = "Sorry, that's not a valid choice"

# Methods
def prompt(msg)
  puts "=> #{msg}"
end

def setup(msg, var, min, max)
  loop do
    prompt msg
    choice = gets.chomp
  end
  var
end

# def screen_wipe(header, current_party)
#   system 'clear'
#   puts header
#   prompt "It is currently #{current_party[:name]}'s turn."
# end

=begin
def initialize_board(brd_size)
  brd = {}
  brd_size.times do |col|
    brd_size.times do |row|
      brd[[(col + 1), LETTERS[row]]] = ' '
    end
  end
  brd
end # Returns hash of [col 1-5, row A-D] keys

def line_values(brd, direction, line, range)
  values = []
  case direction
  when 'row' # columns variable, row constant
    range.each do |value|
      values << brd[[value, line]]
    end
  when 'col'
  when 'diag'
  end
  values
end # Returns array of values for a given row/col/diag on specified range

def display_board(brd_size, brd)
  system 'clear'
  columns = (1..brd_size).to_a
  divider = '---' + '+---' * brd_size

  puts '   | ' + columns.join(' | ')

  brd_size.times do |row|
    values = line_values(brd, 'row', LETTERS[row], columns)

    puts divider
    puts " #{LETTERS[row]} | " +  values.join(' | ')
  end
end # Prints the board to the display

def empty_squares(brd)
  brd.keys.select { |value| brd[value] == ' ' }
end # Returns array of hash keys (arrays) representing empty squares

def presentable(keys)
  keys.map { |col, row| col.to_s + row }
end # Maps a nested array of keys into a presentable strings

def re_key(choice)
  [choice[0].to_i, choice[1]]
end # Converts a player input string into an array key

def player_turn(brd, marker)
  options = presentable(empty_squares(brd))
  joined_options = joinor(options, '; ', 'and')
  choice = ''

  loop do 
    prompt "Chose a square: #{joined_options}"
    choice = gets.chomp.upcase
    break if options.include?(choice)
    prompt INVALID_CHOICE
  end

  brd[re_key(choice)] = marker
end

=end

# Initial Game Set-up
def populate_parties(num_players, num_computers)
  list = []
  markers = %w(X Y Z Q P O)

  num_players.times do |num|
    list << { name: "Player #{num + 1}", marker: markers.shift }
  end

  num_computers.times do |num|
    list << { name: "Computer #{num + 1}", marker: markers.pop }
  end

  list
end

def populate_reminder(parties)
  reminder = []

  parties.each do |party| 
    reminder << "#{party[:name]} is #{party[:marker]}"
  end

  reminder.join(', ') + '.'
end

def populate_turn_order(first, parties)
  case first
  when 'R'
    parties.shuffle
  when 'P'
    parties.select { |party| player?(party) } | parties
  when 'C'
    parties.select { |party| !player?(party) } | parties
  end
end

def player?(party)
  party[:name].start_with?('P')
end # Given a hash, returns true if the name starts w/ 'P'

# Board Display

def initialize_board(brd_size)
  brd = []
  brd_size.times do |row_num|
    brd_size.times do |col_num|
      brd << {col: col_num + 1, row_letter: LETTERS[row_num],
              row: row_num + 1, val: EMPTY_MARKER }
    end
  end
  brd
end # Returns arr of hsh squares, of col/row/val keys, and num/chr vals

def values_of(squares)
  squares.map { |sq| sq[:val] }
end # Maps an array of hashes into their string values (markers)

def line_values(brd, direction, line)
  case direction
  when 'row' # columns variable, row constant
    squares = brd.select { |sq| sq[:row_letter] == LETTERS[line] }
  when 'col'
  when 'diag'
  end
  values_of(squares)
end # NOTE: Currently only used in board display!

def display_board(brd, brd_size, reminder)
  system 'clear'
  puts reminder

  columns = (1..brd_size).to_a
  divider = '---' + '+---' * brd_size

  puts '   | ' + columns.join(' | ')

  brd_size.times do |row|
    values = line_values(brd, "row", row)

    puts divider
    puts " #{LETTERS[row]} | " +  values.join(' | ')
  end
end
# NOTE: RECONCILE NEW ROW_LETTER VS ROW DISTINCTION. ALSO W LINE_VALUES

# General Turn Mechanics

def empty_squares(brd)
  brd.select { |sq| sq[:val] == ' ' }
end # Filters an array of hashes

def piece_placement(brd, position, marker)
  idx = brd.index do |sq| 
    sq[:col] == position[0].to_i && sq[:row_letter] == position[1]
  end

  brd[idx][:val] = marker
end # Takes a string position, finds its board placement, updates it
# NOTE: FORMATED FOR PLAYER INPUT

# Player Turn Mechanics

def positions_of(squares)
  squares.map { |sq| "#{sq[:col]}#{sq[:row_letter]}" }
end # Maps an array of hashes into their [col][row] position for display

def joinor(squares, spacer = ', ', word = 'or')
  if squares.size <= 2
    squares.join(" #{word} ")
  else
    squares[0..-2].join(spacer) + " #{word} #{squares[-1]}"
  end
end # Returns a joined string of options

def player_turn(brd)
  options = positions_of(empty_squares(brd))
  joined_options = joinor(options, '; ', 'and')
  choice = ''

  loop do 
    prompt "Chose a square: #{joined_options}"
    choice = gets.chomp.upcase
    break if options.include?(choice)
    prompt INVALID_CHOICE
  end

  choice
end

# Compiling surrounding values from a sq for computer analysis

def find_sq(brd, row, col)
  idx = brd.find_index { |sq| sq[:row] == row && sq[:col] == col }
  brd[idx]
end # Returns the full sq hash from brd given row/col numbers

def range(brd, sq_rowcol)
  brd_size = Integer.sqrt(brd.size)
  
  min = sq_rowcol - 2
  min = 1 if min < 1

  max = sq_rowcol + 2
  max = brd_size if max > brd_size

  (min..max).to_a
end # Returns an arr of valid ints representing up to 2 spaces away

def vertical_squares(brd, row_range, sq)
  brd.select do |square|
    square[:col] == sq[:col] && row_range.include?(square[:row])
  end
end # Returns arr of sqs along a range of rows in specified col

def horizontal_squares(brd, col_range, sq)
  brd.select do |square|
    square[:row] == sq[:row] && col_range.include?(square[:col])
  end
end # Returns arr of sqs along a range of cols in specified row

def diag_squares(brd, row_range, col_range, sq, direction)
  squares = []
  steps = [-2, -1, 0, 1, 2]

  steps.each do |step|
    new_row = sq[:row] + step
    new_col = sq[:col]

    direction == 'up' ? new_col -= step : new_col += step

    if row_range.include?(new_row) && col_range.include?(new_col)
      squares << find_sq(brd, new_row, new_col)
    end
  end

  squares
end # Returns arr of sqs along a specified diagonal

def surrounding_squares(brd, sq)
  rows = range(brd, sq[:row])
  cols = range(brd, sq[:col])

  vertical = vertical_squares(brd, rows, sq)
  horizontal = horizontal_squares(brd, cols, sq)
  down_diag = diag_squares(brd, rows, cols, sq, 'down')
  up_diag = diag_squares(brd, rows, cols, sq, 'up')

  [vertical, horizontal, down_diag, up_diag].map do |line|
    values_of(line)
  end
end # Returns a nested arr of strings along several directions from a point

# Computer turn analysis

def possible_wins(lines, marker)
  matches = [marker * 2, marker + EMPTY_MARKER + marker]

  lines.select do |line|
    line.include?(matches[0]) || line.include?(matches[1])
  end
end
# find selection. if possible win? sort by most favorable. place piece

def computer_turn(brd, party, markers)
  possibilities = empty_squares(brd).map do |square|
    [square, surrounding_squares(brd, square)]
  end # Returns nested arr of sq itself and another nested arr of strings

  



end

# Computer Algorithm

# 1. Acquire list of all possible empty squares, and for each empty sq,
#     every string of surrounding values
#     - determine current marker + winning string eg. "XX" "X X"
# 2. Determine if a POSSIBLE winning string exists
#     a. Save a selection among each empty square's arr of values where:
#         - "XX" or "X X" appears:
#     b. If the selection arr is NOT empty:
#         - sample a random sq of it and update board
#         - return true
#        Else (selection is empty):
#         - return false
# 3. If no possible winning string, determine if can possibly BLOCK a win
#     a. Save a selection among each empty square's arr of values where:
#         - Either 2 consecutive characters of same char
#         - OR 2 of the same char separated by a space
#     b. If the selection arr is NOT empty:
#         - sort it by count of applicable lines
#         - pick first of the sort and update board
#        Else (selection is empty):
#         - return false
# 4. Determine most advantageous sq
#     a. Save a selection among each empty square's arr of values where:
#         - Current marker exists unblocked
#     b. If the selection arr is NOT empty:
#         - Sort by count of applicable lines, update board w/ highest
#         - return true
#        Else: return false
# 5. Pick middle-most sq
#     a. If centermost sq is open: place piece there
#        Elsif: sample selection of empty sqs +/- 1 from center + update
#        Else: return false
# 6. Random sq
#     a. sample empty sqs and update board





# Game Itself

# One-time Setup
# - board size
# - number of players (and markers)
# - number of computers
# - who goes first? autopick?

# - initialize the scoreboard

# Fresh board
# - Initialize the board
# - Determine turn order

# Game Loop
# - First player group
# - Second player group

# Inner Game Loop
# Each player turn:
# - Prompt for square (or determine square)
# - Mark the board
# - Check for winner/tie

# Display winner/tie


# First time set-up
board_size = 5
people = 1
computers = 1
first = 'P'

loop do
  prompt "Welcome to Tic-Tac-Toe!"
  prompt "Skip set-up and use default settings? (y/n)"
  skip = gets.chomp.downcase
  break if skip.start_with?('y')

  loop do
    prompt "How long should the board's sides be? (min: 3, max: 9)"
    board_size = gets.chomp.to_i
    break if board_size >= 3 && board_size <= 9
    prompt INVALID_CHOICE
  end # Pick board size
  
  loop do
    prompt "How many people will be playing? (min: 1, max: 3)"
    people = gets.chomp.to_i
    break if people >= 1 && people <= 3
    prompt INVALID_CHOICE
  end # Pick number of people playing
  
  loop do
    prompt "How many computers will be playing? (min: 1, max: 3)"
    computers = gets.chomp.to_i
    break if computers >= 1 && computers <= 3
    prompt INVALID_CHOICE
  end # Pick number of computers playing
  
  loop do
    prompt "Who should go first: Players, Computer, Random"
    first = gets.chomp.upcase[0]
    break if first == 'P' || first == 'C' || first == 'R'
    prompt INVALID_CHOICE
  end # Pick who goes first

  break
end # Setup prompts

parties = populate_parties(people, computers)
marker_reminder = populate_reminder(parties)
markers_used = parties.map { |party| party[:marker] }

# Testing
# board = initialize_board(board_size)
# idx = board.index { |sq| sq[:col] == 2 && sq[:row] == 'B'}
# board[idx][:val] = 'X'
# display_board(board, board_size, marker_reminder)

# New game start

loop do
  board = initialize_board(board_size)
  turn_order = populate_turn_order(first, parties)
  game_finished = false

  # Testing
  surrounding_squares(board, board[3])

  until game_finished do
    turn_order.each do |party|
      display_board(board, board_size, marker_reminder)
      prompt "It is currently #{party[:name]}'s turn."

      if player?(party)
        choice = player_turn(board)
      else
        # TO-DO: Computer AI choice selection
        choice = positions_of(empty_squares(board)).sample
      end

      piece_placement(board, choice, party[:marker])
      # TO-DO: Check for win/tie

    end # End of turn order, loop to first player
  end # End of round

  # TO-DO: Display who won/if it's a tie

  # TO-TO: Display current UPDATED score

  prompt "Keep going? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Good bye!"



