Rails.application.routes.draw do
  devise_for :users
  get 'tags/:tag', to: 'articles#index', as: 'tag'
  resources :articles do
    resources :comments
  end

  resources :doctors do
    resources :patients
  end

  root 'welcome#index'
end
