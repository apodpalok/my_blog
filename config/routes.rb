Rails.application.routes.draw do
  devise_for :users
  get 'tags/:tag', to: 'articles#tags', as: 'tag'

  resources :articles do
    resources :comments
  end

  root 'articles#index'
end
