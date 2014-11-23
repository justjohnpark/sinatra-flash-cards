class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |c|
      c.string :question
      c.string :answer
      c.integer :deck_id
      c.timestamps
    end
  end
end
