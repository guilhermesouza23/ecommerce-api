class UsuariosController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :index, :show, :update, :destroy]

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

  # GET /usuarios/:id
  def show
    begin
      usuario = Usuario.find(params[:id])
      render json: usuario, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { mensagem: 'Usuário não encontrado' }, status: :not_found
    end
  end

  # POST /usuarios
  def create
    begin
      dados = params.require(:usuario).permit(:nome, :email, :senha)

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

  # PUT /usuarios/:id
  def update
    begin
      usuario = Usuario.find(params[:id])
      if usuario.update(params.require(:usuario).permit(:nome, :email, :senha))
        render json: { mensagem: 'Usuário atualizado com sucesso' }, status: :ok
      else
        render json: { mensagem: 'Erro ao atualizar usuário', erros: usuario.errors.full_messages }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { mensagem: 'Usuário não encontrado' }, status: :not_found
    rescue => e
      Rails.logger.error e.message
      render json: { mensagem: 'Erro de servidor' }, status: :internal_server_error
    end
  end

  # DELETE /usuarios/:id
  def destroy
    begin
      usuario = Usuario.find(params[:id])
      usuario.destroy
      render json: { mensagem: 'Usuário excluído com sucesso' }, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { mensagem: 'Usuário não encontrado' }, status: :not_found
    rescue => e
      Rails.logger.error e.message
      render json: { mensagem: 'Erro de servidor' }, status: :internal_server_error
    end
  end
end
