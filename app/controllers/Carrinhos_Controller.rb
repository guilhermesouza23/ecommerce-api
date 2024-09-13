class CarrinhosController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create, :index, :show, :destroy]
  
    # GET /carrinhos
    def index
      begin
        carrinhos = Carrinho.all
        lista_de_carrinhos = carrinhos.map do |carrinho|
          {
            id: carrinho.id,
            usuario: carrinho.usuario.nome,
            produtos: carrinho.produtos_carrinho.map do |produtos_carrinho|
              {
                id: produtos_carrinho.produto.id,
                nome: produtos_carrinho.produto.nome,
                preco: produtos_carrinho.preco
              }
            end
          }
        end
  
        render json: { mensagem: "Foram encontrados #{lista_de_carrinhos.size} carrinhos.", dados: lista_de_carrinhos }, status: :ok
      rescue => e
        Rails.logger.error e.message
        render json: { mensagem: 'Erro de servidor' }, status: :internal_server_error
      end
    end
  
    # GET /carrinhos/:id
    def show
      begin
        carrinho = Carrinho.find(params[:id])
  
        carrinho_info = {
          id: carrinho.id,
          usuario: carrinho.usuario.nome,
          produtos: carrinho.produtos_carrinho.map do |produtos_carrinho|
            {
              id: produtos_carrinho.produto.id,
              nome: produtos_carrinho.produto.nome,
              preco: produtos_carrinho.preco
            }
          end
        }
  
        render json: { mensagem: "Carrinho encontrado.", dados: carrinho_info }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { mensagem: 'Carrinho não encontrado' }, status: :not_found
      rescue => e
        Rails.logger.error e.message
        render json: { mensagem: 'Erro de servidor' }, status: :internal_server_error
      end
    end
  
    # POST /carrinhos
    def create
      begin
        usuario = Usuario.find(params[:usuario_id])
  
        novo_carrinho = Carrinho.new(usuario: usuario)
  
        if novo_carrinho.save
          render json: { mensagem: 'Carrinho criado com sucesso.', carrinho_id: novo_carrinho.id }, status: :created
        else
          render json: { mensagem: 'Erro ao criar carrinho.', erros: novo_carrinho.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { mensagem: 'Usuário não encontrado.' }, status: :not_found
      rescue => e
        Rails.logger.error e.message
        render json: { mensagem: 'Erro de servidor' }, status: :internal_server_error
      end
    end
  
    # DELETE /carrinhos/:id
    def destroy
      begin
        carrinho = Carrinho.find(params[:id])
  
        if carrinho.destroy
          render json: { mensagem: 'Carrinho excluído com sucesso.' }, status: :ok
        else
          render json: { mensagem: 'Erro ao excluir carrinho.' }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { mensagem: 'Carrinho não encontrado.' }, status: :not_found
      rescue => e
        Rails.logger.error e.message
        render json: { mensagem: 'Erro de servidor' }, status: :internal_server_error
      end
    end
  end
  