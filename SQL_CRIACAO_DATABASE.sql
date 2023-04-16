CREATE TABLE IF NOT EXISTS clientes (
    codigo_cliente INTEGER AUTO_INCREMENT PRIMARY KEY,
	nome_cliente VARCHAR(100) NOT NULL,
	cidade_cliente VARCHAR(50) NOT NULL,
	uf_cliente VARCHAR(2) NOT NULL
);

CREATE TABLE IF NOT EXISTS produtos (
	codigo_produto INTEGER AUTO_INCREMENT PRIMARY KEY,
	descricao_produto VARCHAR(100) NOT NULL,
	preco_venda_produto DECIMAL(10,2) NOT NULL    
);

CREATE TABLE IF NOT EXISTS pedidos (
	numero_pedido INTEGER PRIMARY KEY,
	data_emissao_pedido DATE NOT NULL,
	codigo_cliente INTEGER NOT NULL,
	valor_total_pedido DECIMAL(10,2) NOT NULL,    
	CONSTRAINT FK_PEDIDOS_CLIENTE FOREIGN KEY (codigo_cliente) REFERENCES clientes(codigo_cliente)
);

CREATE TABLE IF NOT EXISTS pedidos_itens (
	codigo_pedido_item INTEGER AUTO_INCREMENT PRIMARY KEY,
	numero_pedido INTEGER NOT NULL,
	codigo_produto INTEGER NOT NULL,
	quantidade_pedido_item DECIMAL(10,2) NOT NULL,    
	valor_unitario_pedido_item DECIMAL(10,2) NOT NULL,    
	valor_total_pedido_item DECIMAL(10,2) NOT NULL,   
    
	CONSTRAINT FK_PEDIDOSITENS_PEDIDO FOREIGN KEY (numero_pedido)  REFERENCES pedidos(numero_pedido),
	CONSTRAINT FK_PEDIDOSITENS_PRODUTO FOREIGN KEY (codigo_produto)  REFERENCES produtos(codigo_produto)
);

INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 1, 'João da Silva', 'São Paulo', 'SP'    	   WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 1);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 2, 'Maria Oliveira', 'Rio de Janeiro', 'RJ'   WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 2);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 3, 'Pedro Ferreira', 'Salvador', 'BA'    	   WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 3);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 4, 'Ana Rodrigues', 'Belo Horizonte', 'MG'    WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 4);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 5, 'Lucas Lima', 'Curitiba', 'PR'        	   WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 5);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 6, 'Camila Almeida', 'Fortaleza', 'CE'        WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 6);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 7, 'Mariana Ribeiro', 'Recife', 'PE'          WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 7);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 8, 'Paulo Santos', 'Brasília', 'DF'           WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 8);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 9, 'Carla Pereira', 'Manaus', 'AM'       	   WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 9);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 10, 'Rafael da Silva', 'Porto Alegre', 'RS'   WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 10);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 11, 'Fernanda Costa', 'Florianópolis', 'SC'   WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 11);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 12, 'Gustavo Oliveira', 'Belém', 'PA'    	   WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 12);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 13, 'Amanda Santos', 'Vitória', 'ES'     	   WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 13);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 14, 'Ricardo Alves', 'São Luís', 'MA'    	   WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 14);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 15, 'Juliana Silva', 'Cuiabá', 'MT'      	   WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 15);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 16, 'Marcelo Rodrigues', 'Aracaju', 'SE' 	   WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 16);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 17, 'Isabela Ribeiro', 'João Pessoa', 'PB'    WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 17);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 18, 'Henrique Lima', 'Campo Grande', 'MS'	   WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 18);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 19, 'Renata Fernandes', 'Teresina', 'PI' 	   WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 19);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 20, 'Diego Oliveira', 'Maceió', 'AL'     	   WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 20);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 21, 'Joacir da Silva', 'São Paulo', 'SP'      WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 21);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 22, 'Aline Pereira', 'Rio de Janeiro', 'RJ'   WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 22);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 23, 'Felipe Souza', 'Belo Horizonte', 'MG'    WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 23);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 24, 'Lucas Oliveira', 'Porto Alegre', 'RS'    WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 24);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 25, 'Isabela Santos', 'Recife', 'PE'          WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 25);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 26, 'Paulo Ferreira', 'Fortaleza', 'CE'       WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 26);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 27, 'Almeida Gonçalves', 'Salvador', 'BA'     WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 27);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 28, 'André Luiz', 'Goiânia', 'GO'             WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 28);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 29, 'Carolina Costa', 'Brasília', 'DF'        WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 29);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 30, 'Gustavo Lima', 'Cuiabá', 'MT'            WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 30);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 31, 'Ana Beatriz', 'São Luís', 'MA'           WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 31);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 32, 'Diego Silva', 'Natal', 'RN'              WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 32);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 33, 'Mariana Santos', 'Florianópolis', 'SC'   WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 33);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 34, 'Roberto Oliveira', 'Manaus', 'AM'        WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 34);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 35, 'Amanda Fernandes', 'Teresina', 'PI'      WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 35);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 36, 'Fábio Souza', 'João Pessoa', 'PB'        WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 36);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 37, 'Juliana Rodrigues', 'Belém', 'PA'        WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 37);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 38, 'Leonardo Castro', 'Maceió', 'AL'         WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 38);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 39, 'Bianca Costa', 'Aracaju', 'SE'           WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 39);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 40, 'Marcelo Santos', 'Campinas', 'SP'        WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 40);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 41, 'Priscila Oliveira', 'Porto Velho', 'RO'  WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 41);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 42, 'Lucas Mendes', 'Palmas', 'TO'            WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 42);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 43, 'Valéria Silva', 'Vitória', 'ES'          WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 43);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 44, 'Matheus Pereira', 'Curitiba', 'PR'       WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 44);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 45, 'Sabrina Almeida', 'Recife', 'PE'         WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 45);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 46, 'Rafael Silva', 'Campo Grande', 'MS'      WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 46);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 47, 'Silvana Oliveira', 'Porto Alegre', 'RS'  WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 47);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 48, 'Pedro Henrique', 'Cuiabá', 'MT'          WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 48);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 49, 'Lorena Souza', 'João Pessoa', 'PB'       WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 49);
INSERT INTO clientes (codigo_cliente, nome_cliente, cidade_cliente, uf_cliente) SELECT 50, 'Felipe Rodrigues', 'São Paulo', 'SP'     WHERE NOT EXISTS (SELECT 1 FROM clientes WHERE codigo_cliente = 50);

INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 1, 'Caneta esferográfica azul', 1.99     	              WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 1);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 2, 'Caneta esferográfica preta', 1.99    	              WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 2);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 3, 'Lápis HB nº2', 0.99                  	              WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 3);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 4, 'Caderno espiral 100 folhas', 5.99    	              WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 4);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 5, 'Borracha branca', 0.49               	              WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 5);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 6, 'Apontador de lápis', 1.29            	              WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 6);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 7, 'Cola em bastão', 1.49                	              WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 7);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 8, 'Fita corretiva', 1.99                	              WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 8);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 9, 'Régua de 30 cm', 0.99                	              WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 9);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 10, 'Tesoura de escritório', 3.99         	              WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 10);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 11, 'Clips metálico pequeno', 0.29        	              WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 11);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 12, 'Clips metálico médio', 0.49          	              WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 12);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 13, 'Clips metálico grande', 0.69         	              WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 13);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 14, 'Pasta de plástico com elástico', 1.99	              WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 14);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 15, 'Agenda de bolso', 4.99               	              WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 15);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 16, 'Marcador de texto amarelo', 1.79     	              WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 16);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 17, 'Caneta marca-texto rosa', 1.79       	              WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 17);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 18, 'Papel sulfite A4 500 folhas', 19.99  	              WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 18);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 19, 'Bloco de notas adesivas', 2.49       	              WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 19);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 20, 'Estojo escolar', 6.99                	              WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 20);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 21, 'Arroz Tio João 5kg', 29.90                          WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 21);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 22, 'Feijão Carioca Kicaldo 1kg', 7.99                   WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 22);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 23, 'Açúcar União 1kg', 2.99                             WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 23);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 24, 'Óleo de Soja Soya 900ml', 4.49                      WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 24);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 25, 'Sal Refinado Cisne 1kg', 2.49                       WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 25);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 26, 'Café Melitta Tradicional 500g', 9.99                WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 26);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 27, 'Leite Integral Piracanjuba 1L', 3.49                WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 27);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 28, 'Leite Condensado Moça 395g', 4.29                   WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 28);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 29, 'Creme de Leite Nestlé 200g', 2.49                   WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 29);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 30, 'Molho de Tomate Elefante 340g', 1.69                WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 30);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 31, 'Macarrão Espaguete Renata 500g', 2.19               WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 31);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 32, 'Biscoito Recheado Nestlé Negresco 140g', 2.99       WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 32);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 33, 'Bolacha Maizena Piraquê 200g', 1.99                 WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 33);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 34, 'Farinha de Trigo Dona Benta 1kg', 4.19              WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 34);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 35, 'Fermento Químico Royal 100g', 1.79                  WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 35);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 36, 'Biscoito Salgado Club Social Original 96g', 1.89    WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 36);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 37, 'Margarina Delícia Supreme 500g', 6.99               WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 37);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 38, 'Refrigerante Coca-Cola 2L', 7.49                    WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 38);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 39, 'Leite em Pó Ninho Fases 800g', 26.90                WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 39);
INSERT INTO produtos (codigo_produto, descricao_produto, preco_venda_produto) SELECT 40, 'Peito de Frango Sadia Congelado 1kg', 11.90         WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_produto = 40);





