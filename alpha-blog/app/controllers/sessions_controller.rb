class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    #first varify if valid (if user) #then authenticate
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id #saving user_id in session (browsers cookies are handling this)
      flash[:success] = "You have successfully logged in"
      redirect_to user_path(user) #sending to the users/show page
    else
      flash.now[:danger] = "There was something wrong with your login information" #no validations because there is no model for sessions
      render 'new'   
    end

    #debugger
  end
  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
end