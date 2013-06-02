class LwrcaseInv < ActiveRecord::Migration
  def up
  	rename_table :Inventories, :inventories
  end

  def down
  end
end
