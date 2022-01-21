class Reservation < ActiveRecord::Base

  #   t.date     "checkin"
  #   t.date     "checkout"
  #   t.integer  "listing_id"
  #   t.integer  "guest_id"
  #   t.datetime "created_at",                     null: false
  #   t.datetime "updated_at",                     null: false
  #   t.string   "status",     default: "pending"
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validates :checkin, :checkout, presence: true, alllow_nil: false
  validates :checkout, comparison: { greater_than: :checkin }
  validate :not_listing_host?
  validate :availabile?

  def duration
    (checkin...checkout).to_a.length
  end

  def total_price
    duration * listing.price
  end

  private

  def not_listing_host?
    errors.add(:guest_id, "You are the host of this listing") unless (self.guest.id != listing.host.id)
  end

  def availabile?
    errors.add(:listing, "Listing is unavailable for these dates") unless listing.available?(checkin, checkout)
  end
end
