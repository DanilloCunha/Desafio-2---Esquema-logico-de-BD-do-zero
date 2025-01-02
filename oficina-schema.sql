-- Criação do banco de dados
CREATE DATABASE oficina;
USE oficina;

-- Criação das tabelas
CREATE TABLE Mecanicos (
    idMecanicos INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(45) NOT NULL,
    Endereco VARCHAR(45),
    Especialidade VARCHAR(45)
);

CREATE TABLE Clientes (
    idClientes INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(45) NOT NULL,
    Telefone VARCHAR(20),
    Endereco VARCHAR(45)
);

CREATE TABLE Veiculos (
    idVeiculos INT PRIMARY KEY AUTO_INCREMENT,
    Placa VARCHAR(45) UNIQUE NOT NULL,
    Marca VARCHAR(45),
    Modelo VARCHAR(45),
    Ano INT(4),
    Codigo_Cliente INT,
    FOREIGN KEY (Codigo_Cliente) REFERENCES Clientes(idClientes)
);

CREATE TABLE Ordem_Servico (
    idOrdem_Servico INT PRIMARY KEY AUTO_INCREMENT,
    Data_Emissao DATE NOT NULL,
    Status VARCHAR(45) NOT NULL,
    Placa_Veiculo VARCHAR(10),
    Codigo_Cliente INT,
    FOREIGN KEY (Codigo_Cliente) REFERENCES Clientes(idClientes)
);

CREATE TABLE tabela_mao_obra (
    idtabela_mao_obra INT PRIMARY KEY AUTO_INCREMENT,
    Descricao_servico VARCHAR(45) NOT NULL,
    Valor_servico DECIMAL(10,2) NOT NULL
);

CREATE TABLE Pecas (
    idPecas INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Peca VARCHAR(45) NOT NULL,
    Valor_Peca DECIMAL(10,2) NOT NULL,
    Estoque INT NOT NULL
);

-- Tabelas de relacionamento N:M
CREATE TABLE Mecanicos_Ordem_Servico (
    Mecanicos_idMecanicos INT,
    Ordem_Servico_idOrdem_Servico INT,
    PRIMARY KEY (Mecanicos_idMecanicos, Ordem_Servico_idOrdem_Servico),
    FOREIGN KEY (Mecanicos_idMecanicos) REFERENCES Mecanicos(idMecanicos),
    FOREIGN KEY (Ordem_Servico_idOrdem_Servico) REFERENCES Ordem_Servico(idOrdem_Servico)
);

CREATE TABLE Pecas_Ordem_Servico (
    Pecas_idPecas INT,
    Ordem_Servico_idOrdem_Servico INT,
    Quantidade INT NOT NULL DEFAULT 1,
    PRIMARY KEY (Pecas_idPecas, Ordem_Servico_idOrdem_Servico),
    FOREIGN KEY (Pecas_idPecas) REFERENCES Pecas(idPecas),
    FOREIGN KEY (Ordem_Servico_idOrdem_Servico) REFERENCES Ordem_Servico(idOrdem_Servico)
);

CREATE TABLE mao_obra_Ordem_Servico (
    tabela_mao_obra_idtabela_mao_obra INT,
    Ordem_Servico_idOrdem_Servico INT,
    PRIMARY KEY (tabela_mao_obra_idtabela_mao_obra, Ordem_Servico_idOrdem_Servico),
    FOREIGN KEY (tabela_mao_obra_idtabela_mao_obra) REFERENCES tabela_mao_obra(idtabela_mao_obra),
    FOREIGN KEY (Ordem_Servico_idOrdem_Servico) REFERENCES Ordem_Servico(idOrdem_Servico)
);

-- Inserção de dados para teste
INSERT INTO Mecanicos (Nome, Endereco, Especialidade) VALUES
('João Silva', 'Rua A, 123', 'Motor'),
('Maria Santos', 'Rua B, 456', 'Elétrica'),
('Pedro Costa', 'Rua C, 789', 'Suspensão');

INSERT INTO Clientes (Nome, Telefone, Endereco) VALUES
('Ana Oliveira', '(11)99999-9999', 'Av X, 100'),
('Carlos Souza', '(11)88888-8888', 'Av Y, 200'),
('Lucia Lima', '(11)77777-7777', 'Av Z, 300');

INSERT INTO Veiculos (Placa, Marca, Modelo, Ano, Codigo_Cliente) VALUES
('ABC1234', 'Toyota', 'Corolla', 2020, 1),
('DEF5678', 'Honda', 'Civic', 2019, 2),
('GHI9012', 'Ford', 'Ka', 2021, 3);

INSERT INTO Ordem_Servico (Data_Emissao, Status, Placa_Veiculo, Codigo_Cliente) VALUES
('2024-01-01', 'Em Andamento', 'ABC1234', 1),
('2024-01-02', 'Concluído', 'DEF5678', 2),
('2024-01-03', 'Aguardando Peças', 'GHI9012', 3);

INSERT INTO tabela_mao_obra (Descricao_servico, Valor_servico) VALUES
('Troca de Óleo', 100.00),
('Alinhamento', 80.00),
('Revisão Geral', 200.00);

INSERT INTO Pecas (Nome_Peca, Valor_Peca, Estoque) VALUES
('Óleo Motor', 50.00, 100),
('Filtro de Óleo', 30.00, 50),
('Pastilha de Freio', 150.00, 30);
