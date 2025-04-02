# Configurações de Deploy para Plataformas em Nuvem

## Descrição

Este PR adiciona arquivos de configuração para facilitar o deploy da aplicação em diversas plataformas de hospedagem gratuitas, incluindo Render, Vercel e Netlify.

## Alterações Realizadas

- **render.yaml**: Configuração para deploy completo (backend+frontend) no Render
  - Serviço backend Node.js com variáveis de ambiente seguras
  - Serviço frontend estático com redirecionamentos para SPA
  - Configuração de banco de dados para armazenar variáveis de ambiente sensíveis
  - Redirecionamentos para melhor experiência do usuário

- **vercel.json**: Configuração para deploy do frontend no Vercel
  - Configuração de build específica para Angular
  - Redirecionamentos para SPA
  - Configuração de variáveis de ambiente
  - Integração com GitHub

- **netlify.toml**: Configuração para deploy do frontend no Netlify
  - Configuração de build e publicação
  - Redirecionamentos para SPA
  - Headers de segurança
  - Variáveis de ambiente

## Benefícios

- Deploy simplificado com um clique nas plataformas suportadas
- Configurações otimizadas para melhor desempenho
- Headers de segurança adequados
- Separação clara de backend e frontend
- Flexibilidade para escolher a plataforma mais adequada

## Como Testar

1. Clone o repositório
2. Para testar no Render: crie uma conta no Render e importe o repositório
3. Para testar no Vercel: crie uma conta no Vercel e importe o repositório
4. Para testar no Netlify: crie uma conta no Netlify e importe o repositório

Todas as plataformas detectarão automaticamente as configurações e realizarão o deploy adequadamente. 