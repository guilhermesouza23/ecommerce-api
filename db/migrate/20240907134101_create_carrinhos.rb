class CreateCarrinhos < ActiveRecord::Migration[7.2]
  def change
    create_table :carrinhos do |t|
      t.references :usuario, null: false, foreign_key: true

      t.timestamps
    end
  end
end
