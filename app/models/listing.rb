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

  before_create :set_host_to_true
  before_destroy :set_host_to_false

  def average_review_rating
    total_ratings = 0.0
    reviews.each do |r|
      total_ratings += r.rating.to_f
    end
    (total_ratings / reviews.length)
  end

  private

  def set_host_to_true
    host.host = true
    host.save
  end

  def set_host_to_false
    user = User.find(host.id)
    if user.listings.length == 1
      user.host = false
      user.save
    end
  end
end
