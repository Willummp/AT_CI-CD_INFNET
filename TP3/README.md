# Relatório TP3 - GitHub Actions

**Aluno:** Lucas Ferreira
**Disciplina:** DevOps

Este documento cobre os requisitos teóricos do TP3 e serve de guia para as evidências de execução.

> **Nota:** Os arquivos de configuração dos workflows (`.yml`) estão localizados na pasta padrão do GitHub: `.github/workflows/`. Esta pasta `TP3/` é destinada apenas ao relatório e evidências.

## Parte 1: Workflows Básicos

### Hello CI/CD (`hello.yml`)
Workflow disparado em qualquer push.
- **Evidência:** *[Insira aqui o link para a execução no GitHub Actions]*
- **Print:** *[Insira aqui o print do log "Hello CI/CD"]*

### Tests Workflow (`tests.yml`)
Workflow disparado em Pull Requests.
- **Evidência:** *[Insira link]*
- **Print:** *[Insira print do log "Rodando testes"]*

### Maven CI (`maven-ci.yml`)
Workflow de build real do projeto Java.
- **Evidência:** *[Insira link]*
- **Print:** *[Insira print do build Maven com sucesso]*

## Parte 2: Runners, Variáveis e Segurança

### Env Demo (`env-demo.yml`)
Uso de variável de ambiente `DEPLOY_ENV`.
- **Print:** *[Insira print do log mostrando "O ambiente configurado é: staging"]*

### Secret Demo (`secret-demo.yml`)
Uso seguro de secrets.
- **Print:** *[Insira print do log mostrando "API_KEY configurado"]*
> **Nota:** Para funcionar, você deve ir em `Settings > Secrets and variables > Actions` no seu repositório GitHub e criar um secret chamado `API_KEY`.

### Questão Teórica: Runners Hospedados vs Auto-hospedados

**Runners Hospedados pelo GitHub:**
- **Vantagens:** Manutenção zero (gerenciados pelo GitHub), ambiente limpo a cada execução, escalabilidade automática, cobrem a maioria dos SOs comuns (Ubuntu, Windows, macOS).
- **Desvantagens:** Limites de minutos gratuitos (custa dinheiro se exceder), hardware padrão (pode ser lento para builds muito pesados), fila de espera em planos gratuitos.

**Runners Auto-hospedados (Self-hosted):**
- **Vantagens:** Sem custo por minuto (usa sua própria infra), hardware customizável (pode usar máquinas super potentes), persistência de cache/dependências entre execuções (builds mais rápidos), acesso à rede interna da empresa (VPN, BDs locais).
- **Desvantagens:** Oneroso para manter (precisa gerenciar SO, segurança, atualizações), risco de segurança (se for um projeto público, PRs maliciosos podem comprometer a máquina), não escala "magicamente" sem configuração extra.

## Parte 3: Deploys e Estratégias

### Release Deploy (`release-deploy.yml`)
Disparado ao publicar uma release.
- **Print:** *[Insira print do log "Deploy realizado com sucesso"]*

### Matrix Strategy (`matrix-setup.yml`)
Rodando em múltiplas versões Java.
- **Print:** *[Insira print mostrando os dois jobs (17 e 21) rodando em paralelo]*

### Questão Teórica: Blue-Green vs Rolling Update

**Blue-Green Deployment:**
- **Como funciona:** Mantém dois ambientes idênticos: "Blue" (versão atual, rodando) e "Green" (nova versão). O deploy é feito no Green. Após testes, o roteador/load balancer troca todo o tráfego do Blue para o Green instantaneamente.
- **Cenário ideal:** Aplicações críticas onde não se tolera downtime ou mistura de versões (ex: mudança de esquema de banco de dados incompatível), facilidade de rollback instantâneo.

**Rolling Update:**
- **Como funciona:** Substitui as instâncias da versão antiga pela nova gradualmente (ex: de 10 servidores, atualiza 2, espera, atualiza mais 2...).
- **Cenário ideal:** Grandes clusters onde duplicar a infraestrutura (Blue-Green) seria muito caro; aplicações que suportam convivência entre versões (backward compatibility).

## Parte 4: Monitoramento e Logs

### Status Badge
O badge foi adicionado ao `README.md` principal.
- **Evidência:** Verifique o topo do arquivo README.md.

### Logs de Debug e Mascaramento
**Como mascarar dados sensíveis:**
No GitHub Actions, utiliza-se o comando de workflow `::add-mask::valor`. Qualquer output subsequente que contenha "valor" será substituído por `***` nos logs.
Exemplo no YAML:
```yaml
run: echo "::add-mask::${{ secrets.MINHA_SENHA }}"
```
Além disso, o GitHub mascara automaticamente secrets declarados na aba Settings quando usados via `${{ secrets... }}`.

## Parte 5: Workflow Completo

### Deploy Integrado (`deploy.yml`)
Workflow final que simula deploy condicional.
- **Print:** *[Insira print da execução final]*
