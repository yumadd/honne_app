Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :posts do
    post :like, on: :member
    delete :destroy_all, on: :collection
    resources :comments, only: :create
  end

  root "posts#index"
end
