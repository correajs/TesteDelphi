Projeto Teste

- O projeto foi criado utilizando Delphi Berlin (update 2).
- O banco de dados utilizado foi o PostgreSql 9.5.1 (32 bits).
- O gerenciador de relat�rios usado foi o ReportBuild 18.

Os componentes de conex�o e acesso a dados utilizados foram os padr�o FireDAC:
	- FDConnection
	- FDQuery
	- FDPhysPgDriverLink

Para o correto funcionamento do sistema proposto, o banco "Teste" foi criado, utilizando-se a interface do "pgAdmin III" (provido com a instala��o do PostGreSql).

Ap�s criado o banco de dados no referido programa, pode-se utlizar o sistema "Teste", que � composto basicamente de dois cadastros (Clientes e Produtos), bem como de um formul�rio para "venda" dos produtos cadastrados, aos clientes (igualmente cadastrados).

No cadastro de Clientes, as informa��es requeridas para cadastro s�o, apenas, a RAZ�O SOCIAL e O CNPJ do Cliente; a inclus�o das demais informa��es do cadastro s�o facultadas.

No Cadastro de Produtos, apenas o NOME do produto � obrigat�rio ao cadastro.

No formul�rio de "vendas" o usu�rio poder� "pesquisar" o cliente, bem como o produto a ser utilizado na referida opera��o.

No formul�rio de Relat�rios, o usu�rio poder� escolher pela Data da Venda, Cliente e Produtos para gera��o do relat�rio.