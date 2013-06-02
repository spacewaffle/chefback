class Food < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  has_many :ingredients
  attr_accessible :name, :price, :ingredients_attributes, :user_id
  accepts_nested_attributes_for :ingredients
end
