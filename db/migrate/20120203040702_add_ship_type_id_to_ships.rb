class AddShipTypeIdToShips < ActiveRecord::Migration
  def change
    add_column :ships, :ship_type_id, :integer
  end
end
