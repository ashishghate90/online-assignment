Rails.application.routes.draw do
  resources :tweets do
  	member do
  		post 'follow'
  		post 'unfollow'
  	end

  	collection do
  		get 'followers_tweets'
  	end
  end
  devise_for :users

  root to: "tweets#index"
  resources :profiles
  # get ':id/profile' => 'profiles#user_profile'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
