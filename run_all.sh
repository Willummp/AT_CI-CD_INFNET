#!/bin/bash
set -e

# Função para imprimir mensagens coloridas
print_msg() {
    echo -e "\n\033[1;34m>>> $1\033[0m"
}

print_error() {
    echo -e "\n\033[1;31m!!! $1\033[0m"
}

# Verificação de dependências
print_msg "Verificando dependências..."
command -v java >/dev/null 2>&1 || { print_error "Java não encontrado."; exit 1; }
command -v mvn >/dev/null 2>&1 || { print_error "Maven não encontrado."; exit 1; }
command -v docker >/dev/null 2>&1 || { print_error "Docker não encontrado."; exit 1; }
command -v kubectl >/dev/null 2>&1 || { print_error "Kubectl não encontrado."; exit 1; }
command -v minikube >/dev/null 2>&1 || { print_error "Minikube não encontrado."; exit 1; }

# ==========================================
# TP1 - BUILD E DOCKER
# ==========================================
print_msg "Iniciando TP1..."

cd TP1

print_msg "Compilando projeto Java..."
mvn clean package

print_msg "Construindo imagem Docker (devcalc-api:1.0.0)..."
# Usando o Docker daemon do Minikube para evitar ter que fazer 'minikube image load' depois
# Se o usuário preferir não usar, pode comentar a linha do eval
print_msg "Configurando ambiente Docker para usar o Minikube..."
eval $(minikube docker-env)

docker build -f Dockerfile -t devcalc-api:1.0.0 .

# Voltando para raiz
cd ..

# ==========================================
# TP2 - KUBERNETES DEPLOYMENT
# ==========================================
print_msg "Iniciando TP2..."

# Garante que o namespace existe
print_msg "Criando Namespace tp2..."
kubectl apply -f TP2/00-namespace.yaml

# Aplica configurações
print_msg "Aplicando manifestos Kubernetes..."
kubectl apply -f TP2/01-pod.yaml
kubectl apply -f TP2/02-deployment.yaml
kubectl apply -f TP2/03-service-clusterip.yaml
kubectl apply -f TP2/04-service-nodeport.yaml

print_msg "Aguardando Pods ficarem prontos (pode demorar um pouco)..."
kubectl wait --namespace tp2 \
  --for=condition=ready pod \
  --selector=app=devcalc \
  --timeout=120s

print_msg "Status dos Pods:"
kubectl get pods -n tp2

# Escalonamento
print_msg "Escalonando deployment para 3 réplicas..."
kubectl scale deployment devcalc-deployment --replicas=3 -n tp2

print_msg "Aguardando novas réplicas..."
kubectl wait --namespace tp2 \
  --for=condition=ready pod \
  --selector=app=devcalc \
  --timeout=60s

kubectl get deployment devcalc-deployment -n tp2

# Testes de Conectividade
print_msg "Obtendo URL do serviço NodePort..."
MINIKUBE_IP=$(minikube ip)
NODE_PORT=30003
URL="http://$MINIKUBE_IP:$NODE_PORT/add?a=10&b=20"

print_msg "Testando endpoint: $URL"
curl -s "$URL" && echo ""

print_msg ">>> TP1 e TP2 CONCLUÍDOS! <<<"

# ==========================================
# TP3 - GITHUB ACTIONS (INSTRUÇÕES)
# ==========================================
print_msg "Sobre o TP3 (GitHub Actions):"
echo "O TP3 consiste em workflows de CI/CD que rodam nos servidores do GitHub."
echo "Para executar o TP3:"
echo "1. Faça commit e push deste repositório para o GitHub."
echo "2. Acesse a aba 'Actions' no seu repositório Git."
echo "3. Confirme que os workflows (Hello, Maven, etc.) foram disparados."
echo "4. Consulte TP3/README.md para verificar os detalhes."

print_msg "Lembre-se de tirar os prints solicitados em cada TP."
print_msg "Para limpar o ambiente K8s depois: kubectl delete namespace tp2"
