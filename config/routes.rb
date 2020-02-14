Rails.application.routes.draw do 
  mount RailsAdmin::Engine => '/sadmin', as: 'rails_admin'
  devise_for :users 

  resources :books do 
    resources :reviews, except: [:show]
    resources :comments, except: [:index]
  end

  root 'books#index'
  get 'books/:id/author', controller: 'books', action: 'show_author', as: 'show_author'
end
