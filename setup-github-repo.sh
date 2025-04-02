#!/bin/bash

# Script para configurar e enviar o projeto para um novo repositório GitHub
# chamado "kanban-deploy"

# Cores para mensagens
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Configurando o repositório kanban-deploy...${NC}"

# Verificar se git está instalado
if ! [ -x "$(command -v git)" ]; then
  echo -e "${RED}Erro: git não está instalado.${NC}" >&2
  exit 1
fi

# Inicializar repositório git se não existir
if [ ! -d .git ]; then
  echo -e "${BLUE}Inicializando repositório git...${NC}"
  git init
  if [ $? -ne 0 ]; then
    echo -e "${RED}Falha ao inicializar o repositório git.${NC}" >&2
    exit 1
  fi
fi

# Verificar se já existe uma origem remota
REMOTE_EXISTS=$(git remote -v | grep -c origin)
if [ $REMOTE_EXISTS -ne 0 ]; then
  echo -e "${BLUE}Removendo origem remota existente...${NC}"
  git remote remove origin
fi

# Solicitar o nome de usuário do GitHub
echo -e "${BLUE}Digite seu nome de usuário do GitHub:${NC}"
read GITHUB_USERNAME

# Criar o novo repositório remoto
echo -e "${BLUE}Adicionando novo repositório remoto...${NC}"
git remote add origin https://github.com/$GITHUB_USERNAME/kanban-deploy.git

# Adicionando todos os arquivos
echo -e "${BLUE}Adicionando arquivos...${NC}"
git add .

# Commit inicial
echo -e "${BLUE}Realizando commit inicial...${NC}"
git commit -m "Configuração inicial do projeto kanban-deploy"

# Criar a branch main (caso ainda não exista)
echo -e "${BLUE}Configurando branch main...${NC}"
git branch -M main

# Enviar para o GitHub
echo -e "${BLUE}Enviando para o GitHub...${NC}"
echo -e "${GREEN}Por favor, crie manualmente o repositório kanban-deploy no GitHub antes de continuar.${NC}"
echo -e "${BLUE}Pressione ENTER quando o repositório estiver criado...${NC}"
read

echo -e "${BLUE}Enviando código para GitHub...${NC}"
git push -u origin main

if [ $? -eq 0 ]; then
  echo -e "${GREEN}Configuração concluída com sucesso!${NC}"
  echo -e "${GREEN}Repositório disponível em: https://github.com/$GITHUB_USERNAME/kanban-deploy${NC}"
  echo -e "${BLUE}Próximos passos:${NC}"
  echo -e "1. Configure a implantação no Render para o backend"
  echo -e "2. Configure a implantação na Vercel para o frontend"
else
  echo -e "${RED}Falha ao enviar para o GitHub. Verifique suas credenciais e tente novamente.${NC}"
fi 