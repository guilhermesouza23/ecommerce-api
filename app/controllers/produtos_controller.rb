class ProdutosController < ApplicationController
    # Desativa a verificação do token CSRF para as ações especificadas
    skip_before_action :verify_authenticity_token, only: [:create, :index]
  
    # GET /produtos
    def index
      begin
        produtos = Produto.all
        lista_de_produtos = produtos.map do |produto|
          {
            id: produto.id,
            nome: produto.nome,
            preco: produto.preco,
            descricao: produto.descricao
          }
        end
  
        render json: { mensagem: "Foram encontrados #{lista_de_produtos.size} produtos.", dados: lista_de_produtos }, status: :ok
      rescue => e
        Rails.logger.error e.message
        render json: { mensagem: 'Erro de servidor' }, status: :internal_server_error
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
  
    private
  
    # Permite apenas parâmetros permitidos para o produto
    def produto_params
      params.require(:produto).permit(:nome, :preco, :descricao)
    end
  end
  