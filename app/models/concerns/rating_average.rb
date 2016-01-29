module RatingAverage
  extend ActiveSupport::Concern
  def average_rating
    return ratings.map(&:score).inject(0, &:+).to_f / ratings.size
  end
end
