class ListingsController < ApplicationController
  before_action :set_listing, except: [:seller, :index, :new, :create]
  before_filter :authenticate_user!, only: [:seller, :new, :create, :edit, :update, :destroy]
  before_filter :check_user, only: [:edit, :update, :destroy]

  def seller
    @listings = Listing.where(user: current_user).order("created_at DESC")
  end

  def index
    @listings = Listing.all.order("created_at DESC")
  end

  def new
    @listing = Listing.new
  end

  def show
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id

    if current_user.recipient.blank?
      Stripe.api_key = ENV["STRIPE_API_KEY"]
      token = params[:stripeToken]

      recipient = Stripe::Recipient.create(
          name: current_user.name,
          type: "individual",
          bank_account: token
      )
    end

    current_user.recipient = recipient.id
    current_user.save

    if @listing.save
      flash[:success] = "Listing created successfully!"
      redirect_to @listing
    else
      flash[:danger] = "Error creating listing"
      render "new"
    end
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      flash[:success] = "Listing edited!"
      redirect_to listings_path
    else
      flash[:danger] = "Couldn't edit this listing"
      render "edit"
    end
  end

  def destroy
    if @listing.destroy
      redirect_to listings_path
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:name, :description, :price, :image)
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def check_user
    if current_user != @listing.user
      redirect_to root_path, alert: "Sorry, this listing belongs to someone else"
    end
  end
end