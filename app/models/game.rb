class Game < ActiveRecord::Base
  has_many :players
  has_many :shots
  belongs_to :current_player, :foreign_key => 'current_players_id', :class_name => 'Player'

  after_create :notify_player
  def notify_player
    #get the User for the opponent so we can send a notification email
    opponent_player = Player.find(self.current_player.id)
    opponent_user = User.find(opponent_player.user_id)
    Notifier.new_game_notification(opponent_user.email).deliver
    
    #Notifier.new_game_notification(userToNotify.email,userToNotify.username,opponent_user.username).deliver
  end
end