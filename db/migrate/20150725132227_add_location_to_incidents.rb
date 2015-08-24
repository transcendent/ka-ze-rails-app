class AddLocationToIncidents < ActiveRecord::Migration
  def change
    add_column :incidents, :latitude, :decimal, :precision => 5, :scale => 3
    add_column :incidents, :longitude, :decimal, :precision => 6, :scale => 3
  end
end
