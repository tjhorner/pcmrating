class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :ratings
  has_many :games, through: :ratings
  has_many :added_games, class_name: 'Game'

  validates :username, presence: true, uniqueness: true

end
