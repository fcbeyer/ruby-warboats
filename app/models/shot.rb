class Shot < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
end

  def hit_or_miss
    #did we hit the ship?
  end

  def valid_strike
    #was the shot within the proper grid boundries?
    #was it a shot the user already made?
  end