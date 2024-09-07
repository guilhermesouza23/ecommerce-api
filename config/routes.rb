Rails.application.routes.draw do
  # Outras rotas...

  # Rotas para Usuários
  resources :usuarios, only: [:index, :create]
  # Rotas para produtos
  resources :produtos, only: [:index, :create]
end
