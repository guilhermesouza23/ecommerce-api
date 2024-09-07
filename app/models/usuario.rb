class Usuario < ApplicationRecord
    has_many :carrinhos
  
    validates :nome, presence: true
    validates :email, presence: true, uniqueness: true
    validates :senha, presence: true
  end
  