class CreatePlayers < ActiveRecord::Migration
  def up
    create_table :players do |t|
      
      t.integer :user_id
      t.integer :score
      t.integer :game_id
      
      t.timestamps
    end
    add_column :games, :current_players_id, :integer
  end
  
  def down
    remove_column :games, :current_players_id
    drop_table :players
  end
end
