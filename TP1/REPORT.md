# Relatório de Implementação - DevCalc API (TP1)

Este documento detalha as etapas realizadas para a implementação e configuração do projeto DevCalc API.

## 1. Estrutura do Projeto e Versionamento

O projeto foi inicializado utilizando **Maven** e **Java 17**.
A estrutura de diretórios segue o padrão Maven:
- `src/main/java/com/devcalc`
- `src/test/java/com/devcalc`

O repositório Git foi configurado e a branch `feature/calculator-endpoints` foi utilizada para o desenvolvimento das funcionalidades.

**Evidência de Versionamento:**
O histórico de commits pode ser visualizado no arquivo `evidencias/git_history.txt`.

## 2. Implementação da API

A classe `CalculatorService` implementa as operações matemáticas:
- Adição
- Subtração
- Multiplicação
- Divisão (com tratamento para divisão por zero)

A aplicação utiliza o framework **Javalin** na classe `DevCalcApp` para expor os endpoints na porta **7070**.

## 3. Testes Automatizados

Foram implementados testes unitários utilizando **JUnit 5** na classe `CalculatorServiceTest`.
Todos os testes foram executados com sucesso.

**Evidência de Testes:**
O output da execução dos testes via Maven está disponível em `evidencias/maven_test_output.txt`.

## 4. Docker e Containerização

### Dockerfile (Single-stage)
Criado arquivo `Dockerfile` baseado em `openjdk:17-alpine` para execução leve da aplicação.

### Dockerfile (Multi-stage)
Criado arquivo `Dockerfile.multistage` que realiza o build da aplicação (Maven) e geração da imagem final em estágios separados, garantindo uma imagem final menor e sem dependências de build.

### Docker Compose
O arquivo `docker-compose.yml` orquestra o ambiente com:
- **API DevCalc**
- **Postgres** (Banco Relacional)
- **Redis** (Banco Não-relacional)
- **Tester** (Busybox para testes de rede)

Os serviços estão configurados na rede `devcalc-network` e utilizam volumes persistentes.

## 5. Observações sobre Execução Docker

O ambiente atual não possui o **Docker Daemon** instalado, impossibilitando a execução local dos comandos `docker build` e `docker-compose up`.
Todos os arquivos de configuração (Dockerfiles, Compose) foram criados e verificados sintaticamente.

Recomenda-se executar os seguintes comandos em um ambiente com Docker:

```bash
# Build da imagem (Single Stage)
docker build -f Dockerfile -t devcalc-api:1.0.0 .

# Build da imagem (Multi Stage)
docker build -f Dockerfile.multistage -t devcalc-api:latest .

# Execução do ambiente completo
docker-compose up -d --build
```

## Conclusão

O projeto atende aos requisitos de implementação Java, testes unitários e estruturação de configurações para Containers e CI/CD.
