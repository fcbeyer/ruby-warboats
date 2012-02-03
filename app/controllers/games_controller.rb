class GamesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_user, :only => [:show, :edit, :delete]
  
  def check_user
    @player = current_user.players.where(game_id: params[:id]).first
    if @player.nil?
      redirect_to games_url, :notice => "You cannot look at another player's game!"
    end
  end
  
  
  # GET /games
  # GET /games.json
  def index
    @games = current_user.games

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/new
  # GET /games/new.json
  def new
    
    #find all users except the one currently logged in
    @user_opponent_list = User.find(:all, :conditions => ["id != ?", current_user.id])
    
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(params[:game])
    
    #create opponent Player entry using paramets passed from new game form
    opponent_user_id = params[:user_id]
    opponent = Player.new
    opponent.user_id = opponent_user_id
    
    #create creator (person creating game) Player entry
    creator = Player.new
    creator.user_id = current_user.id
    
    #save both new Player entries when game is saved
    @game.players.push(opponent)
    @game.players.push(creator)
    @game.current_player = opponent

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :ok }
    end
  end
end
