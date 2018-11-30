class CreateProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :properties do |t|
      t.string :property_id
      t.string :geo_coordinates
      t.text :description
      t.integer :persons
      t.text :general_amenities
      t.float :price_per_night

      t.timestamps
    end
  end
end
