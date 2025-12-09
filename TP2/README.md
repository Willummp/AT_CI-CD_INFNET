# TP2 - Orquestração com Kubernetes

Este diretório contém os manifestos para implantar a aplicação DevCalc (do TP1) em um cluster Kubernetes.

## Arquivos de Configuração

- `00-namespace.yaml`: Definição do Namespace.
- `01-pod.yaml`: Definição do Pod Multi-container (Nginx + Sidecar).
- `02-deployment.yaml`: Deployment da API DevCalc.
- `03-service-clusterip.yaml`: Serviço interno.
- `04-service-nodeport.yaml`: Serviço externo.

## Instruções de Execução (Correção)

Certifique-se de que o `kubectl` está configurado para o seu cluster.

### 1. Pré-requisito: Imagem Docker
**Importante:** O Kubernetes precisa ter acesso à imagem `devcalc-api:1.0.0` criada no TP1.

Se estiver utilizando **Minikube**, carregue a imagem antes de aplicar os manifestos:
```bash
minikube image load devcalc-api:1.0.0
```
*Se estiver usando Kind:* `kind load docker-image devcalc-api:1.0.0` --name <cluster-name>
*Se estiver usando Docker Desktop:* A imagem local já deve estar acessível.

### 2. Implantar a Aplicação

Aplique todos os manifestos na ordem correta:

```bash
# Entrar na pasta do TP (se já não estiver)
cd TP2

# Aplicar configurações
kubectl apply -f .
```

### 3. Validação e Evidências

#### Verificar Pods e Namespace
```bash
kubectl get all -n tp2
```

#### Validar Sidecar Pattern (Pod Multi-container)
Para verificar se o container busybox está acessando o nginx (Item 1 do enunciado):
```bash
kubectl logs multi-container-pod -c busybox-sidecar -n tp2
```
*Esperado: Logs mostrando a data e o HTML do Nginx a cada 10s.*

#### Validar Escalonamento (Deployment)
O deployment inicia com 2 réplicas. Para escalar para 3 (Item 2 do enunciado):
```bash
kubectl scale deployment devcalc-deployment --replicas=3 -n tp2
kubectl get deployment devcalc-deployment -n tp2
```

#### Testar Acesso Externo (Service NodePort)
O serviço expõe a aplicação na porta **30003** do nó.

**Em Minikube:**
Você precisa do IP do Minikube:
```bash
minikube ip
# Exemplo de retorno: 192.168.49.2
```
Acesse no navegador: `http://<MINIKUBE-IP>:30003/add?a=50&b=50`

**Em Docker Desktop / Host Local:**
Acesse: `http://localhost:30003/add?a=50&b=50` (pode exigir configuration de tunnel dependendo da versão).
