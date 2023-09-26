# Tic Tac Toe

EMPTY_TOKEN = ' '
LETTERS = ('A'..'Z').to_a

MAX_BOARD_SIZE = 9
MAX_PLAYERS = 9
MIN_PLAYERS = 2

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(list)
  list = list.dup

  if list.size <= 2
    list.join(" or ")
  else
    last = list.pop
    list.join(", ") + ", or " + last
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
  prompt("The first player to get 3 marks in a line wins the match!")
  prompt("Any column, row, or diagonal counts as a line here.")
  prompt("First to 5 wins the game!")
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
  choice = nil

  while choice.nil?
    answer = gets.chomp.upcase
    interpretations = [answer, answer.reverse, answer.to_i]
    choice = (options & interpretations).first

    prompt("That is not a valid option, try again.") if choice.nil?
  end

  choice
end

def build_player_list(people, computers)
  players = []
  names = []
  tokens = ['X', 'O', '#', '!', '/', '&', '%', '*', '^']

  if people == 1 && computers == 1
    names = %w[Player Computer]
  else
    people.times do |num|
      names << "Player#{num + 1}"
    end
    computers.times do |num|
      names << "Computer#{num + 1}"
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

def build_textbars(brd_size, all_players)
  textbars = {
    row_div: "---" + "+---" * (brd_size),
    col_head: "  ",
    tokens: build_token_reminder(all_players)
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
      square[:name] = "#{LETTERS[row_idx]}#{col_idx + 1}"
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

def all_diag_coords(brd)
  coord_sets = []

  cols_forward = (0..(brd[:size] - 1)).to_a
  cols_reversed = cols_forward.reverse
  rows_forward = cols_forward.dup
  rows_reversed = cols_forward.reverse

  until cols_forward.empty?
    coord_sets << [cols_forward, rows_forward].transpose
    coord_sets << [cols_forward, rows_reversed].transpose

    coord_sets << [cols_reversed, rows_forward].transpose
    coord_sets << [cols_reversed, rows_reversed].transpose

    cols_forward.shift
    cols_reversed.shift
    rows_forward.pop
    rows_reversed.pop
  end

  coord_sets.reject! { |line| line.count < 3 }
end

def all_diags(brd)
  all_diag_coords(brd).map do |coord_set|
    coord_set.map do |coord|
      brd[:squares].select do |sq|
        sq[:col] == coord[0] && sq[:row] == coord[1]
      end.first
    end
  end
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

def compile_board!(brd, all_players)
  brd[:squares] = build_squares(brd[:size])

  brd[:rows] = all_rows(brd)
  brd[:cols] = all_cols(brd)
  brd[:diags] = all_diags(brd)
  brd[:middle] = middle_squares(brd)
  brd[:lines] = brd[:rows] + brd[:cols] + brd[:diags]

  brd[:tokens] = all_players.map { |player| player[:token] }
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
  text_divider
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

def place_piece!(player, brd)
  square =
    if player[:name].start_with?('P')
      pick_player_piece(player, brd)
    else
      pick_computer_piece(player, brd)
    end
  square[:token] = player[:token]
end

def pick_player_piece(player, brd)
  choices = empty_squares(brd).map { |sq| sq[:name] }

  prompt("#{player[:name]}'s turn.")
  prompt("Pick a square: #{joinor(choices)}")
  choice = get_valid_input(choices)

  idx = brd[:squares].find_index { |sq| sq[:name] == choice }
  brd[:squares][idx]
end

def pick_computer_piece(player, brd)
  lines = brd[:lines]
  strings = lines_to_strings(brd[:lines])
  combos = combo_strings(player, brd)

  sq = find_strategic_sq(lines, strings, combos[:win])
  sq = find_strategic_sq(lines, strings, combos[:defend]) if sq.nil?
  sq = find_strategic_sq(lines, strings, combos[:advance]) if sq.nil?
  sq = find_mid_sq(brd) if sq.nil?
  sq = empty_squares(brd).sample if sq.nil?
  sq
end

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

def combo_strings(player, brd)
  combos = {}
  other_tokens = brd[:tokens].reject { |t| t == player[:token] }

  combos[:win] = two_token_strings(player[:token])
  combos[:defend] = other_tokens.map { |t| two_token_strings(t) }.flatten
  combos[:advance] = one_token_strings(player[:token])

  combos
end

def lines_to_strings(lines)
  lines.map { |line| line.map { |sq| sq[:token] }.join }
end

def which_empty_sq(line, idx)
  line.values_at(idx..(idx + 2)).select do |sq|
    sq[:token] == EMPTY_TOKEN
  end.sample
end

def find_strategic_sq(lines, line_strings, substrings)
  choices = []

  lines.each_with_index do |line, i|
    line_start_idx = substrings.map do |sub_str|
      line_strings[i].index(sub_str)
    end.compact.sample

    if line_start_idx
      choices << which_empty_sq(line, line_start_idx)
      break
    end
  end
  choices.sample
end

def find_mid_sq(brd)
  empty_squares(brd).intersection(brd[:middle]).sample
end

def someone_won?(brd, player)
  winning_combo = player[:token] * 3

  lines_to_strings(brd[:lines]).any? do |line|
    line.include?(winning_combo)
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def no_winning?(brd)
  line_strings = lines_to_strings(brd[:lines])

  brd[:tokens].none? do |token|
    winning_combo = token * 3
    line_strings.any? do |str|
      str.tr(EMPTY_TOKEN, token).include?(winning_combo)
    end
  end
end

def clean_scoreboard!(all_players)
  all_players.each { |player| player[:score] = 0 }
end

board = { size: 3 }
num_computers = 1
num_people = 1
whos_first = 'P'
best_of = 5

display_rules
prompt("Start game with default rules? (Y/N)")
if !yes?
  screenwipe
  puts "Advanced Settings"
  text_divider

  prompt("Winning will still require 3 tokens in a row.")
  prompt("How large should each side of the board be? (3-#{MAX_BOARD_SIZE})")
  board[:size] = get_valid_input((3..MAX_BOARD_SIZE).to_a)
  text_divider

  prompt("There must be a minimum of #{MIN_PLAYERS} players total.")
  prompt("How many live people are playing? (0-#{MAX_PLAYERS})")
  num_people = get_valid_input((0..MAX_PLAYERS).to_a)
  

  min_computers = MIN_PLAYERS - num_people
  min_computers = 0 if min_computers < 0
  max_computers = MAX_PLAYERS - num_people
  prompt("How many computers are playing? (#{min_computers}-#{max_computers})")
  num_computers = get_valid_input((min_computers..max_computers).to_a)
  text_divider

  if num_people >= 1 && num_computers >= 1
    prompt("Which side goes first? (Player, Computer, Random)")
    options = %w[P PLAYER C COMPUTER R RANDOM]
    whos_first = get_valid_input(options).chars.first
    text_divider
  end

  prompt("How many match wins to win the game? (1-50)")
  best_of = get_valid_input((1..50).to_a)
  text_divider

  prompt("Ready to start? (Y/N)")
  until yes?
    prompt("Whenever you're ready :)")
  end
end

players = build_player_list(num_people, num_computers)
textbars = build_textbars(board[:size], players)
compile_board!(board, players)

loop do
  clean_board!(board)
  current_player = who_goes_first(players, whos_first, num_people)

  display_board(board, textbars)
  loop do
    place_piece!(current_player, board)
    display_board(board, textbars)
    
    if someone_won?(board, current_player)
      prompt("#{current_player[:name]} won!")
      current_player[:score] += 1
      break
    elsif board_full?(board)
      prompt("It's a tie - Board's full!")
      break
    elsif no_winning?(board)
      prompt("It's a tie - Nobody can win!")
      break
    end

    current_player = alternate_player(current_player, players)
  end
  
  text_divider
  puts "Scoreboard"
  players.each { |player| prompt("#{player[:name]}: #{player[:score]}") }

  text_divider
  winner = players.select { |player| player[:score] >= best_of }.first
  if winner
    prompt("#{winner[:name]} won #{best_of} games!")
    prompt("Do you want to start over and keep playing? (Y/N)")
    yes? ? clean_scoreboard!(players) : break
  else
    prompt("Start next match? (Y/N)")
    break unless yes?
  end
end

prompt("Thanks for playing!")