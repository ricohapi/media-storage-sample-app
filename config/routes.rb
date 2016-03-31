Rails.application.routes.draw do
  resource :session, only: [:create, :destroy]
  resources :images, except: [:new, :edit] do
    scope module: :image do
      resource :content, only: :show
      resources :tags, only: :create
    end
  end
  resources :tags
  root 'top#index'
end
