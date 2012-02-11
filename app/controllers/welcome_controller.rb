class WelcomeController < ApplicationController
  def index
    redirect_to games_url unless current_user.nil?
  end
end
