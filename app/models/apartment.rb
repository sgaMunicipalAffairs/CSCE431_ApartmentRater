class Apartment < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  def get_reviews
    reviews = Review.where(:apartment_id => self.id)
    return reviews
  end
  def review_count
    return Review.where(:apartment_id => self.id).size
  end
end
