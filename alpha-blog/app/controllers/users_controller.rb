class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    #debugger
    #create new user object, with :username, :email, and :password- that is going through the user_params hash
    @user = User.new(user_params)#have to whitelist what we are accepting, see below in private
    if @user.save
      flash[:success] = "welcome to the Alpha Blog, #{@user.username}"
      redirect_to articles_path
    else  
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password) #whitelisting
  end

end 