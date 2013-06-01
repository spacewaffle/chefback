class Inventory < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user

	attr_accessible :ingredient_name, :quantity, :low_quantity, :user_id

end
