#!/usr/bin/env node

/**
 * Script para construir o projeto Angular e preparar para deploy
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

console.log('Iniciando processo de build...');

// Detectar estrutura de diretórios
const isRootDir = fs.existsSync(path.join(process.cwd(), 'frontend'));
const rootDir = isRootDir ? process.cwd() : path.join(process.cwd(), '..');
const frontendDir = isRootDir ? path.join(rootDir, 'frontend') : process.cwd();
const publicDir = path.join(rootDir, 'public');

console.log(`Diretório raiz: ${rootDir}`);
console.log(`Diretório frontend: ${frontendDir}`);
console.log(`Diretório public: ${publicDir}`);

// Listar conteúdo dos diretórios para debugging
console.log('Conteúdo do diretório atual:');
console.log(fs.readdirSync(process.cwd()));

// Instalar dependências
try {
  console.log('Instalando dependências...');
  process.chdir(frontendDir);
  execSync('npm install', { stdio: 'inherit' });
} catch (error) {
  console.error('Erro ao instalar dependências:', error.message);
  process.exit(1);
}

// Build do frontend
try {
  console.log('Executando build do frontend...');
  execSync('npm run build:prod', { stdio: 'inherit' });
} catch (error) {
  console.error('Erro ao executar build:', error.message);
  process.exit(1);
}

// Função recursiva para copiar diretórios
function copyDirRecursive(sourceDir, targetDir) {
  // Criar diretório de destino se não existir
  if (!fs.existsSync(targetDir)) {
    fs.mkdirSync(targetDir, { recursive: true });
  }

  // Ler arquivos e diretórios da fonte
  const items = fs.readdirSync(sourceDir);

  // Copiar cada item
  for (const item of items) {
    const sourcePath = path.join(sourceDir, item);
    const targetPath = path.join(targetDir, item);

    const stats = fs.statSync(sourcePath);
    if (stats.isDirectory()) {
      // Recursivamente copiar subdiretórios
      copyDirRecursive(sourcePath, targetPath);
    } else {
      // Copiar arquivos
      fs.copyFileSync(sourcePath, targetPath);
      console.log(`Copiado: ${targetPath}`);
    }
  }
}

// Verificar se o diretório de build existe
const angularBuildDir = path.join(frontendDir, 'dist', 'kanban-board');
const angularBrowserDir = path.join(angularBuildDir, 'browser');

if (fs.existsSync(angularBuildDir)) {
  console.log(`✓ Diretório ${angularBuildDir} existe`);
  
  // Verificar se o diretório browser existe (Angular 19+)
  let sourceBuildDir = angularBuildDir;
  if (fs.existsSync(angularBrowserDir)) {
    console.log(`✓ Diretório browser detectado (Angular 19+)`);
    sourceBuildDir = angularBrowserDir;
  }
  
  // Listar arquivos no diretório
  const buildFiles = fs.readdirSync(sourceBuildDir);
  console.log(`Arquivos em ${sourceBuildDir}:`, buildFiles);
  
  // Verificar se index.html existe
  if (buildFiles.includes('index.html')) {
    console.log('✓ index.html encontrado no diretório de build');
  } else {
    console.error('✗ index.html NÃO encontrado no diretório de build!');
  }
  
  // Criar diretório public
  if (!fs.existsSync(publicDir)) {
    console.log('Criando diretório public...');
    fs.mkdirSync(publicDir, { recursive: true });
  }
  
  // Copiar arquivos para public
  console.log(`Copiando conteúdo de ${sourceBuildDir} para ${publicDir}...`);
  copyDirRecursive(sourceBuildDir, publicDir);
  
  // Verificar se a cópia foi bem-sucedida
  if (fs.existsSync(path.join(publicDir, 'index.html'))) {
    console.log('✓ Cópia concluída com sucesso');
    
    // Listar arquivos após a cópia
    const publicFiles = fs.readdirSync(publicDir);
    console.log(`Conteúdo final de ${publicDir}:`, publicFiles);
  } else {
    console.error('✗ Falha ao copiar arquivos! O arquivo index.html não foi encontrado no diretório public');
    process.exit(1);
  }
} else {
  console.error(`✗ Diretório ${angularBuildDir} NÃO existe!`);
  process.exit(1);
}

console.log('Build concluída com sucesso!'); 