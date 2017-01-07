Rails.application.routes.draw do
  devise_for :users
  resources :articles do
    resources :comments
  end

  resources :doctors do
    resources :patients
  end

  root 'welcome#index'
end
