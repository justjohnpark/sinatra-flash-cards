require 'csv'

bb = User.create!(
  first_name: "Billy",
  last_name: "Blythe",
  email: "test@test.com",
  password: "test"
)

abc = Deck.create!(name: "ABCs")

capitals = Deck.create!(name: "State Capitals")

abc.cards << Card.create!(question: "What is the first letter of the alphabet?", answer: "A")
abc.cards << Card.create!(question: "What is the second letter of the alphabet?", answer: "B")
abc.cards << Card.create!(question: "What is the third letter of the alphabet?", answer: "C")
abc.save

Round.create!(user: bb, deck: abc)

Guess.create!(
  round: Round.first,
  card_id: 1,
  is_correct?: 'f'
)

Guess.create!(
  round: Round.first,
  card_id: 2,
  is_correct?: 't'
)

Guess.create!(
  round: Round.first,
  card_id: 3,
  is_correct?: 't'
)

round2 = Round.create!(user: bb, deck: capitals)

CSV.foreach("db/state_capitals.csv", :headers => true) do |row|
  new_card = Card.create!(question: row["state"], answer: row["capital"])
  capitals.cards << new_card
  if new_card.id % 10 == 0
    Guess.create!(round: round2, card_id: new_card.id, is_correct?: false )
  else
    Guess.create!(round: round2, card_id: new_card.id, is_correct?: true )
  end
end
capitals.save

# round2.guesses[1].is_correct? = 'f'
# round2.guesses[9].is_correct? = 'f'
# round2.guesses[10].is_correct? = 'f'



