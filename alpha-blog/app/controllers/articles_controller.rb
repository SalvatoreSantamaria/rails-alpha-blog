class ArticlesController < ApplicationController
  #before actions work in order
  before_action :set_article, only: [:edit, :update, :show, :destroy] #this is the method at the bottom, where we find the article via params[:id]. we are only allowing it on the below methods 
  #@article = Article.find(params[:id]) #create article instance variable
  before_action :require_user, except: [:index, :show] #except for index/show, I need a logged in user.
  def index
    #@articles = Article.all #grab all articles from DB
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
    # @article = Article.new(article_params)
    # @article.save
    # redirect_to article_path(@article)
   end

  def edit
    # @article = Article.find(params[:id]) #find the article. see line 3 before_action
  end

  def show
    # @article = Article.find(params[:id]) #find the article. see line 3 before_action
  end

  def destroy
    # @article = Article.find(params[:id]) #find the article. see line 3 before_action
    @article.destroy
    flash[:notice] = "Article was deleted"
    redirect_to articles_path #send back to articles index
  end
   
  def create
    #debugger
    #render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.user = User.first # hard coding for test
    if @article.save
    #give message to user  
      flash[:notice] = "Article was successfully created"
    #once it saves, have to tell it where to go
      redirect_to article_path(@article)
    else 
      render 'new'
    end
  end

def update
# @article = Article.find(params[:id]) #find the article. see line 3 before_action
  if @article.update(article_params)
    flash[:notice] = "Article was updated"
    redirect_to article_path(@article)
  else 
    render 'edit'
  end
end




    private

      
    def set_article
      @article = Article.find(params[:id]) #create article instance variable
    end

      def article_params
      params.require(:article).permit(:title, :description)
      end



  end