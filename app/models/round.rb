class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
  has_many :guesses

  @deck = []
  @used_cards = []

  def get_statistics
    guesses = self.guesses
    correct = 0
    guesses.each { |guess| correct += 1 if guess.is_correct? }
    { correct: correct, total: guesses.length }
  end

  def get_missed_questions
    wrong = self.guesses.select { |guess| guess.is_correct? == false }
    wrong.map {|guess| guess.card.question}
  end

end

