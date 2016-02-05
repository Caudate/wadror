class User < ActiveRecord::Base
  include RatingAverage
  has_secure_password
  validates :username, uniqueness: true, length: { in: 3..15 }
  validates_format_of :password, :with => /\d+/
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings


end
