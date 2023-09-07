# Tic-Tac-Toe Assignment

# Rules

Input: who goes first, what piece to mark, play again
Output: A 3x3 tic-tac-toe board, displayed and updated with player turn and computer turn, until a winner is displayed and game starts over

- 2 player game
- Board is 3x3
- Take turns placing pieces on the board
- First to reach 3 sqs in a row (including diagonals) wins
- If all 9 are filled in and no winner, the game is a tie

Additional Notes
- A win will only happen at the end of a party's turn, with *that* party being the winner
- If a winner was not determined, there may be a tie. or keep playing

Provided flowchart:

1. Display the initial empty 3x3 board.
2. Ask the user to mark a square.
3. Computer marks a square.
4. Display the updated board state.
5. If winner, display winner.
6. If board is full, display tie.
7. If neither winner nor board is full, go to #2
8. Play again?
9. If yes, go to #1
10. Good bye!

# Bonus Features

1. Improved "join" (account for grammatical english in displaying options)
2. Keep score between rounds
3. Computer AI: Winning move > defend > sq 5 > random sq
4. Ask how first is determined (player/computer/random)
5. Have the main game loop be player-agnostic (suggested `alternate_player` method)

# Examples/Test Cases


# Data Structures
- Basic board data
  - size (single int, to represent eg 3x3 board)

- A board of all squares
  - Each square is empty or not, with a player's token possibly attributed
  - Each square also has a position (col + row, or number alone)
  - Possibly also a name for that position (eg: 1a, 3b)
- Lists for all rows/cols/diagonals
  - rows/cols = array of selection arrays of hashes w/ corresponding sqs

- List of players
  - Each player has a name, assigned token, and cumulative score
- Turn order affects how players added to list??

To check for a win (at the end of a turn):
- For each row & column, & each 3(+?) long diagonal cross-wise:
  - Acquire a list of JUST the associated players/tokens (map it?)
  - Determine if 3 in a row of the same player/token exist
- Note: *who* the winner is is not determined by a method, but when/where this is called.
- Also: Populate 

---

- Constants
  - Max board size
- Variables
  - Board size
  - Number of players
  - Number of computers
  - Who goes first (players, computers, random)
- Processes
  - game_intro
    - display rules
    - use default settings?
    - Ask for number of xyz
  - Display token assignments
  - Display board
  - Validate choice (input valid options, return answer)
- Information to calculate
  - Board size...
  - Board of all squares
  - Lists of all rows/cols/diags
  - List of squares ranked by order of closeness to middle...
  - Participant names, tokens, scores
  - Participant turn order
- Checks
  - Did the participant win?
  - Is the board tied? (all sqs empty?)
  - Is this a winning string? / 3 in a row?
  - Is this an almost winning string? / 2 in a row?
  - Is this a wide-open option? (-x-, x--, --x)
- Best location finding
  - Find winning move
    - Of all lines, select ones w/ almost winning str for current token
  - Find defending move
    - Of all lines, select ones w/ almost win str for OTHER tokens
  - Find set-up squares (optional)
    - Of all lines, select ones w/ wide open options for self
  - Find middle-most square
    - Pick first from middle-ranked list that's empty
  - Find random square
    - Sample from all empty
- Turn-based methods
  - pick_piece
    - calls either player_picks_piece or computer_picks_piece
  - place_piece

# Algorithms

- Initialize default variable settings
- Run game-intro
  - Display rules
  - Ask if would like to use default settings? y/n
    - If yes, how large board/how many computers/players/match limit
- Outer game loop (btwn rounds)
  - Sort out turn order
  - Initialize/clear board and other info
  - single round loop (plays turns until game-over):
      - pick_piece for current_player:
        - If player, player_picks_piece:
          - Prompt for piece placement
          - return proper actual square
        - Elsif computer, computer_picks_piece:
          - location = if/then tree for options...
          - ...
          - return proper square
      - place_piece from pick_piece
      - if someone won:
        - display congrats to current player!
        - update current player's score
        - break
      - if tie:
        - inform it was a tie
        - break
  - a game has ended...
  - display total scores
  - grand winner = find winning threshold participant
  - if grand winner found:
    - congrats grand winner!
    - would you like to restart the scoreboard and play again?
    - if yes: set all scores to 0, no: break
  - else:
    - Play another round?
    - break if no
  - otherwise, next loop
- thank you for playing!

---

- Initialize default settings
- game_intro
  - `display_rules`
  - `change_rules` if `yes?`

  - participants = `generate_participant_list` 
    - [an array of hashes]
    - name: string_name, token: tokens.unshift(?), score = 0
  - token_reminder = `generate_token_reminder` [a string]
- loop do
  - turn_order = `generate_turn_order` (participants, who's first)
  - board = `generate_board` (board size)
  - current_player = turn_order[0]

  - loop do
    - print token_reminder
    - `display_board` (board)
    - print "it's current_player's turn"

    - **FOR NEXT TIME: SORT OUT PICKING PLAYER PIECES**
    
    - piece = `pick_piece` (current_player, board)
      - if current_player is a player
        - `pick_player_piece` (board)
          - `display_empty_squares` (board)
            - uses `empty_squares` and possibly a separate `comma_and`?
          - prompt for piece until empty_squares contains that piece
          - return respective square
      - else
        - `pick_computer_piece` (current_player, board/all_lines?)
    - `place_piece` (current_player, piece)

    - if `someone_won?` (board)
      - print "current_player won!"
      - current_player[:score] += 1
      - break
    - elsif `board_tied?` (board)
      - print "It's a tie!"
      - break
    - end

    - `alternate_current_player`
  - end

  - `display_scoreboard`
  - grand_winner = `find_grand_winner`
  - if grand_winner
    - print congrats grand_winner
    - prompt to reset scoreboard
    - if `yes?`
      - `reset_scoreboard`
    - else break
  - else
    - play next round?
    - break unless yes?
  - end
- thanks for playing!

---
Winning move > defend > sq 5 > random sq
- if there is an opening for computer to win, take that
- else, if there is an opening for someone else to win, take that
- else, if the middle square is open, take that
- else, pick a random square

when searching for a qualifying match:
- find_index among mapped array of lines
- if index found, pick the *correct* empty square

<!-- idx = nil
if idx.nil? then idx = find_winning_line
if idx.nil? then idx = find_blocking_line
if idx.nil? then idx = find_middle_sq
if idx.nil? then idx = find_empty_sq
return pick_correct_empty_sq (for the first two?) -->

---
**current computer logic:**
lines_as_strings = mapped all_lines

line = nil (replaced with index of a line)
line = find_winning_line (return index from mapped lines)
if line.nil? then find_blocking_line (return index from mapped lines)

if line then return pick_sq_from_line (give idx to lines, return sq)
else
  - square = find_middle_sq (board)
  - if square.nil? square = find_random_sq (board)
  - return square

**NEXT TO DO: given the current structures, write computer logic**
- smth like: find the idx of all_lines that is a match. then using that
  - idx on all_lines, find the specific empty sq of the array

**NEXTER TO DO: board_info hash for :size, :rows, :cols, etc?**
- board is a HASH with :squares, as well

---

- `pick_computer_piece` (current_player, board/all_lines?)
  - save `all_lines_as_strings` where map each line in the array to be a string of its tokens
  - if `opening_to_win?` with current token






  - find_winning_choice
    - of each line in the array, grab the first line where
      - `squares_as_strings` returns


---

### For diagonals

- On a chess board...
- Going up:
  - from first row on:
    - [1a, 2b, 3c, 4d, 5e, 6f, 7g, 8h]
    - [1b, 2c, 3d, 4e, 5f, 6g, 7h]
    - [1c, 2d, 3e, 4f, 5g, 6h]
    - [1d, 2e, 3f, 4g, 5h]
    - column always starts from 1
    - row is current iteration upto end
  - from first col on:
    - row always starts from 1
    - col is current iteration upto end
- Going down
  - [8a, 7b, 6c, 5d, 4e, 3f, 2g, 1h]
  - [7a, 6b, 5c, 4d, 3e, 2f, 1g]
  - [6a, 5b, 4c, 3d, 2e, 1f]
  - [5a, 4b, 3c, 2d, 1e]
  - [4a, 3b, 2c, 1d]
  - column is always current iteration downto beginning
  - row always starts from 1

### For middle sq

- if odd (7 / 2) = 3 (correct index for sq 4)
- if even (8 / 2) = 4 (upper bounds for middle idx, also need idx -1)