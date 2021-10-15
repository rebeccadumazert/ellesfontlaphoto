Rails.application.routes.draw do
  get 'conseils_articles/show'
  get 'conseils_videos/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  get "mentions_legales", to: 'pages#mentions_legales'
  resources :contacts, only: :create
  resources :helps, only: [:show, :index]
  get "/conseils", to: "conseils_pratiques#index"
  resources :conseils_videos, only: [:show]
  resources :conseils_articles, only: [:show]
end
