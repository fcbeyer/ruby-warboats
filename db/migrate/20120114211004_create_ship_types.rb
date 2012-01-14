class CreateShipTypes < ActiveRecord::Migration
  def change
    create_table :ship_types do |t|
      
      t.integer :length
      t.string :name

      t.timestamps
    end
  end
end
