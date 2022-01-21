class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  validates :address, presence: true
  validates :listing_type, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :neighborhood, presence: true
  validates :host_id, presence: true

  after_save :update_to_host
  after_destroy :remove_host

  def average_review_rating
    reviews.average(:rating)
  end

  def available?(checkin, checkout)
    flag = true
    reservations.each do |res|
      range = (res.checkin...res.checkout).to_a
      if range.include?(checkin) || range.include?(checkout)
        flag = false
      end
    end
    flag
  end

  private

  def update_to_host
    self.host.update(host: true)
  end

  def remove_host
    if host.listings.empty?
      host.update(host: false)
    end
  end
end
