class Ingredient < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :food
  has_many :inventories
	attr_accessible :ingredient_name, :quantity_used, :user_id, :price
end