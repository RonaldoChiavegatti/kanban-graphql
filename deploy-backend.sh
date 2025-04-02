#!/bin/bash

# Script para implantar apenas as alterações do backend

# Cores para mensagens
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Implantando alterações do backend...${NC}"

# Verificar se git está instalado
if ! [ -x "$(command -v git)" ]; then
  echo -e "${RED}Erro: git não está instalado.${NC}" >&2
  exit 1
fi

# Verificar se existe um diretório .git
if [ ! -d .git ]; then
  echo -e "${RED}Erro: Este diretório não é um repositório git.${NC}" >&2
  exit 1
fi

# Adicionar apenas os arquivos do backend modificados
echo -e "${BLUE}Adicionando arquivos do backend modificados...${NC}"
git add backend/src/index.ts
git add backend/src/middleware/security.middleware.ts

# Commit das alterações
echo -e "${BLUE}Realizando commit das alterações...${NC}"
git commit -m "Corrigir configuração do Apollo Server e CORS para o playground"

# Enviar para o GitHub
echo -e "${BLUE}Enviando alterações para o GitHub...${NC}"
git push

if [ $? -eq 0 ]; then
  echo -e "${GREEN}Alterações do backend implantadas com sucesso!${NC}"
  echo -e "${BLUE}O Render deve detectar automaticamente as alterações e iniciar um novo deploy.${NC}"
  echo -e "${BLUE}Aguarde alguns minutos e acesse novamente a URL do backend para verificar se o playground está disponível.${NC}"
else
  echo -e "${RED}Falha ao enviar alterações para o GitHub. Verifique suas credenciais e tente novamente.${NC}"
fi 