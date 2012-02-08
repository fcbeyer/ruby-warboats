class Shot < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  
  validates :x, :numericality => {:greater_than_or_equal_to => 1}
  validates :x, :numericality => {:less_than => 11}
  validates :y, :numericality => {:greater_than_or_equal_to => 1}
  validates :y, :numericality => {:less_than => 11}
  
  validate :previous_shot, :on => :create
  
  def previous_shot
    player = Player.find(self.player_id)
    list_of_shots = player.shots
    list_of_shots.each do |current_shot|
      if (self.x == current_shot.x) and (self.y == current_shot.y)
        errors.add(:x, " already has been shot at")
      end
    end
  end
   
end