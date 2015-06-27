Rails.application.routes.draw do

  root 'site#index'

  devise_for :users

  # GAMES
  get 'games/index',                        to: 'games#index',      as: :games
  get 'games/index/page/:page',             to: 'games#index',      as: :games_page
  get 'games/show/:steam_appid',            to: 'games#show',       as: :show_game
  get 'games/show/:steam_appid/page/:page', to: 'games#show',       as: :show_game_page

  get 'games/new',                          to: 'games#new',        as: :new_game
  post 'games/create',                      to: 'games#create',     as: :create_game

  delete 'games/:steam_appid/destroy',      to: 'games#destroy',    as: :destroy_game

  # REVIEWS

  get 'games/:steam_appid/reviews',          to: 'ratings#index',    as: :ratings
  get 'games/:steam_appid/reviews/show/:id', to: 'ratings#show',     as: :show_rating

  get 'games/:steam_appid/reviews/new',      to: 'ratings#new',      as: :new_rating
  post 'games/:steam_appid/reviews/create',  to: 'ratings#create',   as: :create_rating

  get 'games/:steam_appid/reviews/edit',     to: 'ratings#edit',     as: :edit_rating
  patch 'games/:steam_appid/reviews/update', to: 'ratings#update',   as: :update_rating

  delete 'reviews/:id/destroy', to: 'ratings#destroy',  as: :destroy_rating

  get 'user/:id', to: 'users#show', as: :show_user
  post 'user/:id/ban', to: 'users#ban', as: :ban_user

end
