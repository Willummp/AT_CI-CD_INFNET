# Relatório Final Integrado - DevOps (TP1, TP2 e TP3)

**Aluno:** Lucas Ferreira
**Disciplina:** DevOps / Arquitetura de Software

Este documento consolida as entregas e evidências dos três Trabalhos Práticos.

---

# TP1: DevCalc API (Docker e CI Local)

## 1. Versionamento (Git)
**Evidência:** Histórico de commits demonstrando a evolução do projeto.
> **Instrução:** Cole aqui o print do terminal rodando `git log --oneline` ou print da aba "Commits" do GitHub.
<!-- INSIRA O PRINT AQUI -->

## 2. Testes Automatizados
**Evidência:** Execução bem-sucedida dos testes unitários JUnit.
> **Instrução:** Cole aqui o print do terminal mostrando `[INFO] Tests run: 5, Failures: 0`. (Pode ser do output do script `run_all.sh` na parte do Maven).
<!-- INSIRA O PRINT AQUI -->

## 3. Dockerização
**Evidência:** Build da imagem Docker realizado com sucesso.
> **Instrução:** Cole aqui o print do final do comando `docker build` mostrando que a imagem foi criada com sucesso.
<!-- INSIRA O PRINT AQUI -->

## 4. Funcionamento da API
**Evidência:** A API respondendo a uma requisição (rodando localmente ou via Docker).
> **Instrução:** Cole aqui o print do navegador ou Postman acessando `http://localhost:7070/add?a=10&b=5` com o resultado `15.0`.
<!-- INSIRA O PRINT AQUI -->

---

# TP2: Kubernetes

## 1. Pod Multi-container (Sidecar)
**Evidência:** Container Busybox acessando o Nginx dentro do mesmo Pod.
> **Instrução:** Cole o print do comando `kubectl logs multi-container-pod -c busybox-sidecar -n tp2`. Deve mostrar a data e o HTML do Nginx.
<!-- INSIRA O PRINT AQUI -->

## 2. Deployment e Scaling
**Evidência A:** Deployment com 2 réplicas iniciais.
> **Instrução:** Cole o print do comando `kubectl get deployment devcalc-deployment -n tp2` mostrando `2/2`.
<!-- INSIRA O PRINT AQUI -->

**Evidência B:** Escalonamento para 3 réplicas.
> **Instrução:** Cole o print do mesmo comando acima, mas agora mostrando `3/3` após o comando de scale.
<!-- INSIRA O PRINT AQUI -->

## 3. Services

**Evidência A: Service Interno (ClusterIP)**
> **Instrução:** Cole o print do teste de conexão interna (ex: usando `kubectl run` ou o script de teste) mostrando que o `wget` para o serviço interno funcionou.
<!-- INSIRA O PRINT AQUI -->

**Evidência B: Service Externo (NodePort)**
> **Instrução:** Cole o print do **navegador** acessando a URL do Minikube (ex: `http://192.168.49.2:30003/add...`) com o resultado da soma.
<!-- INSIRA O PRINT AQUI -->

---

# TP3: GitHub Actions

## 1. Workflows Básicos

### Hello CI/CD
**Evidência:** Workflow rodando em push.
> **Instrução:** Vá na aba "Actions" do GitHub, clique em "Hello CI/CD", abra a execução e tire print do log mostrando "Hello CI/CD".
<!-- INSIRA O PRINT AQUI -->

### Maven CI
**Evidência:** Build e Testes automatizados no GitHub.
> **Instrução:** Tire print da execução do workflow "Maven CI" mostrando todas as etapas verdes (Build with Maven sucesso). os testes passando.
<!-- INSIRA O PRINT AQUI -->

## 2. Runners e Variáveis

### Env Demo
**Evidência:** Leitura de Variável de Ambiente.
> **Instrução:** Rode o workflow "Environment Variables Demo" manualmente (Workflow Dispatch). Tire print do log mostrando "O ambiente configurado é: staging".
<!-- INSIRA O PRINT AQUI -->

### Secret Demo
**Evidência:** Leitura segura de Secrets.
> **Instrução:** Rode o workflow "Secret Demo" manualmente. Tire print do log mostrando "API_KEY configurado" (certifique-se de ter criado o secret no Settings do repo antes).
<!-- INSIRA O PRINT AQUI -->

## 3. Estratégias de Deploy

### Matrix Strategy
**Evidência:** Teste em múltiplas versões do Java.
> **Instrução:** Rode o workflow "Java Matrix Test". Tire print da lateral esquerda mostrando dois jobs rodando (ex: `matrix-test (17)` e `matrix-test (21)`).
<!-- INSIRA O PRINT AQUI -->

### Questões Teóricas

**1. Runners Hospedados vs Auto-hospedados**
> **Runners Hospedados pelo GitHub:** Vantagens incluem manutenção zero e ambiente limpo a cada execução. Desvantagens são custos por minuto (após limite free) e hardware padronizado.
> **Runners Auto-hospedados:** Vantagens incluem customização de hardware e persistência de cache para velocidade. Desvantagens são o custo e esforço de manutenção e segurança do servidor próprio.

**2. Blue-Green vs Rolling Update**
> **Blue-Green:** Mantém dois ambientes (atual e novo). Troca o tráfego de uma vez. Ideal para mudanças críticas onde não se pode misturar versões.
> **Rolling Update:** Atualiza as instâncias gradualmente (uma por uma ou em lotes). Ideal para grandes clusters e aplicações que suportam retrocompatibilidade, economizando recursos.

## 4. Monitoramento

### Status Badge
**Evidência:** Badge no README.
> **Instrução:** Tire um print do topo do seu `README.md` no GitHub mostrando o balãozinho "passing" verde.
<!-- INSIRA O PRINT AQUI -->

### deploy.yml (Questão Integrada)
**Evidência:** Workflow final condicional.
> **Instrução:** Tire print da execução do "Integrated Full Deploy" que rodou no push da main.
<!-- INSIRA O PRINT AQUI -->
