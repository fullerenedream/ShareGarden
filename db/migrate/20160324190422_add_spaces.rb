class AddSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.references :user, index: true
      t.string :unit_number
      t.string :street_address
      t.string :province
      t.string :postal_code
      t.string :country
      t.float :square_meters
      t.boolean :outdoors
      t.string :main_photo
      t.text :description
      t.timestamps null: false
    end
  end
end
