# Web Flash Cards Using Sinatra

A simple web-based flash card application. Decks have many cards.  A card belongs to a single deck.  When a user signs in, they'll see a list of decks. Users can play a "round," which is a series of guesses over all the cards in a deck.  User should be able to see a list of all the rounds they've completed and statistics for that round (deck used, number guessed, number correct, number incorrect, etc.)

## Instructions
1. clone this directory
2. run 'bundle install' in the terminal from the root directory
3. run 'be rake db:create' in the terminal from the root directory
4. run 'be rake db:migrate' in the terminal from the root directory
5. run 'be rake db:seed' in the terminal from the root directory
6. run 'be shotgun' in the terminal from the root directory
7. open 'http://localhost:9393/' in your browser
