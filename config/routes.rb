Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  scope :api do 
    post   '/login',            to:'sessions#create'
    delete '/logout',           to:'sessions#destroy'
    post   '/add_to_cart_item', to: 'cart_items#add'

    resources :users
    resources :products do 
      collection do 
        get 'search'
      end 
    end 
    resources :categories do 
      member do 
        get 'products_of_category'
      end 
    end 
  end 
end
