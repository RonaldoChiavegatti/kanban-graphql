# Deploy no Netlify

Este documento detalha os passos necessários para fazer deploy deste projeto Angular no Netlify.

## Pré-requisitos

- Node.js instalado (versão recomendada: 20.x ou superior)
- npm instalado
- Git (para sincronizar com o repositório, se necessário)

## Opção 1: Deploy Automatizado via GitHub

1. Faça push do seu código para um repositório GitHub
2. Acesse [Netlify](https://app.netlify.com/) e faça login
3. Clique em "Add new site" > "Import an existing project"
4. Selecione GitHub como provedor e autorize o Netlify
5. Selecione o repositório do projeto
6. Configure os seguintes parâmetros:
   - Branch to deploy: `main` (ou sua branch principal)
   - Base directory: `.` (raiz do projeto)
   - Build command: `node build.js`
   - Publish directory: `public`
7. Clique em "Deploy site"

## Opção 2: Deploy Manual via CLI

1. Instale as dependências necessárias:
   ```bash
   npm install
   npm install netlify-cli --save-dev
   ```

2. Execute o script de build para gerar os arquivos de produção:
   ```bash
   node build.js
   ```

3. Login no Netlify CLI:
   ```bash
   npx netlify login
   ```

4. Inicie o deploy:
   ```bash
   npx netlify deploy --prod --dir=public
   ```

5. Alternativamente, use o script de deploy fornecido:
   ```bash
   ./deploy-netlify.sh
   ```

## Opção 3: Deploy via Drag and Drop

1. Execute o script de build para gerar os arquivos:
   ```bash
   node build.js
   ```

2. Acesse [Netlify](https://app.netlify.com/) e faça login
3. Arraste a pasta `public` para a área designada no painel do Netlify

## Configurações importantes

O projeto já inclui as seguintes configurações para garantir que o aplicativo funcione corretamente no Netlify:

- **netlify.toml**: Contém as configurações de build e regras de redirecionamento
- **_redirects**: Configura o redirecionamento para SPA (Single Page Applications)
- **_headers**: Define os cabeçalhos HTTP para segurança

## Variáveis de Ambiente

As seguintes variáveis de ambiente podem ser configuradas no painel do Netlify:

- `ANGULAR_APP_API_URL`: URL da API de backend (padrão: https://kanban-backend.onrender.com)
- `FIREBASE_API_KEY`: (se aplicável)
- `FIREBASE_AUTH_DOMAIN`: (se aplicável)
- `FIREBASE_PROJECT_ID`: (se aplicável)
- Outras variáveis relacionadas ao Firebase, se estiver sendo utilizado

## Solução de Problemas

- **Erros de build**: Verifique o log de build no painel do Netlify
- **Páginas 404 após navegação**: Verifique se as regras de redirecionamento estão configuradas corretamente
- **API não funciona**: Verifique as configurações CORS no backend e se a URL da API está correta

## Recursos Adicionais

- [Documentação oficial do Netlify](https://docs.netlify.com/)
- [Deploying Angular apps to Netlify](https://www.netlify.com/blog/2019/09/23/first-steps-using-netlify-angular/) 