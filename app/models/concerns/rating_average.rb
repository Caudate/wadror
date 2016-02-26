module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    return 0 if ratings.empty?
    ratings.inject(0.0){ |sum, r| sum+r.score } / ratings.count
  end
end
