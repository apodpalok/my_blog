Rails.application.routes.draw do
  devise_for :users
  get 'tags/:tag', to: 'articles#index', as: 'tag'
  
  resources :articles do
    resources :comments
  end

  root 'articles#index'
end
