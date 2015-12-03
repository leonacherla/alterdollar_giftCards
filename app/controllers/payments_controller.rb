require 'securerandom'

class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.all
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

  def auth
    Braintree::ClientToken.generate
  end

  def braintree
    nonce = params[:payment_method_nonce]
    @status = nil
    result = Braintree::Transaction.sale(
      :amount => "100.00",
      :payment_method_nonce => nonce
    )
    puts "***********************************************"
    if result.success?
      @status = "success"
      @ad_id = (SecureRandom.uuid).to_s
      @adcode = (SecureRandom.uuid).to_s
      @redemption_status = "Ready for Redemption"
      @order_id = session[:order_id]
      @amount = 0

      @card_amount = Order.where(order_id: session[:order_id]).select(:amount)
      @card_amount.each do |r| 
        @amount = r.amount
      end

      adcheque = Adcheque.create(ad_id: @ad_id,
                                 adcode: @adcode,
                                 amount: @amount,
                                 order_id: @order_id,
                                 redemption_status: @redemption_status)

      puts "Adcheque: #{adcheque}"

      @adr = (SecureRandom.uuid).to_s 
      receipt = Receipt.create(ad_id: @ad_id,
                               order_id: @order_id,
                               adr: @adr)

      #TODO adcheque
    else
      @status = "failure"
    end
    puts "***********************************************"
    resp = {
      "transaction_status" => "Gift card purchased. ADR: #{@adr}. Gift card will be delivered soon."
    }
    render json: resp
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)

    respond_to do |format|
      if @payment.save
        format.html { redirect_to @payment, notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params[:payment]
    end
end
