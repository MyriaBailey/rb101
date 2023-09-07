# Tic Tac Toe

EMPTY_TOKEN = ' '
LETTERS = ('A'..'Z').to_a

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(list)
  list = list.dup

  if list.size <= 2
    list.join(" and ")
  else
    last = list.pop
    list.join(", ") + ", and " + last
  end
end

def screenwipe
  system 'clear'
end

def text_divider
  puts "=========================="
end

def display_rules
  screenwipe
  prompt("Welcome to Tic-Tac-Toe!")
  text_divider
  prompt("This is a game where players take turns marking a grid.")
  prompt("The first player to get 3 marks in a line wins the game!")
  prompt("Any column, row, or diagonal counts as a line here.")
  prompt("Go for best of five rounds!")
  text_divider
end

def yes?
  answer = gets.upcase[0]

  until answer == 'Y' || answer == 'N' do
    prompt("Please enter Yes or No")
    answer = gets.upcase[0]
  end
  
  answer.start_with?('Y')
end

def get_valid_input(options)
  answer = gets.chomp.upcase

  until options.include?(answer)
    prompt("That is not a valid option, try again.")
    answer = gets.chomp.upcase
  end

  answer
end

def build_player_list(people, computers)
  players = []
  names = []

  if people == 1 && computers == 1
    tokens = %w[X O]
    names = %w[Player Computer]
  else
    tokens = LETTERS.reverse
    people.times do |num|
      names << "Player #{num + 1}"
    end
    computers.times do |num|
      names << "Computer #{num + 1}"
    end
  end

  names.each do |name|
    players << {
      name: name,
      token: tokens.shift,
      score: 0
    }
  end

  players
end

def build_token_reminder(players)
  players.map do |player|
    "#{player[:name]} is #{player[:token]}"
  end.join(', ')
end

def build_textbars(brd_size)
  textbars = {
    row_div: "---" + "+---" * (brd_size),
    col_head: "  "
  }

  1.upto(brd_size) do |col|
    textbars[:col_head] << " | #{col}"
  end

  textbars
end

def build_squares(brd_size)
  brd = []

  brd_size.times do |row_idx|
    brd_size.times do |col_idx|
      square = { row: row_idx, col: col_idx, token: EMPTY_TOKEN }
      square[:name] = "#{col_idx + 1}#{LETTERS[row_idx]}"
      brd << square
    end
  end

  brd
end

def all_rows(brd)
  rows = []
  brd[:size].times do |row_idx|
    rows << brd[:squares].select { |sq| sq[:row] == row_idx }
  end
  rows
end

def all_cols(brd)
  cols = []
  brd[:size].times do |col_idx|
    cols << brd[:squares].select { |sq| sq[:col] == col_idx }
  end
  cols
end

# OPTIMIZE: Does not account for larger grids
def all_diags(brd)
  diags = []

  down_diags = ['1A', '2B', '3C']
  up_diags = ['3A', '2B', '1C']

  diags << brd[:squares].select do |sq|
    down_diags.include?(sq[:name])
  end

  diags << brd[:squares].select do |sq|
    up_diags.include?(sq[:name])
  end

  diags
end

def middle_squares(brd)
  midpoint = brd[:size] / 2

  mid_idxs = [midpoint]
  mid_idxs << (midpoint - 1) if brd[:size].even?

  brd[:squares].select do |sq|
    mid_idxs.include?(sq[:row]) && mid_idxs.include?(sq[:col])
  end
end

def empty_squares(brd)
  brd[:squares].select { |sq| sq[:token] == EMPTY_TOKEN }
end

def compile_board!(brd)
  brd[:squares] = build_squares(brd[:size])
  brd[:rows] = all_rows(brd)
  brd[:cols] = all_cols(brd)
  brd[:diags] = all_diags(brd)
  brd[:middle] = middle_squares(brd)
  brd[:lines] = brd[:rows] + brd[:cols] + brd[:diags]
end

def clean_board!(brd)
  brd[:squares].each { |sq| sq[:token] = EMPTY_TOKEN }
end

def display_board(brd, textbars)
  screenwipe
  puts textbars[:tokens]
  text_divider
  puts textbars[:col_head]

  brd[:rows].each.with_index do |row, idx|
    puts textbars[:row_div]
    row_text = " #{LETTERS[idx]}"
    row.each { |sq| row_text << " | #{sq[:token]}" }
    puts row_text
  end
end

def who_goes_first(players, order, num_ppl)
  if order == 'P'
    players[0]
  elsif order == 'C'
    players[num_ppl]
  else
    players.sample
  end
end

def alternate_player(player, all_players)
  next_idx = all_players.find_index(player) + 1

  if next_idx >= all_players.size
    all_players[0]
  else
    all_players[next_idx]
  end
end

# REVIEW: Should the token be placed inside the method call? how?
def place_piece!(player, brd)
  square =
    if player[:name].start_with?('P')
      pick_player_piece(player, brd)
    else
      pick_computer_piece(player, brd)
    end

  # brd[:squares][square_idx][:token] = player[:token]
  square[:token] = player[:token]
end

# OPTIMIZE: change dialogue text to flow better
def pick_player_piece(player, brd)
  choices = empty_squares(brd).map { |sq| sq[:name] }

  prompt("#{player[:name]}, pick a square: #{joinor(choices)}")
  choice = get_valid_input(choices)

  idx = brd[:squares].find_index { |sq| sq[:name] == choice }
  brd[:squares][idx]
end

def pick_computer_piece(player, brd)
  empty_squares(brd).sample
end





# REVIEW: How and when are these used?
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


def lines_to_strings(lines)
  lines.map { |line| line.map { |sq| sq[:token] } }
end


# TODO: actually check this
def someone_won?(brd)
  lines_to_strings(brd[:lines]).any? do |line|
    nil
  end
end

def board_tied?(brd)
  empty_squares(brd).empty?
end

# TODO: Whatever... this computer AI is.
# def find_matching_line(line_strings, token_strings)
#   line_strings.find_index do |line|
#     token_strings.include?(line)
#   end
# end

# def pick_computer_piece(brd, brd_size, token)
#   lines = all_lines(brd, brd_size)
#   line_strings = lines.map do |line|
#     line.map { |sq| sq[:token] }.join
#   end

#   line_idx = nil
#   line_idx = find_matching_line(line_strings, two_token_strings(token))
# end





# GAME ITSELF
board = { size: 3 }
num_computers = 1
num_people = 1
whos_first = 'P'
best_of = 5

display_rules
# TODO: Change settings?
prompt("Would you like to open advanced settings? (Y/N)")
if yes?
  prompt("How large should each side of the board be? (3-9)")
  prompt("How many computers do you want to play against? (0-6)")
end

players = build_player_list(num_people, num_computers)
textbars = build_textbars(board[:size])
textbars[:tokens] = build_token_reminder(players)
compile_board!(board)

loop do
  clean_board!(board)
  current_player = who_goes_first(players, whos_first, num_people)

  loop do
    display_board(board, textbars)
    place_piece!(current_player, board)

    if someone_won?(board)
      prompt("#{current_player[:name]} won!")
      current_player[:score] += 1
      break
    elsif board_tied?(board)
      prompt("It's a tie!")
      break
    end

    current_player = alternate_player(current_player, players)
  end

  # TODO: scoreboard display and next game prompts
  grand_winner = players.index { |player| }
end

prompt("Thanks for playing!")
# Outro