# Script de Automação para Windows (PowerShell)
$ErrorActionPreference = "Stop"

function Print-Msg {
    param([string]$msg)
    Write-Host "`n>>> $msg" -ForegroundColor Cyan
}

function Print-Error {
    param([string]$msg)
    Write-Host "`n!!! $msg" -ForegroundColor Red
}

# Verificação de dependências
Print-Msg "Verificando dependências..."
if (-not (Get-Command java -ErrorAction SilentlyContinue)) { Print-Error "Java não encontrado."; exit 1 }
if (-not (Get-Command mvn -ErrorAction SilentlyContinue)) { Print-Error "Maven não encontrado."; exit 1 }
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) { Print-Error "Docker não encontrado."; exit 1 }
if (-not (Get-Command kubectl -ErrorAction SilentlyContinue)) { Print-Error "Kubectl não encontrado."; exit 1 }
if (-not (Get-Command minikube -ErrorAction SilentlyContinue)) { Print-Error "Minikube não encontrado."; exit 1 }

# ==========================================
# TP1 - BUILD E DOCKER
# ==========================================
Print-Msg "Iniciando TP1..."

Set-Location TP1

Print-Msg "Compilando projeto Java..."
mvn clean package

Print-Msg "Construindo imagem Docker (devcalc-api:1.0.0)..."
Print-Msg "Configurando ambiente Docker para usar o Minikube..."
# Configuração do Env do Minikube no PowerShell
& minikube -p minikube docker-env --shell powershell | Invoke-Expression

docker build -f Dockerfile -t devcalc-api:1.0.0 .

Set-Location ..

# ==========================================
# TP2 - KUBERNETES DEPLOYMENT
# ==========================================
Print-Msg "Iniciando TP2..."

Print-Msg "Criando Namespace tp2..."
kubectl apply -f TP2/00-namespace.yaml

Print-Msg "Aplicando manifestos Kubernetes..."
kubectl apply -f TP2/01-pod.yaml
kubectl apply -f TP2/02-deployment.yaml
kubectl apply -f TP2/03-service-clusterip.yaml
kubectl apply -f TP2/04-service-nodeport.yaml

Print-Msg "Aguardando Pods ficarem prontos..."
kubectl wait --namespace tp2 `
  --for=condition=ready pod `
  --selector=app=devcalc `
  --timeout=120s

Print-Msg "Status dos Pods:"
kubectl get pods -n tp2

Print-Msg "Escalonando deployment para 3 réplicas..."
kubectl scale deployment devcalc-deployment --replicas=3 -n tp2

Print-Msg "Aguardando novas réplicas..."
kubectl wait --namespace tp2 `
  --for=condition=ready pod `
  --selector=app=devcalc `
  --timeout=60s

kubectl get deployment devcalc-deployment -n tp2

# Testes
try {
    $minikubeIp = minikube ip
    $url = "http://$minikubeIp:30003/add?a=10&b=20"
    Print-Msg "Testando endpoint: $url"
    Invoke-RestMethod -Uri $url -Method Get
} catch {
    Write-Host "Erro ao testar endpoint. Verifique a conectividade." -ForegroundColor Yellow
}

Print-Msg ">>> TP1 e TP2 CONCLUÍDOS! <<<"

# ==========================================
# TP3 - GITHUB ACTIONS
# ==========================================
Print-Msg "Sobre o TP3 (GitHub Actions):"
Write-Host "O TP3 roda nos servidores do GitHub."
Write-Host "1. Faça push deste repositório."
Write-Host "2. Acesse a aba 'Actions' no GitHub."
Write-Host "Consulte TP3/README.md para mais detalhes."

Print-Msg "Para limpar: kubectl delete namespace tp2"
