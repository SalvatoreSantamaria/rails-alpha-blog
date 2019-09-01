# README

# Using readme to cover useful rails console commands

*******************************************

object.errors.full_messages # to get messages

*******************************************

<w(title: "article title", description: "article desc", user: User.first)
  User Load (0.2ms)  SELECT  "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
=> #<Article id: nil, title: "article title", description: "article desc", created_at: nil, updated_at: nil, user_id: 1>
irb(main):002:0> article.valid?
=> true
irb(main):003:0> article.save
   (0.1ms)  begin transaction
  Article Create (1.2ms)  INSERT INTO "articles" ("title", "description", "created_at", "updated_at", "user_id") VALUES (?, ?, ?, ?, ?)  [["title", "article title"], ["description", "article desc"], ["created_at", "2019-08-31 04:57:50.597383"], ["updated_at", "2019-08-31 04:57:50.597383"], ["user_id", 1]]
   (105.1ms)  commit transaction

*******************************************

irb(main):005:0> article = Article.last
  Article Load (0.4ms)  SELECT  "articles".* FROM "articles" ORDER BY "articles"."id" DESC LIMIT ?  [["LIMIT", 1]]
=> #<Article id: 15, title: "article title", description: "article desc", created_at: "2019-08-31 04:57:50", updated_at: "2019-08-31 04:57:50", user_id: 1>
irb(main):006:0> article.user #give user object
  User Load (0.3ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 1], ["LIMIT", 1]]
=> #<User id: 1, username: "Kuma", email: "kumadog@email.com", created_at: "2019-08-12 04:52:19", updated_at: "2019-08-31 04:13:47">
irb(main):007:0> article.user.username #can reference different parts of user object
=> "Kuma"
irb(main):008:0> article.user #possible because of association
=> #<User id: 1, username: "Kuma", email: "kumadog@email.com", created_at: "2019-08-12 04:52:19", updated_at: "2019-08-31 04:13:47">
irb(main):009:0> user = User.find(2) #testing out asscociation in reverse
  User Load (0.3ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 2], ["LIMIT", 1]]
=> #<User id: 2, username: "Mona", email: "mona@email.com", created_at: "2019-08-31 04:13:00", updated_at: "2019-08-31 04:13:00">
irb(main):010:0> user.articles #one to many, so articles is plural
  Article Load (0.3ms)  SELECT  "articles".* FROM "articles" WHERE "articles"."user_id" = ? LIMIT ?  [["user_id", 2], ["LIMIT", 11]]
=> #<ActiveRecord::Associations::CollectionProxy []>
irb(main):011:0>

*******************************************

type debugger anywhere in controller and byebug will stop there.

(byebug) article_params
<ActionController::Parameters {"title"=>"test title100", "description"=>"test description 100"} permitted: true>(byebug) n
[32, 41] in C:/Users/sam/Desktop/Personal Projects/The Complete Ruby On Rails Developer Course/alpha-blog_app/alpha-blog/app/controllers/articles_controller.rb   32:   def create
   33:     debugger
   34:     #render plain: params[:article].inspect
   35:     @article = Article.new(article_params)   36:     #@article.user = User.first # hard coding for test
=> 37:     if @article.save
   38:     #give message to user
   39:       flash[:notice] = "Article was successfully created"
   40:     #once it saves, have to tell it where to go
   41:       redirect_to article_path(@article)
(byebug) n
   (0.5ms)  begin transaction
  ↳ app/controllers/articles_controller.rb:37
   (0.5ms)  rollback transaction
  ↳ app/controllers/articles_controller.rb:37

[38, 47] in C:/Users/sam/Desktop/Personal Projects/The Complete Ruby On Rails Developer Course/alpha-blog_app/alpha-blog/app/controllers/articles_controller.rb
   38:     #give message to user
   39:       flash[:notice] = "Article was successfully created"
   40:     #once it saves, have to tell it where to go
   41:       redirect_to article_path(@article)
   42:     else
=> 43:       render 'new'
   44:     end
   45:   end
   46:
   47: def update
(byebug)

*******************************************
byebug with file working

[30, 39] in C:/Users/sam/Desktop/Personal Projects/The Complete Ruby On Rails Developer Course/alpha-blog_app/alpha-blog/app/controllers/articles_controller.rb
   30:   end
   31:
   32:   def create
   33:     debugger
   34:     #render plain: params[:article].inspect
=> 35:     @article = Article.new(article_params)
   36:     @article.user = User.first # hard coding for test
   37:     if @article.save
   38:     #give message to user
   39:       flash[:notice] = "Article was successfully created"
(byebug) article_params
<ActionController::Parameters {"title"=>"test title200", "description"=>"test desc200"} permitted: true>
(byebug) n

[31, 40] in C:/Users/sam/Desktop/Personal Projects/The Complete Ruby On Rails Developer Course/alpha-blog_app/alpha-blog/app/controllers/articles_controller.rb
   31:
   32:   def create
   33:     debugger
   34:     #render plain: params[:article].inspect
   35:     @article = Article.new(article_params)
=> 36:     @article.user = User.first # hard coding for test
   37:     if @article.save
   38:     #give message to user
   39:       flash[:notice] = "Article was successfully created"
   40:     #once it saves, have to tell it where to go
(byebug) n
  User Load (4.5ms)  SELECT  "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
  ↳ app/controllers/articles_controller.rb:36

[32, 41] in C:/Users/sam/Desktop/Personal Projects/The Complete Ruby On Rails Developer Course/alpha-blog_app/alpha-blog/app/controllers/articles_controller.rb
   32:   def create
   33:     debugger
   34:     #render plain: params[:article].inspect
   35:     @article = Article.new(article_params)
   36:     @article.user = User.first # hard coding for test
=> 37:     if @article.save
   38:     #give message to user
   39:       flash[:notice] = "Article was successfully created"
   40:     #once it saves, have to tell it where to go
   41:       redirect_to article_path(@article)
(byebug) @article.user
#<User id: 1, username: "Kuma", email: "kumadog@email.com", created_at: "2019-08-12 04:52:19", updated_at: "2019-08-31 04:13:47">
(byebug) @article.user.username
"Kuma"
(byebug)

*********************************************

add to views (with byebug only?)

    <%=debug(params) if Rails.env.development?%>

will show all params/model/view!!!!!!


********************************************

Added  debugger to UsersController

 def create
    debugger
  end

this is what it returned

[1, 9] in C:/Users/sam/Desktop/Personal Projects/The Complete Ruby On Rails Developer Course/alpha-blog_app/alpha-blog/app/controllers/users_controller.rb
   1: class UsersController < ApplicationController
   2:   def new
   3:     @user = User.new
   4:   end
   5:
   6:   def create
   7:     debugger
=> 8:   end
   9: end
(byebug) params
<ActionController::Parameters {"utf8"=>"✓", "authenticity_token"=>"DqHSS0FUebHXNMP0pdpcnSoaqdT/2eASxsXgwKJbiXiLCWTT0c1Gkmb4KSdnNeVvhTof2SbDwb1IcSloZ7SlXw==", "user"=>{"username"=>"Raven", "email"=>"raven@email.com", "password"=>"password"}, "commit"=>"Sign up", "controller"=>"users", "action"=>"create"} permitted: false>
(byebug)


