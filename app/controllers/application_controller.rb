class ApplicationController < ActionController::Base
  include SessionsHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session
  
  def login!(user)
    session[:session_token] = user.reset_session_token!
  end
  
  def logout!(user)
    session[:session_token] = nil
    user.reset_session_token!
  end
end
