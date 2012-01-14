class Game < ActiveRecord::Base
  has_many :players
  has_many :shots
  has_one :current_player, :foreign_key => 'current_players_id', :class_name => 'Player'
end
