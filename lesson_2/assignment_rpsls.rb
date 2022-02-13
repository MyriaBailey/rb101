# Assignment for Rock Paper Scissors Lizard Spock

# KNOWN BUG: Displaying which choice each party has
# does not show up on final round.

require 'abbrev'

VALID_CHOICES = %w(rock paper scissors lizard spock)
VALID_SHORTHAND = VALID_CHOICES.abbrev
WHAT_EACH_MOVE_BEATS = { rock: %w(lizard scissors),
                         paper: %w(rock spock),
                         scissors: %w(paper lizard),
                         lizard: %w(spock paper),
                         spock: %w(scissors rock) }

def prompt(message)
  puts("=> #{message}")
end

def win?(first, second)
  WHAT_EACH_MOVE_BEATS[first.to_sym].include?(second)
end

def determine_winner(player, computer)
  if win?(player, computer)
    'player'
  elsif win?(computer, player)
    'computer'
  else
    'neither'
  end
end

def display_results(winner)
  if winner == 'player'
    prompt("You won!")
  elsif winner == 'computer'
    prompt("The computer won!")
  else
    prompt("It's a tie!")
  end
end

def display_tallies(tally1, tally2)
  prompt("You have won #{tally1} game(s)")
  prompt("The computer has won #{tally2} game(s)")
end

# BODY OF CODE

player_wins = 0
computer_wins = 0

loop do
  choice = ''

  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = gets.chomp

    if VALID_SHORTHAND.include?(choice)
      choice = VALID_SHORTHAND[choice]
      break
    else
      prompt('Please enter a valid choice.')
    end
  end

  computer_choice = VALID_CHOICES.sample
  prompt("You chose: #{choice}; Computer chose: #{computer_choice}")
  
  winning_player = determine_winner(choice, computer_choice)
  display_results(winning_player)
  
  if winning_player == 'player'
    player_wins += 1
  elsif winning_player == 'computer'
    computer_wins += 1
  end
  
  display_tallies(player_wins, computer_wins)

  if player_wins == 3
    prompt("Congratulations, you're the grand winner!")
    break
  elsif computer_wins == 3
    prompt("Sorry, the computer is the grand winner this time.")
    break
  else
    prompt("Do you want to play again?")
    break unless gets.chomp.start_with?('y') # Break loop if no basically
  end
end

prompt("Thank you for playing. Good bye!")
