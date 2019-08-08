class ArticlesController < ApplicationController
  def new
    @article = Article.new
    # @article = Article.new(article_params)
    # @article.save
    # redirect_to article_path(@article)
   end

  def edit
    @article = Article.find(params[:id]) #find the article
  end

   def show
    @article = Article.find(params[:id])
   end
   
  def create
    #render plain: params[:article].inspect
    @article = Article.new(article_params)
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
  @article = Article.find(params[:id]) #create article instance variable
  if @article.update(article_params)
    flash[:notice] = "Article was updated"
    redirect_to article_path(@article)
  else 
    render 'edit'
  end
end




    private
      def article_params
      params.require(:article).permit(:title, :description)
      end



  end