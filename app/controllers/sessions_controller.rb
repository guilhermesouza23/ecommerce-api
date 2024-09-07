class SessionsController < ApplicationController
    # Desativa a verificação CSRF apenas para ações do controlador de sessão
    skip_before_action :verify_authenticity_token, only: [:create, :destroy]
  
    # POST /login
    def create
      user = Usuario.find_by(email: params[:email])
      if user && user.senha == params[:senha]
        render json: { message: 'Login bem-sucedido', user: user }, status: :ok
      else
        render json: { message: 'Credenciais inválidas' }, status: :unauthorized
      end
    end
  
    # DELETE /logout
    def destroy
      # Aqui você pode encerrar a sessão ou invalidar o token, se aplicável
      render json: { message: 'Logout bem-sucedido' }, status: :ok
    end
  end
  