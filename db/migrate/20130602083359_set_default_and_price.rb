class SetDefaultAndPrice < ActiveRecord::Migration
  def up
  	change_column :inventories,:ingredient_id,:integer
  	change_column :foods, :user_id, :integer
  	change_column :inventories,:quantity,:integer,:default=>20
  	change_column :inventories,:warning,:integer,:default=>0
  	change_column :ingredients,:quantity_used,:integer,:default=>5
  	change_column :ingredients,:price,:integer, :default=>5
  	add_column :ingredients,:price_current,:integer,:default=>5

  end

  def down
  end
end
