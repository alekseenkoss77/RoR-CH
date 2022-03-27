Rails.application.routes.draw do
  root 'admin#index'

  resources :orders, only: [:index, :show], param: :number do
    member do
      patch :cancel
    end
  end

  namespace :reports do
    resources :coupon_users, only: :index
    resources :sold_products, only: :index
  end
end
