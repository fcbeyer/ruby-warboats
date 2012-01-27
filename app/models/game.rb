class Game < ActiveRecord::Base
  has_many :players
  has_many :shots
  belongs_to :current_player, :foreign_key => 'current_players_id', :class_name => 'Player'

  after_create :notify_player
  def notify_player    
    userToNotify = User.find(self.current_player.user_id)
    opponent_player = Player.where("id != :id and game_id = :game_id",{id: self.current_player.id,game_id: self.id}).first
    opponent_user = User.find(opponent_player.user_id)
    Notifier.new_game_notification(userToNotify.email,userToNotify.username,opponent_user.username).deliver
  end
end