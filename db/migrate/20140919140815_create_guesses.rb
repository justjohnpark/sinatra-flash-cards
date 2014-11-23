class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |g|
      g.integer :round_id
      g.integer :card_id
      g.boolean :is_correct?
      g.timestamps
    end
  end
end
