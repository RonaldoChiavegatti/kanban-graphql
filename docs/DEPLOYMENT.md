# Guia de Deploy - Kanban Fullstack

Este guia descreve como fazer o deploy do projeto Kanban Fullstack usando serviços gratuitos.

## Pré-requisitos

- Conta no GitHub
- Conta no Firebase
- Conta no Vercel, Netlify ou similar para o frontend
- Conta no Render, Railway ou similar para o backend

## Configuração do Firebase

1. Acesse o [Console do Firebase](https://console.firebase.google.com/)
2. Crie um novo projeto
3. Configure o Firestore Database:
   - Acesse "Firestore Database" no menu lateral
   - Clique em "Criar banco de dados"
   - Escolha o modo de inicialização (produção ou teste)
   - Selecione a região mais próxima do seu público-alvo
4. Configure a Autenticação:
   - Acesse "Authentication" no menu lateral
   - Clique em "Configurar método de login"
   - Habilite os métodos desejados (email/senha, Google, etc.)
5. Obtenha as credenciais de configuração:
   - Acesse "Configurações do Projeto" (ícone de engrenagem)
   - Vá para a guia "Geral"
   - Role até "Seus aplicativos" e clique em "Web"
   - Siga as instruções para registrar seu app
   - Copie as configurações fornecidas (serão usadas no frontend e backend)

## Deploy do Backend

### Usando Render (Gratuito)

1. Faça login ou crie uma conta em [Render](https://render.com/)
2. Conecte sua conta GitHub
3. Clique em "New Web Service"
4. Selecione o repositório com seu projeto
5. Configure o serviço:
   - **Nome**: kanban-backend
   - **Ambiente**: Node
   - **Diretório de Build**: backend
   - **Comando de Build**: `npm install`
   - **Comando de Start**: `npm start`
6. Configure as variáveis de ambiente:
   - `PORT`: 4000 (ou sua porta preferida)
   - `NODE_ENV`: production
   - Adicione as credenciais do Firebase (FIREBASE_API_KEY, FIREBASE_AUTH_DOMAIN, etc.)
7. Clique em "Create Web Service"

### Usando Railway (Gratuito com limitações)

1. Faça login ou crie uma conta em [Railway](https://railway.app/)
2. Clique em "New Project" e selecione "Deploy from GitHub repo"
3. Selecione seu repositório
4. Configure o serviço para apontar para o diretório do backend
5. Adicione as variáveis de ambiente necessárias
6. Deploy irá começar automaticamente

## Deploy do Frontend

### Usando Vercel (Gratuito)

1. Faça login ou crie uma conta em [Vercel](https://vercel.com/)
2. Clique em "New Project"
3. Importe o repositório do GitHub
4. Configure o projeto:
   - **Framework Preset**: Angular
   - **Root Directory**: frontend
   - **Build Command**: `npm run build`
   - **Output Directory**: dist
5. Configure as variáveis de ambiente:
   - `ANGULAR_APP_API_URL`: URL do seu backend
   - Adicione as credenciais do Firebase necessárias
6. Clique em "Deploy"

### Usando Netlify (Gratuito)

1. Faça login ou crie uma conta em [Netlify](https://netlify.com/)
2. Clique em "New site from Git"
3. Selecione "GitHub" como provedor Git
4. Escolha seu repositório
5. Configure o build:
   - **Base directory**: frontend
   - **Build command**: `npm run build`
   - **Publish directory**: dist
6. Configure as variáveis de ambiente
7. Clique em "Deploy site"

## Vinculando Frontend e Backend

Após o deploy do backend, obtenha a URL gerada e atualize a variável de ambiente `ANGULAR_APP_API_URL` no projeto frontend, então faça o redeploy.

## Testando a Aplicação

1. Acesse a URL do frontend gerada pelo Vercel/Netlify
2. Verifique se a comunicação com o backend está funcionando corretamente
3. Teste todas as funcionalidades da aplicação

## Considerações de Escalabilidade

- Os planos gratuitos têm limitações de recursos e podem não ser adequados para produção com muitos usuários
- Considere migrar para planos pagos quando a aplicação crescer
- O Firebase tem limites de uso gratuito, verifique a [documentação do Firebase](https://firebase.google.com/pricing) para mais detalhes 