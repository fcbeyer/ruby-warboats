class Ship < ActiveRecord::Base
  belongs_to :ship_type
  belongs_to :player
  belongs_to :game
  
  validates :x, :numericality => {:greater_than_or_equal_to => 1}
  validates :x, :numericality => {:less_than => 11}
  validates :y, :numericality => {:greater_than_or_equal_to => 1}
  validates :y, :numericality => {:less_than => 11}  
  validate :single_ship_use, :on => :create
  validate :ship_intersection, :on => :create
  validate :valid_ship_location, :on => :create
  
  def ship_intersection
    #make sure where the ships are not intersecting when being placed on the board
    ship_owner = Player.find(self.player_id)
    created_ships = ship_owner.ships
    ranges = ship_range(self)
    created_ships.each do |current_ship|
      other_ranges = ship_range(current_ship)
      if intersect?(ranges, other_ranges)
        errors.add(:ship_type_id, " cannot be created here")
      end
    end
  end
  
  def ship_range(ship)
    if ship.vertical?
      ranges = {xr: ship.x..ship.x, yr: ship.y...(ship.y + ship.ship_type.length)}
    else
      ranges = {xr: ship.x...(ship.x + ship.ship_type.length), yr: ship.y..ship.y}
    end
  end
  
  def intersect?(ranges, other_ranges)
    return ((ranges[:xr].max < other_ranges[:xr].begin or other_ranges[:xr].max < ranges[:xr].begin) and
            (ranges[:yr].max < other_ranges[:yr].begin or other_ranges[:yr].max < ranges[:yr].begin))
  end
  
  def single_ship_use
    #check to see if ship being created already exists for this player in this game
    ship_owner = Player.find(self.player_id)
    created_ships = ship_owner.ships
    created_ships.each do |current_ship|
      if self.ship_type.name == current_ship.ship_type.name
        errors.add(:ship_type_id, " already exists for this game")
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
