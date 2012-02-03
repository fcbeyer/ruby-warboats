class ShipsController < ApplicationController
  # GET /ships
  # GET /ships.json
  
  before_filter :authenticate_user!, :get_game
  
  def get_game
    #find all the ship types for the drop down menu in view
    @shiptypes = ShipType.all
    
    @game = Game.find(params[:game_id])
    @player = current_user.players.where(game_id: @game.id).first
    if @player.nil?
      redirect_to root_url, :notice => "You cannot look at another player's game!"
    end
  end
  
  def index
    @ships = @player.ships

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ships }
    end
  end

  # GET /ships/1
  # GET /ships/1.json
  def show
    @ship = Ship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ship }
    end
  end

  # GET /ships/new
  # GET /ships/new.json
  def new
    
    @ship = Ship.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ship }
    end
  end

  # GET /ships/1/edit
  def edit
    @ship = Ship.find(params[:id])
  end

  # POST /ships
  # POST /ships.json
  def create
    @ship = Ship.new(params[:ship])
    @ship_id = params[:ship_name]
    @ship_type = ShipType.find(@ship_id)
    @ship.health = @ship_type.length
    @ship.vertical = true
    @ship.player_id = @player.id

    respond_to do |format|
      if @ship.save
        format.html { redirect_to [@game, @ship], notice: 'Ship was successfully created.' }
        format.json { render json: @ship, status: :created, location: @ship }
      else
        format.html { render action: "new" }
        format.json { render json: @ship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ships/1
  # PUT /ships/1.json
  def update
    @ship = Ship.find(params[:id])

    respond_to do |format|
      if @ship.update_attributes(params[:ship])
        format.html { redirect_to @ship, notice: 'Ship was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @ship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ships/1
  # DELETE /ships/1.json
  def destroy
    @ship = Ship.find(params[:id])
    @ship.destroy

    respond_to do |format|
      format.html { redirect_to ships_url }
      format.json { head :ok }
    end
  end
end
