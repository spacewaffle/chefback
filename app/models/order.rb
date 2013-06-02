class Order < ActiveRecord::Base
  attr_accessible :items
  serialize :items
end
