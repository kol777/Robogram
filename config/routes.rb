Rails.application.routes.draw do
  get 'relationships/follow_user'

  get 'relationships/unfollow_user'

  get 'profiles/show'

  get 'browse', to: 'posts#browse', as: :browse_posts
  
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'posts#index'
  resources :posts do
    resources :comments
    member do
      get 'like'
    end
  end
  get ':user_name', to: 'profiles#show', as: :profile
  get ':user_name/edit', to: 'profiles#edit', as: :edit_profile
  patch ':user_name/edit', to: 'profiles#update', as: :update_profile

  post ':user_name/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':user_name/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
