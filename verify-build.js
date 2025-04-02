#!/usr/bin/env node

/**
 * Script para verificar se os arquivos de build foram gerados corretamente
 * e copiados para o diretório public
 */

const fs = require('fs');
const path = require('path');

console.log('Verificando arquivos de build...');

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

// Verificar se o diretório frontend/dist/kanban-board existe
const angularBuildDir = path.join(__dirname, 'frontend', 'dist', 'kanban-board');
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
} else {
  console.error(`✗ Diretório ${angularBuildDir} NÃO existe!`);
  process.exit(1);
}

// Verificar se o diretório public existe e criar se não existir
const publicDir = path.join(__dirname, 'public');
if (!fs.existsSync(publicDir)) {
  console.log('Criando diretório public...');
  fs.mkdirSync(publicDir, { recursive: true });
}

// Determinar o diretório de origem correto (com ou sem browser)
let sourceBuildDir = angularBuildDir;
if (fs.existsSync(angularBrowserDir)) {
  sourceBuildDir = angularBrowserDir;
}

// Copiar todos os arquivos e diretórios do build para public
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

console.log('Verificação de build concluída com sucesso!'); 