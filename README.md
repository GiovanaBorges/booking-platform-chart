# 📦 Booking Platform – Helm Chart (GitOps Ready)

Este repositório contém o Helm Chart raiz da Booking Platform, responsável por orquestrar múltiplos serviços e dependências de infraestrutura utilizando Kubernetes + Helm, seguindo boas práticas de GitOps.

O deploy é feito via ArgoCD, enquanto o GitHub Actions é usado apenas para CI (validação do chart).

## 🧠 Visão Geral da Arquitetura

A plataforma é composta por:

Serviços próprios (subcharts)

bookings – API principal de reservas

notification – serviço de notificações

frontend – aplicação frontend (OAuth client)

Dependências (charts externos)

Keycloak – autenticação e autorização

RabbitMQ – mensageria

Redis – cache

PostgreSQL – banco de dados (Keycloak)

## Todos os serviços são gerenciados por um chart raiz (booking-platform) que centraliza configurações por ambiente.

## 📂 Estrutura do Projeto
booking-platform/  
├── Chart.yaml      # Chart raiz (orquestrador)   
├── Chart.lock   
├── charts/     # Subcharts (serviços e dependências)   
│   ├── bookings/  
│   ├── notification/  
│   ├── front/  
│   ├── shared-config/  # ConfigMaps e Secrets      compartilhados   
│   ├── keycloak-*.tgz  
│   ├── rabbitmq-*.tgz  
│   └── redis-*.tgz  
├── templates/  
│   ├── _helpers.tpl  
│   └── messaging-contract.yaml  
├── values.yaml               # valores base  
├── values-global.yaml        # valores compartilhados  
├── values-dev.yaml       # configuração do ambiente dev  
├── values-dev-secret.yaml  # secrets (NÃO usado no CI)  
└── README.md  

## ⚙️ Gerenciamento de Configuração (Helm)
Chart raiz

O Chart.yaml define as dependências e não contém configuração dinâmica.

Values por ambiente

values.yaml – defaults

values-global.yaml – configurações comuns

values-dev.yaml – ambiente de desenvolvimento

values-dev-secret.yaml – secrets usados apenas no cluster

## 📌 Secrets não entram no CI.

## 🔐 Secrets

Os secrets são consumidos pelos pods via envFrom.secretRef.

Eles devem existir no cluster antes do deploy (manual ou GitOps).

## Exemplo:

kubectl create secret generic keycloak-credentials \
  -n dev-environment \
  --from-literal=KC_DB_PASSWORD=123


O pipeline de CI não valida secrets, apenas a renderização do chart.

## 🔁 CI – GitHub Actions (Helm Chart CI)

O CI valida a qualidade e consistência do Helm Chart, sem aplicar nada no cluster.

## O que o CI faz ? 

- Atualiza dependências

- Executa helm lint

- Renderiza templates com valores reais de ambiente

## O que o CI não faz

- Não deploya

- Não usa kubectl

- Não acessa cluster

- Não consome secrets

Se isso passar, o chart está apto para ser aplicado pelo ArgoCD.

## 🚀 CD – ArgoCD (GitOps)

 O deploy é feito exclusivamente pelo ArgoCD.

## Fluxo:

git push
   ↓
GitHub Actions (CI)
   ↓
merge main
   ↓
ArgoCD detecta mudanças
   ↓
Helm renderiza
   ↓
Kubernetes aplica


O ArgoCD aponta para este repositório e utiliza os arquivos de values por ambiente.

## 🧪 Deploy Local (cluster próprio)
helm dependency update

helm upgrade --install booking-platform . \
  -n dev-environment \
  -f values.yaml \
  -f values-global.yaml \
  -f values-dev.yaml \
  -f values-dev-secret.yaml

## 📌 Boas Práticas Adotadas

## GitOps com ArgoCD

- CI desacoplado de deploy

- Charts próprios desacoplados do chart raiz

- Secrets fora do pipeline

- Namespace dinâmico via Helm

- Infra como código (Helm)

## 🎯 Objetivo do Projeto

Este projeto foi criado com foco em:

- estudo avançado de Helm

- práticas reais de CI/CD

- GitOps com ArgoCD

- arquitetura próxima à usada em ambientes profissionais