Rails.application.routes.draw do
  
  devise_for :users
 

  resources :books do 
    resources :reviews, except: [:show]
  end


  root 'books#index'

  get 'books/:id/author', controller: 'books', action:'show_author', as: 'show_author'
end
