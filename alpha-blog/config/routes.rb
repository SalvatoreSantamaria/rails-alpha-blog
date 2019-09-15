Rails.application.routes.draw do
  # For details on the DSL available within this file see http://guides.rubyonrails.org/routing.html

root 'pages#home'
get 'about', to: 'pages#about'
 
# creates index and CRUD routes
resources :articles

# goes to the users controller, new action
get 'signup', to: 'users#new'
#two options here for the users create route:
post 'users', to: 'users#create'
# this is the other options (except because we already have users#new)
resources :users, except: [:new]
#request to controller 'session' action is 'new'
get 'login', to: 'sessions#new'
post 'login', to: 'sessions#create'
delete 'logout', to: 'sessions#destroy'
end
