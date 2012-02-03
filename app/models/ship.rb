class Ship < ActiveRecord::Base
  has_one :ship_type
  belongs_to :player
  belongs_to :game
  
  validates :x, :numericality => {:greater_than_or_equal_to => 0}
  validates :x, :numericality => {:less_than => 11}
  validates :y, :numericality => {:greater_than_or_equal_to => 0}
  validates :y, :numericality => {:less_than => 11}  
  validate :valid_ship_location, :on => :create
  
  def valid_ship_location
    if self.vertical?
      if (self.y + self.health) > 10
        errors.add(:y, " coordinate to high with this ship\'s length")
      end
    else
      if (self.x + self.health) > 10
        errors.add(:x, "x coordinate to high with this ship\'s length")
      end
    end
  end
  
end
