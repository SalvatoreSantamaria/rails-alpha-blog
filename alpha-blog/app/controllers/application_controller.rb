class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception #Prevent CSRF attacks by raising an exception
  #methods created in application controller is available to ALL controllers, but are NOT available to views by default.
  #let rails know that these are helper methods

  helper_method :current_user, :logged_in? #rails will make  current user and logged_in available to the views
  def current_user
    #@current_user -if current user already exists, return it. ||= is 'if not'
    @current_user ||= User.find(session[:user_id]) if session[:user_id]#return (from db) this user if session user_id exists 
  end

  def logged_in?
    !!current_user #!! changes everything to a boolean
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
end
