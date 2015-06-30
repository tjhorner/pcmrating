Rails.application.routes.draw do
  root 'site#index'

  devise_for :users

  resources :games do
    resources :ratings do
    end
  end

  post 'reviews/:id/upvote', to: 'votes#upvote', as: :upvote_rating
  post 'reviews/:id/downvote', to: 'votes#downvote', as: :downvote_rating

  get 'user/:id', to: 'users#show', as: :show_user
  post 'user/:id/ban', to: 'users#ban', as: :ban_user

end
