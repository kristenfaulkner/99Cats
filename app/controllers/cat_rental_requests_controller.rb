class CatRentalRequestsController < ApplicationController
  def new
    @cat_rental_request = CatRentalRequest.new
  end
  
  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    
    if @cat_rental_request.save
      if @cat_rental_request.overlapping_requests.empty?
        flash[:notice] = "Rental Request Created!"
        redirect_to cats_url
      else
        @cat_rental_request.destroy
        flash[:notice] = "Sorry, Cat Taken On These Dates!"
        render 'new'
        #redirect_to cats_url(@cat.find(session[:cat_id]))
      end
    else
      flash[:notice] = "Invalid Request! Please Try Again"
      render 'new'
    end
  end
  
  def respond
    @cat_rental_request = CatRentalRequest.find(params[:id])
    if params[:cat_rental_request][:status] == "APPROVE"
      @cat_rental_request.update(:status => "APPROVED")
      flash[:notice] = "Rental Request Approved"
      @cat = Cat.find(@cat_rental_request.cat_id)
      session[:cat_id] = @cat.id
      render '/cats/show'
      #redirect_to cats_url(Cat.find(@cat_rental_request.cat_id))
    elsif params[:cat_rental_request][:status] == "DENY"
      @cat_rental_request.update(:status => "DENIED")
      flash[:notice] = "Rental Request Denied"
      @cat = Cat.find(@cat_rental_request.cat_id)
      session[:cat_id] = @cat.id
      render '/cats/show'
      #redirect_to cats_url(Cat.find(@cat_rental_request.cat_id))
    end
  end
  
  def cat_rental_request_params
    params.require(:cat_rental_request).permit(
      :cat_id, :start_date, :end_date, :status, :user_id
    )
  end
end