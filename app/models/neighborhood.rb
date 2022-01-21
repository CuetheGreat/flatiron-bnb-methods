class Neighborhood < ActiveRecord::Base
  include Location::InstanceMethods
  extend Location::ClassMethods

  belongs_to :city
  has_many :listings

  def neighborhood_openings(start, finish)
    openings(start, finish)
  end
end
