class Inventory < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :ingredient
	attr_accessible :ingredient_name, :quantity, :low_quantity, 
                  :user_id, :ingredient_id, :warning



  def replentish_all
    customer = Stripe::Customer.create(description: email, card: stripe_id)
    self.stripe_customer_token = customer.id

    Stripe::Charge.create(
    :amount => 1000, # in cents
    :currency => "usd",
    :customer => customer.id
)
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while charging customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
end
