class UsersController < ApplicationController
  before_action :redirect_if_logged_in
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to cats_url
    else
      if @user.password.length < 6
        flash[:notice] = "Password must have length 6 or greater. Idiot."
      end
      render 'new'
    end
  end
  
  def redirect_if_logged_in
    if self.current_user
      redirect_to cats_url
    end
  end
  
  
  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end