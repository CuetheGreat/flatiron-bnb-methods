class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, through: :neighborhoods
  has_many :reservations, through: :listings

<<<<<<< HEAD
  def city_openings(start_date, end_date)
    
    res.map { |r| r.listing }
=======
  def city_openings
>>>>>>> 3a8f01b6e1532e51df9fbb8ea6e0fdfab6b7ba7b
  end
end
