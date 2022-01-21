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
  after_destroy :set_host_to_false

  def average_review_rating
    total_ratings = 0.0
    reviews.each do |r|
      total_ratings += r.rating.to_f
    end
    (total_ratings / reviews.length)
  end

  def available?(start_date, end_date)
    temp = true
    reservations.each do |res|
      if included?(res,start_date) || included?(res,end_date)
        temp = false
      end
    end
    temp
  end

  private

  def included?(res,date)
    (res.checkin..res.checkout).to_a.include?(date)
  end

  def set_host_to_true
    self.host.update(host: true)
  end

  def set_host_to_false
    if host.listings.empty?
      host.update(host: false)
    end
  end
end
