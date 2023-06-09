Rails.application.routes.draw do
  root "posts#index"
  resources :friend_requests
  resources :posts
  resources :users

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: :logout
  put 'like/:id', to: 'likes#create', as: :like
  delete 'unlike/:id', to: 'likes#destroy', as: :unlike

  get 'comment/:post_id', to: 'comments#new', as: :newcomment
  get 'comment/:post_id/:parent_comment_id', to: 'comments#new', as: :newreply
  
  resources :comments

end
