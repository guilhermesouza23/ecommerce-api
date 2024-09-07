# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_09_07_134110) do
  create_table "carrinhos", force: :cascade do |t|
    t.integer "usuario_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_carrinhos_on_usuario_id"
  end

  create_table "produtos", force: :cascade do |t|
    t.string "nome"
    t.float "preco"
    t.string "descricao"
    t.string "url_foto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "produtos_carrinhos", force: :cascade do |t|
    t.integer "produto_id", null: false
    t.integer "carrinho_id", null: false
    t.float "preco"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrinho_id"], name: "index_produtos_carrinhos_on_carrinho_id"
    t.index ["produto_id"], name: "index_produtos_carrinhos_on_produto_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nome"
    t.string "email"
    t.string "senha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_usuarios_on_email", unique: true
  end

  add_foreign_key "carrinhos", "usuarios"
  add_foreign_key "produtos_carrinhos", "carrinhos"
  add_foreign_key "produtos_carrinhos", "produtos"
end
