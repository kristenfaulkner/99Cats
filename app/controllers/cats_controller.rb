class CatsController < ApplicationController
  def index
    @cats = Cat.all
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
    
    if @cat.save
      flash[:notice] = "Cat Created!"
      redirect_to cat_url(@cat)
    else
      flash[:notice] = "Invalid Cat! Please Try Again"
      render 'new'
    end
  end
  
  def edit
    @cat = Cat.find(params[:id])
  end
  
  def update
    @cat = Cat.find(params[:id])
    
    if @cat.update(cat_params)
      flash[:notice] = "Cat Updated!"
      redirect_to cat_url(@cat)
    else
      flash[:notice] = "Couldn't Update Cat"
      render 'edit'
    end
  end
  
  def cat_params
    params.require(:cat).permit(:name, :age, :birth_date, :color, :sex, :image_url)
  end
end
