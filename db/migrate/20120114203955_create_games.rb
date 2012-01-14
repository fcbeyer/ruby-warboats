class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.boolean :completed

      t.timestamps
    end
  end
end
