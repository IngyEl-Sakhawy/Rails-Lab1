Rails.application.routes.draw do
  root "articles#index"
  devise_for :users
  
  resources :articles do
  resources :comments 
end

resources :users do
  collection do
    get 'reportpage'
  end
end
end
