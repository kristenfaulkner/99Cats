class CatsController < ApplicationController
  def index
    @cats = Cat.all
    user_token = session[:session_token]
    @user = current_user
    render 'index'
  end
  
  def show
    @cat = Cat.find(params[:id])
    render 'show'
  end
  
  def new
    @cat = Cat.new
  end
  
  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = self.current_user.id
        
    if @cat.save
      flash[:notice] = "Cat Created!"
      redirect_to cat_url(@cat)
    else
      flash[:notice] = "Invalid Cat! Please Try Again"
      render 'new'
    end
  end
  
  def edit
    if !verify_owner
      flash[:notice]= "Sorry you do not own this cat"
      redirect_to cat_url(@cat)
    else
      @cat = Cat.find(params[:id])
    end
  end
  
  def update
    if !verify_owner
      flash[:notice] = "Sorry you do not own this cat"
      redirect_to cat_url(@cat)
    else
      @cat = Cat.find(params[:id])
      if @cat.update(cat_params)
        flash[:notice] = "Cat Updated!"
        redirect_to cat_url(@cat)
      else
        flash[:notice] = "Couldn't Update Cat"
        render 'edit'
      end
    end
  end
  
  def verify_owner
    @cat = Cat.find(params[:id])
    @cat.user_id == self.current_user.id
  end
  
  private
  
  def cat_params
    params.require(:cat).permit(:name, :age, :birth_date, :color, :sex, :image_url, :user_id)
  end
end
