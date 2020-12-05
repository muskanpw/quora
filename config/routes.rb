Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'home#index'
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_for :admin_users, ActiveAdmin::Devise.config
  resources :questions do
    resources :answers
  end
  resources :answers, only: [] do
    post "upvote" , to: "votes#upvote", as: :upvote
    post "downvote" , to: "votes#downvote", as: :downvote
  end
  resources :topics
 
  resources :home ,only: [:account_not_approved] do 
    get :account_not_approved, on: :collection
  end
end
        