class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, class_name: "User"

  
  validates :rating, :description, :reservation, presence: true
  validate :valid_reservation
  validate :check_checkout

  private

 def valid_reservation
  errors.add(:reservation, 'Reservation is not accepted.') unless reservation && self.reservation.status != 'pending'
 end

 def check_checkout
  errors.add(:reservation, 'You have not checked out yet.') unless reservation && reservation.checkout.past?
 end

  
end
