class AddCityToSpaces < ActiveRecord::Migration
  def change
    add_column :spaces, :city, :string
  end
end
