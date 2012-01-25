class ShipTypeValues < ActiveRecord::Migration
  def up
    file = File.new("db/fixtures/ShipTypes.txt","r")
    while(line = file.gets)
        line = line.strip.split(",")
        st = ShipType.create(name: line[0],length: line[1])
    end
  end

  def down
    ShipType.delete_all
  end
end
