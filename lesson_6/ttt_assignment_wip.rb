# Tic Tac Toe

# CONSTANTS



# METHODS

# Displaying Information
# prompt, text_divider, screenwipe, display_rules, display_board

EMPTY_TOKEN = ' '
LETTERS = ('A'..'Z').to_a

def prompt(msg)
  puts "=> #{msg}"
end

def display_rules
  puts "Rules here!"
end # wip

# Player input
# settings_dialogue, yes_or_no, get_valid_input ?

def yes?
  answer = gets.downcase[0]

  until answer == 'y' || answer == 'n' do
    prompt("Please enter Yes or No")
    answer = gets.downcase[0]
  end
  
  answer.start_with?('y')
end # Returns a true boolean if player says yes, false otherwise

# Information calculation (done! probably)

def generate_board(brd_size)
  brd = []

  brd_size.times do |row_idx|
    brd_size.times do |col_idx|
      square = { row: row_idx, col: col_idx, token: EMPTY_TOKEN }
      square[:name] = "#{col_idx + 1}#{LETTERS[row_idx]}"
      brd << square
    end
  end

  brd
end # Returns an array of hashes of row/col/token/name

def all_diagonals(brd)
  diags = []

  down_diags = ['1A', '2B', '3C']
  up_diags = ['3A', '2B', '1C']

  diags << brd.select do |sq|
    down_diags.include?(sq[:name])
  end

  diags << brd.select do |sq|
    up_diags.include?(sq[:name])
  end

  diags
end # A simplified search for diagonals on a 3x3 grid

def all_lines(brd, brd_size)
  lines = []

  brd_size.times do |line_idx|
    lines << brd.select { |sq| sq[:row] == line_idx }
    lines << brd.select { |sq| sq[:col] == line_idx }
  end
  
  lines.union(all_diagonals(brd))
end # Returns an array of arrays for each line of square hashes

def middle_squares(brd, brd_size)
  midpoint = brd_size / 2

  mid_idxs = [midpoint]
  mid_idxs << (midpoint - 1) if brd_size.even?

  brd.select do |sq|
    mid_idxs.include?(sq[:row]) && mid_idxs.include?(sq[:col])
  end
end # Returns an array of middle square(s)


# Boolean checks

# Location finding

# Turn-based methods



# GAME ITSELF

# Intro
# Default settings
board_size = 3
num_computers = 1
num_players = 1
whos_first = 'p'

# Display rules
display_rules
p yes?

board = generate_board(board_size)
#p all_rows_or_cols(board, board_size, :row)
#p all_diags(board)
p all_lines(board, board_size)


# Change settings?



# Game loop

# Outro