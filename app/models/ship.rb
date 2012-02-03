class Ship < ActiveRecord::Base
  belongs_to :ship_type
  belongs_to :player
  belongs_to :game
  
  validates :x, :numericality => {:greater_than_or_equal_to => 0}
  validates :x, :numericality => {:less_than => 11}
  validates :y, :numericality => {:greater_than_or_equal_to => 0}
  validates :y, :numericality => {:less_than => 11}  
  validate :single_ship_use, :on => :create
  validate :valid_ship_location, :on => :create
  
  def single_ship_use
    #check to see if ship being created already exists for this player in this game
    ship_owner = Player.find(self.player_id)
    created_ships = ship_owner.ships
    created_ships.each do |current_ship|
      if self.ship_type.name == current_ship.ship_type.name
        errors.add(:ship_type_id, "already exists for this game")
      end 
    end
    
  end
  
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
