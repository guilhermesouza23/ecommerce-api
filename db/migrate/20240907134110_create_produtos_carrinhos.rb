class CreateProdutosCarrinhos < ActiveRecord::Migration[7.2]
  def change
    create_table :produtos_carrinhos do |t|
      t.references :produto, null: false, foreign_key: true
      t.references :carrinho, null: false, foreign_key: true
      t.float :preco

      t.timestamps
    end
  end
end
