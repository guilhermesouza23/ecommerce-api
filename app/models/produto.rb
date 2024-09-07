class Produto < ApplicationRecord
    has_many :produtos_carrinho
    has_many :carrinhos, through: :produtos_carrinho
  
    validates :nome, :preco, :descricao, presence: true
  end
  