class PriceAttrTableChange < ActiveRecord::Migration
  def up
  	remove_column :foods, :price
  	add_column :ingredients, :price, :integer
  end

  def down
  end
end