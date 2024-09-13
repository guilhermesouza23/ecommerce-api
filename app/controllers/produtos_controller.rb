class ProdutosController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :index, :show, :update, :destroy]

  # GET /produtos
  def index
    begin
      produtos = Produto.all
      lista_de_produtos = produtos.map do |produto|
        {
          id: produto.id,
          nome: produto.nome,
          preco: produto.preco,
          descricao: produto.descricao,
          url_foto: produto.url_foto  # Inclui a URL da foto na resposta
        }
      end

      render json: { mensagem: "Foram encontrados #{lista_de_produtos.size} produtos.", dados: lista_de_produtos }, status: :ok
    rescue => e
      Rails.logger.error e.message
      render json: { mensagem: 'Erro de servidor' }, status: :internal_server_error
    end
  end

  # GET /produtos/:id
  def show
    begin
      produto = Produto.find(params[:id])
      render json: {
        id: produto.id,
        nome: produto.nome,
        preco: produto.preco,
        descricao: produto.descricao,
        url_foto: produto.url_foto  # Inclui a URL da foto na resposta
      }, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { mensagem: 'Produto não encontrado' }, status: :not_found
    end
  end

  # POST /produtos
  def create
    begin
      dados = produto_params
      novo_produto = Produto.new(dados)

      if novo_produto.save
        render json: { mensagem: 'Produto cadastrado com sucesso' }, status: :created
      else
        render json: { mensagem: 'Erro ao cadastrar produto', erros: novo_produto.errors.full_messages }, status: :unprocessable_entity
      end
    rescue => e
      Rails.logger.error e.message
      render json: { mensagem: 'Erro de servidor' }, status: :internal_server_error
    end
  end

  # PUT /produtos/:id
  def update
    begin
      produto = Produto.find(params[:id])

      if produto.update(produto_params)
        render json: { mensagem: 'Produto atualizado com sucesso' }, status: :ok
      else
        render json: { mensagem: 'Erro ao atualizar produto', erros: produto.errors.full_messages }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { mensagem: 'Produto não encontrado' }, status: :not_found
    rescue => e
      Rails.logger.error e.message
      render json: { mensagem: 'Erro de servidor' }, status: :internal_server_error
    end
  end

  # DELETE /produtos/:id
  def destroy
    begin
      produto = Produto.find(params[:id])
      produto.destroy
      render json: { mensagem: 'Produto excluído com sucesso' }, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { mensagem: 'Produto não encontrado' }, status: :not_found
    rescue => e
      Rails.logger.error e.message
      render json: { mensagem: 'Erro de servidor' }, status: :internal_server_error
    end
  end

  private

  def produto_params
    params.require(:produto).permit(:nome, :preco, :descricao, :url_foto)  # Inclua :url_foto aqui
  end
end
