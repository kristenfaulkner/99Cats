class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:create, :new]
  
  def create
    user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )
    
    if user
      login!(user)
      redirect_to cats_url
    else
      render 'new'
    end
  end
  
  def destroy
    @user = current_user
    logout!(@user)
    render 'new'
  end
  
  def new
    @user = User.new
    render 'new'
  end
  
  def redirect_if_logged_in
    if self.current_user
      redirect_to cats_url
    end
  end
end
