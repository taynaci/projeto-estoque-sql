CREATE DATABASE estoque;
USE estoque;

CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    quantidade INT,
    preco DECIMAL(10,2)
);

CREATE TABLE fornecedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    contato VARCHAR(100)
);

CREATE TABLE entradas_estoque (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,
    fornecedor_id INT,
    quantidade INT,
    data_entrada DATETIME,
    FOREIGN KEY (produto_id) REFERENCES produtos(id),
    FOREIGN KEY (fornecedor_id) REFERENCES fornecedores(id)
);

CREATE TABLE saidas_estoque (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,
    quantidade INT,
    data_saida DATETIME,
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

INSERT INTO produtos (nome, quantidade, preco)
VALUES 
('Notebook', 10, 3500.00),
('Mouse', 50, 50.00),
('Teclado', 30, 120.00);

INSERT INTO fornecedores (nome, contato)
VALUES 
('Fornecedor A', 'contato@a.com'),
('Fornecedor B', 'contato@b.com');

INSERT INTO entradas_estoque (produto_id, fornecedor_id, quantidade, data_entrada)
VALUES 
(1, 1, 5, NOW()),
(2, 2, 10, NOW());

INSERT INTO saidas_estoque (produto_id, quantidade, data_saida)
VALUES 
(1, 2, NOW()),
(2, 5, NOW());

-- Consulta profissional de estoque
SELECT 
    p.nome AS produto,
    IFNULL(SUM(e.quantidade), 0) AS total_entrada,
    IFNULL(SUM(s.quantidade), 0) AS total_saida,
    (p.quantidade + IFNULL(SUM(e.quantidade),0) - IFNULL(SUM(s.quantidade),0)) AS saldo
FROM produtos p
LEFT JOIN entradas_estoque e ON p.id = e.produto_id
LEFT JOIN saidas_estoque s ON p.id = s.produto_id
GROUP BY p.id, p.nome, p.quantidade;