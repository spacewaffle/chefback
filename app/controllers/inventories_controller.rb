class InventoriesController < ApplicationController
  # GET /inventories
  # GET /inventories.json

  def index
    @inventories = Inventory.all
    @myinventory = Inventory.find_all_by_user_id(current_user.id)
    @myingredients = Ingredient.find_all_by_user_id(current_user.id)
    
        respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventories }



    end

    
  end

  def replenish_all
    @inventories = Inventory.all
    @order = []
    max = 20
    incr = 0
    charge = 0
    @inventories.each do |e|
      temp_order = {}
      temp_order[:id] = incr +=1
      temp_order[:name] = e.ingredient.name
      temp_order[:quantity] = e.quantity
      temp_order[:price] = e.ingredient.price
      @order.push temp_order

      charge += (max - e.quantity) * e.ingredient.price
      e.quantity = max
      e.save
    end
    @order.save
    Stripe::Charge.create(
          :amount => charge, # in cents
          :currency => "usd",
          :customer => current_user.stripe_id
    )
    render "index"
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
