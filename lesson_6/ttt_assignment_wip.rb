# Tic Tac Toe

# CONSTANTS



# METHODS

# Displaying Information
# prompt, text_divider, screenwipe, display_rules, display_board

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

# Information calculation
# board, all_rows, all_cols, all_up_diags, all_down_diags, middle_squares

# Boolean checks

# Location finding

# Turn-based methods



# GAME ITSELF

# Intro
# Default settings
board_size = 3
num_computers = 1
num_players = 1
goes_first = 'p'

# Display rules
display_rules
p yes?

# Change settings?



# Game loop

# Outro