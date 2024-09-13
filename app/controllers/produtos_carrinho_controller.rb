class ProdutosCarrinhoController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create, :destroy]
  
    # POST /carrinhos/:carrinho_id/produtos_carrinho
    def create
      begin
        carrinho = Carrinho.find(params[:carrinho_id])
        produto = Produto.find(params[:produto_id])
  
        novo_produto_carrinho = ProdutosCarrinho.new(
          carrinho: carrinho,
          produto: produto,
          preco: produto.preco
        )
  
        if novo_produto_carrinho.save
          render json: { mensagem: 'Produto adicionado ao carrinho com sucesso.' }, status: :created
        else
          render json: { mensagem: 'Erro ao adicionar produto ao carrinho.', erros: novo_produto_carrinho.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { mensagem: 'Carrinho ou produto não encontrado.' }, status: :not_found
      rescue => e
        Rails.logger.error e.message
        render json: { mensagem: 'Erro de servidor' }, status: :internal_server_error
      end
    end
  
    # DELETE /carrinhos/:carrinho_id/produtos_carrinho/:id
    def destroy
      begin
        produtos_carrinho = ProdutosCarrinho.find(params[:id])
  
        if produtos_carrinho.destroy
          render json: { mensagem: 'Produto removido do carrinho com sucesso.' }, status: :ok
        else
          render json: { mensagem: 'Erro ao remover produto do carrinho.' }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { mensagem: 'Produto no carrinho não encontrado.' }, status: :not_found
      rescue => e
        Rails.logger.error e.message
        render json: { mensagem: 'Erro de servidor' }, status: :internal_server_error
      end
    end
  end
  