BUST_LIMIT = 21
DEALER_LIMIT = 17

def prompt(text)
  puts "=> #{text}"
end

def linebreak
  puts "=============="
end

def list_cards(party)
  # Note that :hand is an array of hashes (individual cards)
  cards = party[:hand].map { |card| card[:name] }
  if cards.size == 2
    cards.join(' and ')
  else
    last_card = cards.pop
    cards.join(', ') + ", and #{last_card}"
  end
end

def show_hands(parties)
  system 'clear'
  dealer_card = parties[0][:hand].first[:name]
  prompt("Dealer has: #{dealer_card} and unknown card")
  prompt("You have: " + list_cards(parties[1]))
  prompt("Your hand is worth: #{parties[1][:total]}")
end

def draw_card(party, deck)
  card = deck.pop
  party[:hand] << card
  party[:total] += card[:val]
  check_aces(party)
end

def bust?(party)
  party[:total] > BUST_LIMIT
end

def update_aces(party, idx)
  party[:hand][idx][:val] = 1
  party[:total] -= 10
end

def check_aces(party)
  if bust?(party)
    idx = party[:hand].find_index { |card| card[:val] == 11 }
    if idx
      update_aces(party, idx)
      check_aces(party)
    end
  end
end

system 'clear'
prompt("Welcome to 21!")
linebreak
prompt("Hit to draw cards, getting as close to 21 without going over!")
prompt("Number cards are their stated value, face cards are worth 10,")
prompt("and aces are worth 11 or 1, whichever keeps you from busting!")
linebreak
prompt("Whenever you're ready, press Enter to start playing.")
gets
system 'clear'

dealer = { name: 'Dealer', score: 0 }
player = { name: 'Player', score: 0 }
parties = [dealer, player]

loop do
  winner = nil

  parties.each do |party|
    party[:total] = 0
    party[:hand] = []
  end

  deck = []
  (2..10).each do |num|
    4.times do
      deck << { name: num.to_s, val: num }
    end
  end
  %w(Jack Queen King).each do |face|
    4.times do
      deck << { name: face, val: 10 }
    end
  end
  4.times do
    deck << { name: 'Ace', val: 11 }
  end
  deck.shuffle!

  parties.each do |party|
    2.times do
      draw_card(party, deck)
    end
  end

  loop do
    show_hands(parties)

    prompt("(H)it or (S)tay?")
    answer = gets.chomp.downcase

    if answer.start_with?('h')
      draw_card(player, deck)
      if bust?(player)
        winner = dealer
        show_hands(parties)
        prompt("You bust!")
        break
      end
    elsif answer.start_with?('s')
      break
    end
  end

  if winner.nil?
    until dealer[:total] >= DEALER_LIMIT
      draw_card(dealer, deck)
      if bust?(dealer)
        winner = player
        prompt("Dealer bust!")
      end
    end
  end

  dealer_cards = list_cards(dealer)
  player_cards = list_cards(player)

  linebreak
  prompt("Dealer has #{dealer_cards}, for a total of: #{dealer[:total]}")
  prompt("Player has #{player_cards}, for a total of: #{player[:total]}")
  linebreak

  if winner.nil?
    if player[:total] > dealer[:total]
      winner = player
    elsif player[:total] < dealer[:total]
      winner = dealer
    end
  end

  if winner
    prompt("#{winner[:name]} won!")
    winner[:score] += 1
  else
    prompt("It was a tie!")
  end

  prompt("Player: #{player[:score]}, Dealer: #{dealer[:score]}")
  grand_winner = parties.find_index { |party| party[:score] >= 5 }

  if grand_winner
    prompt("#{parties[grand_winner][:name]} has won 5 matches!")
    break
  else
    prompt('Play again? (Y/N)')
    break if gets.chomp.downcase.start_with?('n')
  end
end

puts "Thank you for playing!"
