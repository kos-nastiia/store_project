Rails.application.routes.draw do
  root "products#index"

  resources :orders
  resources :products, only: [:index, :show, :new, :edit, :update, :destroy] do
    member do
      post :buy, to: "cart#update", as: "buy"
      post :change_amount, to: "cart#update", as: "change_amount"
      post :delete_item, to: "cart#update", as: "delete_item"
    end
  end

  get "cart", to: "cart#show", as: 'cart'
  delete "clean_cart", to: "cart#destroy", as: "clean_cart"
end
