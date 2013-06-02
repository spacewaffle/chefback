class InventoriesController < ApplicationController
  # GET /inventories
  # GET /inventories.json
respond_to :html, :json
  def index
    @inventories = Inventory.all
    @myinventory = Inventory.find_all_by_user_id(current_user.id)
    @myingredients = Ingredient.find_all_by_user_id(current_user.id)
    @replenish_charge = 0
    @inventories.each do |e|
      ingredient = Ingredient.find_by_id(e.ingredient_id)
      @replenish_charge += (e.max - e.quantity) * ingredient.market_price
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventories }
    end
  end

  def replenish_all
    @inventories = Inventory.all
    @myinventory = Inventory.find_all_by_user_id(current_user.id)
    @myingredients = Ingredient.find_all_by_user_id(current_user.id)
    Stripe.api_key = ENV['Stripe.api_key']
   
    @order = Order.new(items: [])
    incr = 0
    charge = 0
    logger.debug "this is all inventory #{@inventories}"
    @replenish_charge = 0
    @inventories.each do |e|
      ingredient = Ingredient.find_by_id(e.ingredient_id)
      logger.debug "this is the individual inventory's ingredients #{ingredient}"
      temp_order = {}
      temp_order[:id] = incr +=1
      temp_order[:name] = ingredient.ingredient_name
      temp_order[:quantity] = e.quantity
      temp_order[:price] = ingredient.market_price
      @order[:items].push temp_order

      charge += (e.max - e.quantity) * ingredient.market_price
      e.update_attributes(quantity: e.max)
    end
    logger.debug "current user's stripe id is "
    Stripe::Charge.create(
          :amount => charge, # in cents
          :currency => "usd",
          :customer => current_user.stripe_id
    )
    @order.save
    redirect_to "index"
  end

  # GET /inventories/1
  # GET /inventories/1.json
  def show
    @inventory = Inventory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory }
    end
  end

  # GET /inventories/new
  # GET /inventories/new.json
  def new
    @inventory = Inventory.new
    @inventories = Inventory.find_by_user_id(current_user.id)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory }
    end
  end

  # GET /inventories/1/edit
  def edit
    @inventory = Inventory.find(params[:id])
  end

  # POST /inventories
  # POST /inventories.json
  def create
    @inventory = Inventory.new(params[:inventory])

    respond_to do |format|
      if @inventory.save
        format.html { redirect_to @inventory, notice: 'Inventory was successfully created.' }
        format.json { render json: @inventory, status: :created, location: @inventory }
      else
        format.html { render action: "new" }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
    

  end

  # PUT /inventories/1
  # PUT /inventories/1.json
  def update
    @inventory = Inventory.find(params[:id])
    respond_to do |format|
      if @inventory.update_attributes(params[:inventory])
        format.html { redirect_to @inventory, notice: 'Inventory was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventories/1
  # DELETE /inventories/1.json
  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory.destroy

    respond_to do |format|
      format.html { redirect_to inventories_url }
      format.json { head :no_content }
    end
  end
end
