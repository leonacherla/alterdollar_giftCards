require 'securerandom'

class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  def redeem
    code = params[:code]
    result = Receipt.where(adr: params[:code])
    if result != []
      @resp = {
        "message" => "Redemption Successful."
      }
    else
      @resp = {
        "message" => "Error in redemption code"
      }
    end
    render json: @resp
  end

  def place_order
    
    #TODO: Currently only one card per order, make the order have provisions for multiple card orders.

    # temp = Card.where(card_status: "Just Created", sender_username: session[:username]).limit(1)
    # @id = nil
    # @net = 0
    
    # puts "*****************************"
    # temp.each do |r| 
    #   @id = r.card_id
    #   # @net += r.amount 
    # end
    # puts "*****************************"
    # giftcard = @id#Get giftcard id (reference to the template), by querying using the session id.
    
    giftcard = session[:card_id]
    @amount = Card.where(card_id: giftcard).select(:card_amount)
    @card_amount = 0

    puts "***********************************************"
    
    @amount.each do |r| 
      @card_amount = r.card_amount
      # @net += r.amount 
    end
    puts "***********************************************"


    order = (SecureRandom.uuid).to_s
    new_order = Order.create(sender_username: session[:username], 
                         receiver_name: params[:receiver_name], 
                         receiver_email: params[:receiver_email], 
                         receiver_phone: params[:receiver_phone], 
                         card_id: giftcard,
                         order_id: order, 
                         amount: @card_amount)

    session[:card_id] = nil
    session[:order_id] = order

    cookies[:card_id] = nil
    cookies[:order_id] = order

    puts "order created. #{order}"

    resp = {
      "message" => "successfully created card."
    }

    render json: resp
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params[:order]
    end
end
