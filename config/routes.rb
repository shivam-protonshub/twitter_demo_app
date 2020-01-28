Rails.application.routes.draw do
  devise_for :users, skip: [:registrations, :sessions]
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      devise_for :users, controllers: {
        sessions: 'api/v1/user/sessions',
        registrations: 'api/v1/user/registrations'

      }
      resources :tweets, only: [:create, :destroy]
      # Follow User
      get 'follow_user', to: 'users#follow_user'
      # Unfollow User
      get 'unfollow_user', to: 'users#unfollow_user'
      # Followers Tweets
      get 'followers_tweets', to: 'users#followers_tweets'
      # User Profile
      get 'user_profile', to: 'users#user_profile'
      # User's tweets
      get 'user_tweets', to: 'users#user_tweets'
      # User's followers
      get 'followers', to: 'users#followers'
    end
  end
end
