Rails.application.routes.draw do
  devise_for :users
  root "products#index"

  resources :products do
    member do
      resource :cart, only: [:update] do
        [:add, :remove, :change_amount].each do |action|
          patch action, to: "cart#update", as: "#{action}_product_in", defaults: { update_action: action.to_s }
        end
      end
    end
  end

  resources :cart
  resources :orders
end
