# Projeto de DevOps CI/CD - TP1, TP2 e TP3

[![Maven CI](https://github.com/Willummp/AT_CI-CD_INFNET/actions/workflows/maven-ci.yml/badge.svg)](https://github.com/Willummp/AT_CI-CD_INFNET/actions/workflows/maven-ci.yml)

**Aluno:** Lucas Ferreira
**Disciplina:** DevOps / Arquitetura de Software

Este repositório contém as entregas dos Trabalhos Práticos 1, 2 e 3.

## Estrutura do Repositório

- **TP1/**: API REST "DevCalc" em Java (Calculadora). Inclui código fonte, testes e Dockerfiles.
- **TP2/**: Manifestos Kubernetes para orquestração da aplicação DevCalc.
- **TP3/**: Relatório e evidências dos Workflows do GitHub Actions.
- **.github/workflows**: Arquivos YAML de configuração dos pipelines de CI/CD (TP3).
- **run_all.sh**: Script utilitário para automatizar a execução completa (Build + Deploy).

## Pré-requisitos Gerais

Para executar os projetos, é necessário ter instalado:
- Java JDK 17+
- Maven 3.8+
- Docker
- Kubernetes Cluster (Minikube recomendado)
- Kubectl

## Instruções de Execução

Você pode executar o projeto de forma automatizada (recomendado) ou manual.

### 1. Execução Automatizada (Script)

**Linux / macOS / WSL:**
```bash
chmod +x run_all.sh
./run_all.sh
```

**Windows (PowerShell):**
Abra o PowerShell como Administrador e execute:
```powershell
./run_all.ps1
```
*Vá aceitando as permissões caso solicitado.*

### 2. Execução Manual
Caso prefira executar cada etapa manualmente para correção, consulte os `README.md` específicos:

Caso prefira executar cada etapa manualmente para correção, consulte os `README.md` específicos dentro de cada pasta:

- [Instruções TP1](TP1/README.md)
- [Instruções TP2](TP2/README.md)
- [Relatório TP3 (GitHub Actions)](TP3/README.md)

## Verificação TP3 (GitHub Actions)

Os workflows do TP3 são executados automaticamente pelo GitHub.
Para verificar:
1. Acesse a aba **Actions** neste repositório.
2. Observe a execução dos workflows (Hello, Tests, Maven, etc).
3. Consulte o [Relatório TP3](TP3/README.md) para detalhes teóricos e evidências.
