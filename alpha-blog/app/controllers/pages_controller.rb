class PagesController < ApplicationController
  def about
  end

  def home
    redirect_to articles_path if logged_? #if a user is logged in, they get redirected to articles path if root route is selected.
  end

end
