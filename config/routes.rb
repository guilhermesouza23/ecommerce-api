Rails.application.routes.draw do
  resources :usuarios, only: [:index, :create]
  resources :produtos, only: [:index, :create]

  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
