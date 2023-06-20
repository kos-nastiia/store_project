Rails.application.routes.draw do
  root "products#index"

  resources :orders
  resources :products

  get "cart", to: "cart#show", as: 'cart'
  post "products/:id/buy", to: "cart#update", as: 'buy'
  post "products/:id/change", to: "cart#update", as: 'change'
  post "products/:id/delete", to: "cart#update", as:'delete'
  delete "clean_cart", to: "cart#delete", as: "clean_cart"
end
