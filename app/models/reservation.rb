class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, class_name: 'User'
  has_one :review

  validates :checkin, :checkout, presence: true

  validate :guest_is_not_host
  validate :listing_availability
  validate :dates_are_valid

  def duration
    (checkin...checkout).to_a.length
  end

  def total_price
    duration * listing.price
  end

  private

  def guest_is_not_host
      errors.add(:guest, "Host and guest cannot be the same") unless (guest && listing.host) && guest.id != listing.host.id
  end

  def listing_availability
    errors.add(:listing, "This listing is not available for the dates you requested") unless listing.available?(checkin,checkout)
  end

  def dates_are_valid
    errors.add(:checkin, "The dates are not in a valid format") unless ((checkin && checkout) && (checkin < checkout))
  end
end
