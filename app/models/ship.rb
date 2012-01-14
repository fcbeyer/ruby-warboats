class Ship < ActiveRecord::Base
  has_one :ship_type
  belongs_to :player
  belongs_to :game
end
