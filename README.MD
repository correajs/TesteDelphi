Projeto Teste

- O projeto foi criado utilizando Delphi Berlin (update 2).
- O banco de dados utilizado foi o PostgreSql 9.5.1 (32 bits).
- O gerenciador de relatórios usado foi o ReportBuild 18.

Os componentes de conexão e acesso a dados utilizados foram os padrão FireDAC:
	- FDConnection
	- FDQuery
	- FDPhysPgDriverLink

Para o correto funcionamento do sistema proposto, o banco "Teste" foi criado, utilizando-se a interface do "pgAdmin III" (provido com a instalação do PostGreSql).

Após criado o banco de dados no referido programa, pode-se utlizar o sistema "Teste", que é composto basicamente de dois cadastros (Clientes e Produtos), bem como de um formulário para "venda" dos produtos cadastrados, aos clientes (igualmente cadastrados).

No cadastro de Clientes, as informações requeridas para cadastro são, apenas, a RAZÃO SOCIAL e O CNPJ do Cliente; a inclusão das demais informações do cadastro são facultadas.

No Cadastro de Produtos, apenas o NOME do produto é obrigatório ao cadastro.

No formulário de "vendas" o usuário poderá "pesquisar" o cliente, bem como o produto a ser utilizado na referida operação.

No formulário de Relatórios, o usuário poderá escolher pela Data da Venda, Cliente e Produtos para geração do relatório.