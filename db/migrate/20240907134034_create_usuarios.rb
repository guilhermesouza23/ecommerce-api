class CreateUsuarios < ActiveRecord::Migration[7.2]
  def change
    create_table :usuarios do |t|
      t.string :nome
      t.string :email
      t.string :senha

      t.timestamps
    end
    add_index :usuarios, :email, unique: true
  end
end
