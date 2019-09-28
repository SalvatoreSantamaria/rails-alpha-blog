class PagesController < ApplicationController
  def about
  end

  def home
    redirect_to articles_path if logged_in? #if a user is logged in, they get redirected to articles path if root route is selected.
  end

end
