class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |u|
      u.string :first_name
      u.string :last_name
      u.string :email
      u.string :password

      u.timestamps
    end
  end
end
