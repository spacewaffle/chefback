class ChangeStripeCardTokenToStripeId < ActiveRecord::Migration
  def change
    rename_column :users, :stripe_card_token, :stripe_id
  end
end
