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
