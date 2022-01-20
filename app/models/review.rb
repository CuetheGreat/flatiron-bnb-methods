class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, class_name: "User"

  validates :reservation, presence: true, unless: Proc.new { |a| a.reservation.status == "Pending" }
  validates :rating, :description, :reservation, presence: true

  private

  def status_accepted?
    if reservation
  end
end
