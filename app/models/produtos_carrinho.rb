class ProdutosCarrinho < ApplicationRecord
  belongs_to :produto
  belongs_to :carrinho

  validates :produto, :carrinho, :preco, presence: true
end
