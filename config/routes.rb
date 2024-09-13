Rails.application.routes.draw do
  # Rota raiz
  root 'home#index'

  # Rotas para Usuários (CRUD completo)
  resources :usuarios, only: [:index, :create, :show, :update, :destroy]

  # Rotas para Produtos (CRUD completo)
  resources :produtos, only: [:index, :create, :show, :update, :destroy]

  # Rotas para Carrinhos (CRUD completo e gerenciamento de produtos no carrinho)
  resources :carrinhos, only: [:index, :show, :create, :destroy] do
  resources :produtos_carrinho, only: [:create, :destroy]  # Adicionar/remover produtos do carrinho
  end

  # Rotas independentes para ProdutosCarrinho (listar associações e atualizações)
  resources :produtos_carrinho, only: [:index, :show, :update]

  # Rotas para Login/Logout
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
