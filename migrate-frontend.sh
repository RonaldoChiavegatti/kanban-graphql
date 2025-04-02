#!/bin/bash

# Script para migrar os arquivos do frontend para o repositório principal
# eliminar o controle Git do frontend e fazer push do código completo

# Cores para mensagens
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Migrando os arquivos do frontend para o repositório principal...${NC}"

# Verificar se git está instalado
if ! [ -x "$(command -v git)" ]; then
  echo -e "${RED}Erro: git não está instalado.${NC}" >&2
  exit 1
fi

# Backup dos arquivos importantes do frontend
echo -e "${BLUE}Fazendo backup dos arquivos do frontend...${NC}"
TEMP_DIR=$(mktemp -d)
cp -r frontend/* $TEMP_DIR/ 2>/dev/null || :

# Copiar arquivos ocultos se existirem
if [ -d frontend/.angular ]; then
  cp -r frontend/.angular $TEMP_DIR/
fi

if [ -d frontend/.vscode ]; then
  cp -r frontend/.vscode $TEMP_DIR/
fi

if [ -f frontend/.editorconfig ]; then
  cp frontend/.editorconfig $TEMP_DIR/
fi

if [ -f frontend/.env ]; then
  cp frontend/.env $TEMP_DIR/
fi

if [ -f frontend/.env.example ]; then
  cp frontend/.env.example $TEMP_DIR/
fi

if [ -f frontend/.eslintrc.json ]; then
  cp frontend/.eslintrc.json $TEMP_DIR/
fi

if [ -f frontend/.gitignore ]; then
  cp frontend/.gitignore $TEMP_DIR/
fi

# Remover referências a submódulos
echo -e "${BLUE}Removendo referências a submódulos...${NC}"
git rm --cached frontend || true

# Remover o diretório frontend
echo -e "${BLUE}Removendo o diretório frontend atual...${NC}"
rm -rf frontend

# Recriar o diretório frontend
echo -e "${BLUE}Recriando o diretório frontend...${NC}"
mkdir -p frontend

# Copiar os arquivos de volta
echo -e "${BLUE}Copiando os arquivos de volta...${NC}"
cp -r $TEMP_DIR/* frontend/ 2>/dev/null || :
cp -a $TEMP_DIR/.[^.]* frontend/ 2>/dev/null || :

# Remover o diretório temporário
rm -rf $TEMP_DIR

# Criar um arquivo .gitkeep para garantir que diretórios vazios sejam incluídos
touch frontend/src/.gitkeep

# Adicionar os arquivos ao git
echo -e "${BLUE}Adicionando os arquivos ao git...${NC}"
git add frontend

# Commit das alterações
echo -e "${BLUE}Realizando commit das alterações...${NC}"
git commit -m "Migrar arquivos do frontend para o repositório principal"

# Enviar para o GitHub
echo -e "${BLUE}Enviando código para o GitHub...${NC}"
git push

if [ $? -eq 0 ]; then
  echo -e "${GREEN}Migração do frontend concluída com sucesso!${NC}"
else
  echo -e "${RED}Falha ao enviar código para o GitHub. Verifique suas credenciais e tente novamente.${NC}"
fi 