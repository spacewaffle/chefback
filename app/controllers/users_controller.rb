class UsersController < ApplicationController
	before_filter :authenticate_user!
	def index
	end

	def new
		@user = User.new
	end

	def edit
		@user = User.find(params[:id])
		if current_user.id != params[:id].to_i
			redirect_to user_path(params[:id])
		end
	end

	def create
		logger.debug "User's stripe token is #{params[:stripe_id]}"
		customer = Stripe::Customer.create(
		  card: params[:stripe_id],
		  description: @user.email
		)
		params[:stripe_id] = customer.id
		@user = User.new(params[:user])
		
		logger.debug "User's stripe id is #{@user.stripe_id}"

		if @user.save
			redirect_to @user, notice: "user was successfully created"
		else
			render "new"
		end
	end

	def update
		@user = User.find(params[:id])
		@user.update_attributes(params[:user])
		respond_with @user
	end

	def destroy
		@user = user.find(params[:id])
		@user.destroy
		redirect_to users_url
	end

end