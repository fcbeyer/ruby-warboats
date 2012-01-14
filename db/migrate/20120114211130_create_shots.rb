class CreateShots < ActiveRecord::Migration
  def change
    create_table :shots do |t|
      
      t.integer :player_id
      t.integer :game_id
      t.integer :x
      t.integer :y
      t.boolean :hit

      t.timestamps
    end
  end
end
