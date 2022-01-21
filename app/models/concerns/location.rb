module Location
  def self.included(base)
    base.extend(ClassMethods)
  end

  module InstanceMethods
    def openings(start, finish)
      listings.map do |list|
        list if list.available?(Date.parse(start), Date.parse(finish))
      end
    end
  end

  module ClassMethods
    def highest_ratio_res_to_listings
      ratio = { hood: self.new, ratio: 0 }
      self.all.each do |hood|
        list_num = hood.listings.count #number of each listing in a neighborhood
        hood.listings.each do |list|
          res_num = list.reservations.count # number of reservations in a listing
          if (res_num / list_num) > ratio[:ratio]
            ratio[:ratio] = (res_num / list_num)
            ratio[:hood] = hood
          end
        end
      end
      ratio[:hood]
    end

    def most_res
      res = 0
      n_hood = self.new
      self.all.each do |hood|
        hood.listings.each_with_index do |l|
          if l.reservations.count > res
            res = l.reservations.count
            n_hood = hood
          end
        end
      end
      n_hood
    end
  end
end
