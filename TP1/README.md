# TP1 - DevCalc API

Este projeto consiste em uma API REST simples para operações matemáticas, desenvolvida como base para estudos de CI/CD e Containerização.

## Objetivos
- Implementar API Java com Javalin.
- Implementar Testes Unitários com JUnit.
- Containerizar a aplicação com Docker (Single e Multi-stage).
- Orquestrar ambiente local com Docker Compose.

## Tecnologias
- **Linguagem:** Java 17
- **Framework:** Javalin 6.1.3
- **Build:** Maven 3.8+
- **Testes:** JUnit 5

## Como Executar (Correção)

### 1. Build e Testes Locais
Para verificar se o código compila e os testes passam:

```bash
cd TP1
mvn clean package
```

Os resultados dos testes aparecerão no console.

### 2. Execução com Docker

#### Construção da Imagem
Você pode construir a imagem utilizando o Dockerfile otimizado (multistage):

```bash
docker build -f Dockerfile.multistage -t devcalc-api:1.0.0 .
```

#### Rodando a Aplicação
Execute o container mapeando a porta 7070:

```bash
docker run -p 7070:7070 devcalc-api:1.0.0
```

Teste via navegador ou curl: `http://localhost:7070/add?a=10&b=20`

### 3. Docker Compose (Infraestrutura)
Para subir o ambiente completo (API + BDs + Tester), conforme solicitado no exercício "Simulando Infra as Code":

```bash
docker-compose up -d --build
```

Este comando iniciará:
- `devcalc-api`: A aplicação.
- `postgres`: Banco de dados relacional.
- `redis`: Banco de dados NoSQL.
- `tester`: Container Busybox para testes de rede internas.

## Endpoints

| Método | URL | Descrição | Exemplo |
|--------|-----|-----------|---------|
| GET | `/add` | Soma `a + b` | `/add?a=10&b=5` |
| GET | `/subtract` | Subtrai `a - b` | `/subtract?a=10&b=5` |
| GET | `/multiply` | Multiplica `a * b` | `/multiply?a=10&b=5` |
| GET | `/divide` | Divide `a / b` | `/divide?a=10&b=5` |
