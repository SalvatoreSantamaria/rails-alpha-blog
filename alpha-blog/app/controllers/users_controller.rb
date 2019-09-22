class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  def set_user
    @user = User.find(params[:id])
  end


  def index
    #@users = User.all
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
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

  def edit 
   # @user = User.find(params[:id]) dont need because it's set above in before_action :set_user, only: [:edit, :update, :show] and in the set_user method
  end

  def update
   # @user = User.find(params[:id]) dont need because it's set above in before_action :set_user, only: [:edit, :update, :show] and in the set_user method
    if @user.update(user_params)#have whitelisted user name, email, password
      flash[:success] = "You have updated your account, #{@user.username}"
      redirect_to articles_path
    else   
      render 'edit'
    end
  end

  def show
   # @user = User.find(params[:id]) #grabbing id #dont need because it's set above in before_action :set_user, only: [:edit, :update, :show] and in the set_user method
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5) #grabbing all the user articles using pagination
  end


  private
  def user_params
    params.require(:user).permit(:username, :email, :password) #whitelisting
  end

end 