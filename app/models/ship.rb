class Ship < ActiveRecord::Base
  has_one :ship_type
  belongs_to :player
  belongs_to :game
  
  validate :valid_ship_location, :on => :create
  
  def valid_ship_location
    if self.x < 0 || self.x > 10
      errors.add(:x, "x coordinate is invalid, must be within 10x10 grid")
    elsif self.y < 0 || self.y > 10
      errors.add(:y, "y coordinate is invalid, must be within 10x10 grid")
    elsif self.vertical?
      if self.y+self.health > 10
        errors.add(:y, " coordinate to high with this ship\'s length")
      end
    elsif !self.vertical?
      if self.x+self.health > 10
        errors.add(:x, "x coordinate to high with this ship\'s length")
      end
    end
  end
  
end
