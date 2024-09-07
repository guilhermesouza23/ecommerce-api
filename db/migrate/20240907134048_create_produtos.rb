class CreateProdutos < ActiveRecord::Migration[7.2]
  def change
    create_table :produtos do |t|
      t.string :nome
      t.float :preco
      t.string :descricao
      t.string :url_foto

      t.timestamps
    end
  end
end
