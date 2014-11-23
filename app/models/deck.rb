class Deck < ActiveRecord::Base
  # Remember to create a migration!
  has_many :cards
  has_many :rounds

  def generate_shuffled_deck
    self.cards.shuffle
  end

end


# cards_hash = {1: {:question => "What is the color", }}

# def get_card
# deck.cards.each do |x|
#   if not_viewed
# ...
