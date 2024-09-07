class Carrinho < ApplicationRecord
  belongs_to :usuario
  has_many :produtos_carrinho
  has_many :produtos, through: :produtos_carrinho

  validates :usuario, presence: true
end
