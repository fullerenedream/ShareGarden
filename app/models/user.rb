class User < ActiveRecord::Base

  has_many :spaces
  has_many :favorites
  has_many :favorite_spaces, through: :favorites, class_name: 'Space'

  validates :username, presence: true
  validates :email, presence: true

end
