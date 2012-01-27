class Notifier < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.welcome_email.subject
  #
  def welcome_email (email,username)
    @username = username
    mail to: email
  end
  
  def new_game_notification (email,username,opponent_username)
    @username = username
    @opponent_username = opponent_username
    mail to: email
  end
end
