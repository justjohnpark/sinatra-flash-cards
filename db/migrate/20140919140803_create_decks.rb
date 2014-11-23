class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |d|
      d.string :name
      d.timestamps
    end
  end
end
