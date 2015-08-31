class OrdersController < ApplicationController
  before_action :set_order, except: [:sales, :purchases, :index, :new, :create]
  before_action :authenticate_user!

  def sales
    @orders = Order.all.where(seller: current_user).order("created_at DESC")
  end

  def purchases
    @orders = Order.all.where(buyer: current_user).order("created_at DESC")
  end

  def new
    @order = Order.new
    @listing = Listing.find(params[:listing_id])
  end

  def create
    @order = Order.new(order_params)
    @listing = Listing.find(params[:listing_id])
    @seller = @listing.user

    @order.listing_id = @listing.id
    @order.buyer_id = current_user.id
    @order.seller_id = @seller.id

    if @order.save
      flash[:success] = "Successfully created order!"
      redirect_to root_url
    else
      flash[:danger] = "Couldn't create order."
      render "new"
    end
  end

  private

  def order_params
    params.require(:order).permit(:address, :city, :state)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end