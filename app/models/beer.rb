class Beer < ActiveRecord::Base
  belongs_to :brewery
  validates :name, presence: true
  validates :style, presence: true
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user
  include RatingAverage

  def to_s
    "#{name} #{brewery.name}"
  end
end
