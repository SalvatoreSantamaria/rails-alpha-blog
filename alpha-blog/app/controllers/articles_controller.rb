class ArticlesController < ApplicationController
  def new
    @article = Article.new
    # @article = Article.new(article_params)
    # @article.save
    # redirect_to article_path(@article)
   end
  def create
  end
    # private
    # def article_params
    # params.require(:article).permit(:title, :description)
    # end
  end