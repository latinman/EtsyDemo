class ListingsController < ApplicationController
  before_action :set_listing, except: [:index, :new, :create]

  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
  end

  def show
  end

  def create
    @listing = Listing.new(listing_params)

    if @listing.save
      flash[:success] = "Listing created successfully!"
      redirect_to @listing
    else
      flash[:danger] = "Error creatign listing"
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
end