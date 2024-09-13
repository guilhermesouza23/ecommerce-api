class SessionsController < ApplicationController
  # Desabilitar verificação de CSRF para endpoints de API
  skip_before_action :verify_authenticity_token
  def create
    # Encontra o usuário pelo email
    usuario = Usuario.find_by(email: params[:email])
    
    # Verifica se o usuário existe e a senha está correta
    if usuario && usuario.senha == params[:senha]
      # Você pode querer usar algo como JWT para gerar um token de sessão
      # Para este exemplo, estamos apenas retornando uma mensagem de sucesso
      render json: { message: 'Login realizado com sucesso!' }, status: :ok
    else
      render json: { error: 'Email ou senha inválidos' }, status: :unauthorized
    end
  end

end