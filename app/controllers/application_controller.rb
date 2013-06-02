class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  @stripe_public_key = stripe_public_key
end
