class FoodRecipeName < ActiveRecord::Migration
  def up
  	rename_table :recipe, :foods
  end

  def down
  end
end
