-- ================================
--   BANCO DE DADOS CORTE CERTO
--   SCRIPT COMPLETO – EP3
-- ================================

-- Criar banco de dados
CREATE DATABASE corte_certo;
USE corte_certo;

-- ================================
--   CRIAÇÃO DAS TABELAS
-- ================================

CREATE TABLE CLIENTE (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome_cliente VARCHAR(100),
    telefone VARCHAR(20),
    email VARCHAR(100),
    preferencias TEXT
);

CREATE TABLE BARBEIRO (
    id_barbeiro INT PRIMARY KEY AUTO_INCREMENT,
    nome_barbeiro VARCHAR(100),
    telefone VARCHAR(20),
    comissao_percentual DECIMAL(5,2)
);

CREATE TABLE SERVICO (
    id_servico INT PRIMARY KEY AUTO_INCREMENT,
    nome_servico VARCHAR(100),
    preco DECIMAL(10,2),
    duracao_minutos INT
);

CREATE TABLE AGENDAMENTO (
    id_agendamento INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    id_barbeiro INT,
    id_servico INT,
    data_hora_inicio DATETIME,
    status VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
    FOREIGN KEY (id_barbeiro) REFERENCES BARBEIRO(id_barbeiro),
    FOREIGN KEY (id_servico) REFERENCES SERVICO(id_servico)
);

CREATE TABLE ATENDIMENTO (
    id_atendimento INT PRIMARY KEY AUTO_INCREMENT,
    id_agendamento INT,
    valor_final DECIMAL(10,2),
    observacoes TEXT,
    data_registro DATETIME,
    FOREIGN KEY (id_agendamento) REFERENCES AGENDAMENTO(id_agendamento)
);

-- ================================
--   INSERT – POVOAMENTO
-- ================================

INSERT INTO CLIENTE (nome_cliente, telefone, email, preferencias)
VALUES
('Carlos Lima', '11999990000', 'carlos@email.com', 'Corte degradê'),
('João Pedro', '11988887777', 'joao@email.com', 'Barba completa'),
('Marcos Silva', '11977776666', 'marcos@email.com', NULL);

INSERT INTO BARBEIRO (nome_barbeiro, telefone, comissao_percentual)
VALUES
('Rafael Gomes', '11922223333', 40.00),
('Diego Rocha', '11911112222', 30.00);

INSERT INTO SERVICO (nome_servico, preco, duracao_minutos)
VALUES
('Corte Masculino', 40.00, 30),
('Barba Completa', 35.00, 20),
('Corte + Barba', 60.00, 45);

INSERT INTO AGENDAMENTO (id_cliente, id_barbeiro, id_servico, data_hora_inicio, status)
VALUES
(1, 1, 1, '2025-02-10 14:00:00', 'Confirmado'),
(2, 1, 3, '2025-02-10 15:00:00', 'Confirmado'),
(3, 2, 2, '2025-02-11 13:30:00', 'Cancelado');

INSERT INTO ATENDIMENTO (id_agendamento, valor_final, observacoes, data_registro)
VALUES
(1, 40.00, 'Cliente pediu ajuste no final', '2025-02-10 14:40:00'),
(2, 60.00, 'Atendimento normal', '2025-02-10 15:50:00');

-- ================================
--   SELECT – CONSULTAS
-- ================================

-- 1. Listar todos os clientes em ordem alfabética
SELECT * FROM CLIENTE
ORDER BY nome_cliente ASC;

-- 2. Buscar agendamentos confirmados
SELECT * FROM AGENDAMENTO
WHERE status = 'Confirmado';

-- 3. Trazer agendamentos com nome do cliente, barbeiro e serviço
SELECT A.id_agendamento, C.nome_cliente, B.nome_barbeiro, S.nome_servico, A.data_hora_inicio
FROM AGENDAMENTO A
JOIN CLIENTE C ON A.id_cliente = C.id_cliente
JOIN BARBEIRO B ON A.id_barbeiro = B.id_barbeiro
JOIN SERVICO S ON A.id_servico = S.id_servico
ORDER BY A.data_hora_inicio;

-- 4. Serviços mais caros primeiro
SELECT nome_servico, preco
FROM SERVICO
ORDER BY preco DESC
LIMIT 5;

-- 5. Atendimentos realizados com o valor final
SELECT * FROM ATENDIMENTO;

-- ================================
--   UPDATE – 3 EXEMPLOS
-- ================================

-- 1. Atualizar telefone do cliente
UPDATE CLIENTE 
SET telefone = '11955554444'
WHERE id_cliente = 3;

-- 2. Alterar status de um agendamento
UPDATE AGENDAMENTO
SET status = 'Confirmado'
WHERE id_agendamento = 3;

-- 3. Ajustar preço de um serviço
UPDATE SERVICO
SET preco = 42.00
WHERE id_servico = 1;

-- ================================
--   DELETE – 3 EXEMPLOS
-- ================================

-- 1. Remover um cliente específico
DELETE FROM CLIENTE
WHERE id_cliente = 3;

-- 2. Deletar um serviço que não é mais oferecido
DELETE FROM SERVICO
WHERE id_servico = 2;

-- 3. Excluir um agendamento cancelado
DELETE FROM AGENDAMENTO
WHERE status = 'Cancelado';

