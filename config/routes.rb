Rails.application.routes.draw do
  root 'home#index'
  
  resources :datasets, only: [:index, :show, :new, :create] do
    resources :schemas, only: [:show]
  end
end

Rails.application.routes.draw do
  get 'schemas/show'
  get 'datasets/index'
  get 'datasets/show'
  get 'datasets/new'
  get 'datasets/create'
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

