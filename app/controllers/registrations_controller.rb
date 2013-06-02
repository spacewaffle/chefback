class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    customer = Stripe::Customer.create(
      card: params[:user][:stripe_id],
      description: params[:user][:email]
    )

    params[:user][:stripe_id] = customer.id
    @user = User.new(params[:user])
    
    logger.debug "User's stripe id is #{@user.stripe_id}"

    if @user.save
      redirect_to inventories_path, notice: "user was successfully created"
    else
      render "new"
    end
  end

  def update
    super
  end

protected
	def after_sign_up_path_for(resource)
		edit_user_path(current_user.id)
	end
end
	