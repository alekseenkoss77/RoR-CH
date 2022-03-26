Rails.application.routes.draw do
  root 'admin#index'

  resources :orders, only: [:index, :show], param: :number

  resources :reports, only: :index do
  end

  namespace :reports do
    resources :coupon_users, only: :index
    resources :sold_products, only: :index
  end
end
