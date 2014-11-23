require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  before_create do
    self.hash_password
    self.first_name.capitalize
    self.last_name.capitalize
  end

  has_many :rounds
  has_many :guesses, through: :rounds
  has_many :decks, through: :rounds

  validates :first_name, :last_name, :email, :password, presence: true
  validates :email, uniqueness: true
  validates :email, :format => { with: /.@.+\../}

  def hash_password
    self.password = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = User.find_by(email: email)
    unless user.nil?
      return user.id if BCrypt::Password.new(user.password) == password
    end
    nil
  end

  def self.register(args)
    new_user = self.create(args)
    if new_user.valid?
      return new_user
    else
      first_error = new_user.errors.first
      return first_error.join(" ").capitalize
    end
  end

  def delete_null_rounds
    null_rounds = self.rounds.select {|round| round.get_statistics[:total] == 0}
    null_rounds.each { |round| round.destroy }
  end

end
