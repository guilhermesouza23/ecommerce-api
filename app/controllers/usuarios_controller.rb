class UsuariosController < ApplicationController

    skip_before_action :verify_authenticity_token, only: [:create, :index]
    # GET /usuarios
    def index
      begin
        usuarios = Usuario.all
  
        lista_de_usuarios = usuarios.map do |usuario|
          {
            id: usuario.id,
            nome: usuario.nome,
            email: usuario.email,
            carrinhos: usuario.carrinhos.map do |carrinho|
              {
                id: carrinho.id,
                produtos: carrinho.produtos_carrinho.map do |produtos_carrinho|
                  {
                    id: produtos_carrinho.produto.id,
                    nome: produtos_carrinho.produto.nome
                  }
                end
              }
            end
          }
        end
  
        render json: { mensagem: "Foram encontrados #{lista_de_usuarios.size} usuários.", dados: lista_de_usuarios }, status: :ok
      rescue => e
        Rails.logger.error(e.message)
        render json: { mensagem: 'Erro de servidor' }, status: :internal_server_error
      end
    end
  
    # POST /usuarios
    def create
        Rails.logger.info("Iniciando criação do usuário")
    
        begin
          dados = params.require(:usuario).permit(:nome, :email, :senha)
          Rails.logger.info("Dados recebidos: #{dados.inspect}")
    
          campos_obrigatorios = [:nome, :email, :senha]
          missing_fields = campos_obrigatorios.select { |campo| dados[campo].blank? }
          unless missing_fields.empty?
            return render json: { mensagem: "O(s) campo(s) #{missing_fields.join(', ')} são obrigatórios" }, status: :bad_request
          end
    
          if Usuario.exists?(email: dados[:email])
            return render json: { mensagem: 'Esse email já foi cadastrado' }, status: :unprocessable_entity
          end
    
          usuario = Usuario.new(dados)
          if usuario.save
            render json: { mensagem: 'Usuário cadastrado com sucesso.' }, status: :created
          else
            render json: { mensagem: 'Erro ao cadastrar usuário' }, status: :unprocessable_entity
          end
        rescue => e
          Rails.logger.error("Erro ao criar usuário: #{e.message}")
          render json: { mensagem: 'Erro do servidor' }, status: :internal_server_error
        end
      end
    end
  