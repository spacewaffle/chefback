class ChangePriceCurrentToMarketPrice < ActiveRecord::Migration
  def change
    rename_column :ingredients, :price_current, :market_price
  end
end
