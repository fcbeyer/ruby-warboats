class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      
      t.integer :game_id
      t.integer :player_id
      t.integer :x
      t.integer :y
      t.integer :health
      t.boolean :vertical

      t.timestamps
    end
  end
end
