class SetWarningLevelTo3 < ActiveRecord::Migration
  def change
    change_column :inventories, :price, :integer, :default=>5
  end
end
