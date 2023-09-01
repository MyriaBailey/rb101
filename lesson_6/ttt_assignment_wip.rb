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

def text_divider
  puts "================"
end

def display_rules
  puts "Rules here!"
end # wip

def display_board(brd, brd_info)
  text_divider
  row_divider = "---" + "+---" * (brd_info[:size])

  column_header = "  "
  1.upto(brd_info[:size]) do |col|
    column_header << " | #{col}"
  end
  puts column_header

  brd_info[:rows].each.with_index do |row, idx|
    puts row_divider
    row_text = " #{LETTERS[idx]}"
    row.each { |sq| row_text << " | #{sq[:token]}" }
    puts row_text
  end
end

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

def all_rows(brd, brd_size)
  rows = []
  brd_size.times do |row_idx|
    rows << brd.select { |sq| sq[:row] == row_idx }
  end
  rows
end # A temporary? method? for specifically displaying board

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

def one_token_strings(token)
  [
    token + EMPTY_TOKEN + EMPTY_TOKEN,
    EMPTY_TOKEN + token + EMPTY_TOKEN,
    EMPTY_TOKEN + EMPTY_TOKEN + token
  ]
end

def two_token_strings(token)
  [
    token + token + EMPTY_TOKEN,
    token + EMPTY_TOKEN + token,
    EMPTY_TOKEN + token + token
  ]
end

def three_token_strings(token)
  [token + token + token]
end

# Boolean checks

# Location finding
def find_matching_line(line_strings, token_strings)
  line_strings.find_index do |line|
    token_strings.include?(line)
  end
end

# Turn-based methods
def pick_computer_piece(brd, brd_size, token)
  lines = all_lines(brd, brd_size)
  line_strings = lines.map do |line|
    line.map { |sq| sq[:token] }.join
  end

  line_idx = nil
  line_idx = find_matching_line(line_strings, two_token_strings(token))
end


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
board_info = {
  size: board_size,
  rows: all_rows(board, board_size)
}

display_board(board, board_info)
p yes?

#p all_rows_or_cols(board, board_size, :row)
#p all_diags(board)
#p all_lines(board, board_size)
pick_computer_piece(board, board_size)


# Change settings?



# Game loop

# Outro