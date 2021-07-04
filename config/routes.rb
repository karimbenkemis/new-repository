Rails.application.routes.draw do
  resource :signup, only: %i[create]
  resources :authentications, only: %i[create]
  resources :users, only: %i[index] do
    collection do
      delete '/:id'           => "users#delete", as: 'delete'
      get '/archive/:id'      => "users#archive", as: 'archive'
      get '/unarchive/:id'    => "users#unarchive", as: 'unarchive'
    end
  end
end
