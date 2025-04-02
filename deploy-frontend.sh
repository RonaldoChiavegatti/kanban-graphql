#!/bin/bash

# Script para implantar apenas as alterações do frontend

# Cores para mensagens
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Implantando alterações do frontend...${NC}"

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

# Adicionar apenas os arquivos do frontend modificados
echo -e "${BLUE}Adicionando arquivos do frontend modificados...${NC}"
git add frontend/src/environments/environment.prod.ts

# Commit das alterações
echo -e "${BLUE}Realizando commit das alterações...${NC}"
git commit -m "Atualizar configuração do frontend para deploy local"

# Enviar para o GitHub
echo -e "${BLUE}Enviando alterações para o GitHub...${NC}"
git push

if [ $? -eq 0 ]; then
  echo -e "${GREEN}Alterações do frontend implantadas com sucesso!${NC}"
else
  echo -e "${RED}Falha ao enviar alterações para o GitHub. Verifique suas credenciais e tente novamente.${NC}"
fi 