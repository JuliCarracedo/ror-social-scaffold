Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
  get '/member-data', to: 'members#show'
  
  namespace :api do
    devise_scope :user do
      post 'login', to: '/users/sessions#create', defaults:{ format: :json}
      post 'logout', to: '/users/sessions#destroy', defaults:{ format: :json}
      post 'register', to: '/users/registrations#create', defaults:{ format: :json}
    end
    namespace :v1 do
      resources :users, only: [:index, :show]
      resources :posts, only: [:index, :create, :show] do
        resources :comments, only: [:create, :index]
        resources :likes, only: [:create, :destroy]
      end
    end
  end

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create, :show] do
    resources :comments, only: [:create, :index]
    resources :likes, only: [:create, :destroy]
  end

  post 'friendships/create/:inviter_id/:invitee_id/:mode', to: 'friendships#create', as: 'friendship_create'
  post 'friendships/update/:inviter_id/:invitee_id', to: 'friendships#update', as: 'friendship_update'
  delete 'friendships/destroy/:inviter_id/:invitee_id/:show_user', to: 'friendships#destroy', as: 'friendship_destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
