class CatRentalRequestsController < ApplicationController
  def new
    @cat_rental_request = CatRentalRequest.new
  end
  
  def create
    @cat_rental_request = CatRentalRequest.new cat_rental_request_params
    if @cat_rental_request.save
      flash[:notice] = "Rental Request Created!"
      redirect_to cats_url
    else
      flash[:notice] = "Invalid Request! Please Try Again"
      render 'new'
    end
  end
  
  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end