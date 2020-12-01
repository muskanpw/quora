Rails.application.routes.draw do
  root 'home#index'
  
  devise_for :users
  resources :questions do
    resources :answers
  end

  resources :answers, only: [] do
    post "upvote" , to: "votes#upvote", as: :upvote
    post "downvote" , to: "votes#downvote", as: :downvote
  end
  resources :topics
end
        