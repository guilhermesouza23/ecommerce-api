# README

Como Rodar o Projeto de API Ruby on Rails
Olá!

Para rodar o projeto da API Ruby on Rails no seu computador, siga as etapas abaixo:

Clone o Repositório Primeiro, você precisa clonar o repositório do projeto para o seu computador. Abra o terminal e execute o seguinte comando:

git clone https://github.com/guilhermesouza23/ecommerce-api.git

Depois, acesse o diretório do projeto : cd ecommerce-api

Instale as Dependências O projeto utiliza algumas bibliotecas Ruby que precisam ser instaladas. Certifique-se de ter o Ruby e o Bundler instalados. Caso não tenha o Bundler, você pode instalá-lo com o comando: gem install bundler

Com o Bundler instalado, execute o comando a seguir para instalar as dependências do projeto: bundle install

Configure o Banco de Dados O próximo passo é configurar o banco de dados. No terminal, execute os seguintes comandos para criar e migrar o banco de dados:
rails db:create
rails db:migrate

Inicie o Servidor Com tudo configurado, você está pronto para iniciar o servidor Rails. Execute o comando:
rails server

O servidor será iniciado e estará disponível no endereço http://localhost:3000.

Teste a API Para verificar se a API está funcionando corretamente, você pode utilizar ferramentas como Postman ou curl para fazer requisições aos endpoints da API.

Se você encontrar algum problema ou tiver dúvidas durante o processo, sinta-se à vontade para me contatar para obter ajuda.

