#!/bin/bash

# Script para deploy no Netlify

# Cores para mensagens
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Preparando deploy para Netlify...${NC}"

# Verificar se netlify-cli está instalado
if [ ! -d "node_modules/netlify-cli" ]; then
  echo -e "${BLUE}Netlify CLI não encontrado. Instalando...${NC}"
  npm install netlify-cli --save-dev
fi

# Definir o caminho para o executável do Netlify CLI
NETLIFY_CLI="./node_modules/.bin/netlify"

# Executar o build
echo -e "${BLUE}Executando build do projeto...${NC}"
node build.js

if [ $? -ne 0 ]; then
  echo -e "${RED}Falha no build. Abortando deploy.${NC}"
  exit 1
fi

# Verificar se o diretório public existe
if [ ! -d "public" ]; then
  echo -e "${RED}Diretório public não encontrado. Verifique o script de build.${NC}"
  exit 1
fi

# Verificar se o usuário está logado no Netlify
echo -e "${BLUE}Verificando autenticação com Netlify...${NC}"
$NETLIFY_CLI status

# Deploy para o Netlify
echo -e "${BLUE}Realizando deploy para Netlify...${NC}"
$NETLIFY_CLI deploy --prod --dir=public

if [ $? -eq 0 ]; then
  echo -e "${GREEN}Deploy para Netlify realizado com sucesso!${NC}"
else
  echo -e "${RED}Falha no deploy para Netlify.${NC}"
  exit 1
fi 