class UpdatePriceDefaultsToCents < ActiveRecord::Migration
  def change
    change_column :ingredients,:price,:integer, :default=>500
    change_column :ingredients,:price_current,:integer,:default=>500
    if !User.find_by_email("admin@example.com")
      User.create!(:email => 'admin@example.com', :password => 'password')
    end
  end
end
