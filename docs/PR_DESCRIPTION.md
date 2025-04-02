# Adição de Diagramas UML e Documentação de Deploy

## Descrição

Este PR adiciona diagramas UML completos da aplicação Kanban, utilizando PlantUML, e também um guia detalhado para deploy da aplicação em ambientes gratuitos.

## Alterações Realizadas

- **Diagramas UML**:
  - Diagrama de Classes: Representa a estrutura e relacionamentos das entidades principais
  - Diagrama de Componentes: Mostra a arquitetura do sistema frontend-backend-firebase
  - Diagrama de Casos de Uso: Descreve as funcionalidades do sistema do ponto de vista do usuário
  - Diagrama de Sequência: Demonstra o fluxo de movimentação de cartões no Kanban
  - Diagrama de Implantação: Mostra a estrutura de deploy no ambiente de nuvem

- **Documentação de Deploy**:
  - Guia detalhado para deploy do frontend em Vercel/Netlify
  - Guia para deploy do backend em Render/Railway
  - Configuração do Firebase para armazenamento de dados
  - Configuração de variáveis de ambiente necessárias

- **Scripts**:
  - Script `generate-diagrams.sh` para gerar imagens PNG a partir dos arquivos PlantUML

## Benefícios

- Melhor compreensão da arquitetura do sistema
- Documentação técnica clara e visual
- Facilidade para novos desenvolvedores entenderem o sistema
- Guia prático para implantação do projeto em ambientes reais

## Como Testar

1. Visualize os diagramas PlantUML em um editor compatível ou use as imagens PNG geradas
2. Execute o script `docs/generate-diagrams.sh` para regenerar as imagens dos diagramas
3. Siga o guia de deploy para verificar se as instruções estão claras e completas

## Capturas de Tela

Os diagramas gerados podem ser encontrados na pasta `docs/diagrams/png/`. 