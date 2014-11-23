class Card < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :deck
  has_many :guesses

  def check(answer)
    self.answer.strip.downcase == answer.strip.downcase
  end

end
