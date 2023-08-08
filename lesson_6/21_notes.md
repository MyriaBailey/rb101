=begin
Twenty-One Assignment

Note: These are cut/pasted notes from the beginning of my coding process, reflecting initial directions rather than a fully up-to-date commentary on the finished product.

Input: Turn decision to "hit" or "stay" (and perhaps repeat game)
Output: What cards are had by player/dealer, total card values,
  who wins, turn prompts, repeat game prompts

Rules
- Using normal 52 card deck
  - 4 suits (hearts, diamonds, clubs, spades) w/ 13 values each
    - (2 - 10, jack queen king, ace)
- Goal is to get as close to 21 as possible, without going over
- Each round starts with player and dealer given 2 cards each
  - Player can see both cards in their hand
  - Player can NOT see both of the dealer's cards, only one of them
- Number cards worth their listed value, jack/queen/king cards worth 10
  - Aces worth 1 OR 11, determined EACH time a new card is drawn

- Cards are dealt
- Player goes first, can either "hit" or "stay"
  - hit = ask for another card
    - if hit OVER 21 = bust/game over
    - can hit as many times until bust or stay
  - stay = dealer turn
    - dealer MUST hit until the total is AT LEAST 17
      - if bust, player wins 
      - if stay, compute winner

Bonus Features
- Use a local variable to cache the total values of each hand
  - calculate the total as few times as possible basically

- Have a single, consistent, end of round output
  - Perhaps a `winner` variable initialized to `nil` and updated to a
    truthy string value if a winner is determined early?

- Keep track of score, and whoever reaches 5 points first wins

- The two major values `21` and `17` are arbitrary and can be stored as
  constants instead. Do that.

Examples/Test Cases

Dealer has: Ace and unknown card
You have: 2 and 8

Dealer has: 5 and unknown card
You have: Jack and 6


Data Structures
- Deck of cards (initialized at beginning of each game, shuffled perhaps)
  - Each card has a name, invisible suit?, and point value
  - Default aces to 11 points
  - STRUCTURED AS: An array of hashes
    - EACH HASH: { name: card_name, value: int_val }

- Player and Dealer's hands (dealt 2 cards each, added to)
  - An array of hashes, where each hash has :name, :value

- A HASH EACH FOR PLAYER AND COMPUTER
  - hand, total

- Total score between rounds
- Tally of each hand's total value
  - When a new card is added, add the value to the running total
  - If it exceeds 21, check if there are any aces of value 11
    - If so, subtract 10 from the total and change the ace value to 1
      - redo the same > 21 check
    - If does not exceed 21, carry on

Algorithms

---

Overview:
Intro
- [ ] Welcome the player to 21
- [ ] Brief intro to rules?
- [ ] Y/N confirmation??
- [x] Initialize parties/score to [0, 0]

Outer Game Loop
- [ ] Play a round of 21 (Inner Game)
- [ ] Update score based on winner (Here or inner game loop?)
- [ ] Display score

- [ ] If ANY score value >= 5
- [ ] Declare grand winner (may if/then individual score vals instead)
- [ ] Else: Ask if wish to play again? (Break OGL if yes)

End
- [x] Thank you for playing!

Game itself:
- [x] Initialize the deck
- [x] `initialize_deck` method call: (not a method actually!)
  - [x] `cards` = empty array
  - [x] On a range of ints 2 - 10 inclusive:
        - Create 4 hashes ea. of name: int as str, val: int + add to cards
  - [x] For strings (jack queen king) each,
        - Create 4 hashes name: str_name, val: 10 + add to cards
  - [x] Add 4 hashes name: ace, val: 11 + add to cards
  - [x] Return a shuffled cards array and close the method
- [x] Initialize player/dealer hands/totals to 0
- [x] Deal the cards
  - [x] Add to each hand 2 method calls of `draw card`
    - [x] Draw Card Method (deck, hand, total):
      - [x] pop a card from the deck and add hash to hand
      - [x] Add to total: the last card in hand's value

- [ ] Player Turn Loop
  - [x] Display current hands Method Call:
    - [x] !!!!!!!!!
  - [x] Ask if hit or stay
  - [ ] If hit: (CONVERT TO A HIT METHOD CALL)
    - [ ] Draw a card method call
    - [ ] Bust? Method Call (hand, total):
      - [ ] If total > 21
        - [ ] If hand contains any aces of value 11:
          - [ ] Subtract 10 from total
          - [ ] Locate an ace of value 11 and change value to 1
          - [ ] Run Bust? method again
        - [ ] Else: It's a bust! return true
      - [ ] Else: Not a bust! return false
    - [ ] If bust?
      - winner = "dealer"
      - break loop entirely
  - [ ] Close loop

- [ ] Dealer Turn Loop (ONLY if winner is falsey/nil)
  - [ ] Until total is >= 17 (CALL HIT METHOD?)
    - [ ] Draw a method call
    - [ ] If bust? winner = "player" & break loop

- [ ] Compute Results
  - [ ] Display totals of both hands
  - [ ] If winner != truthy, Determine which total is greater ...

  - [ ] Print who's the winner!
  - [ ] Update + print score according to winner
  - [x] Ask if play again? break if no

=end