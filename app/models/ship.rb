class Ship < ActiveRecord::Base
  has_one :ship_type
  belongs_to :player
  belongs_to :game
end

  def ship_hit
    #was the ship hit?
  end
  
  def ship_sunk
    #has the ship been sunk?
  end
