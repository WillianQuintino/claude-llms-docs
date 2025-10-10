#!/bin/bash

# Script para adicionar nova biblioteca
# Uso: ./scripts/add-library.sh [nome-biblioteca] [url-llms-txt]
# Exemplo: ./scripts/add-library.sh svelte https://svelte.dev/llms.txt

set -e

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Verificar argumentos
if [ $# -lt 2 ]; then
    echo -e "${RED}❌ Uso incorreto!${NC}"
    echo ""
    echo "Uso: $0 [nome-biblioteca] [url-llms-txt]"
    echo ""
    echo "Exemplos:"
    echo "  $0 svelte https://svelte.dev/llms.txt"
    echo "  $0 astro https://astro.build/llms.txt"
    exit 1
fi

LIB_NAME="$1"
LIB_URL="$2"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${BLUE}📚 Adicionando biblioteca: $LIB_NAME${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Verificar se URL é válida
echo -n "🔍 Verificando URL... "
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$LIB_URL")

if [ "$HTTP_CODE" != "200" ]; then
    echo -e "${RED}✗${NC}"
    echo ""
    echo -e "${YELLOW}⚠️  URL não retornou 200 OK (código: $HTTP_CODE)${NC}"
    echo ""
    read -p "Deseja criar um guia customizado? (s/N): " -n 1 -r
    echo ""

    if [[ $REPLY =~ ^[Ss]$ ]]; then
        # Criar guia customizado
        mkdir -p "docs/$LIB_NAME"

        cat > "docs/$LIB_NAME/custom-guide.md" <<EOF
# $LIB_NAME - Documentação Customizada
# Fonte: [URL oficial]
# Data de criação: $(date '+%Y-%m-%d')
# Tipo: Documentação customizada (não existe llms.txt oficial)

## Sobre $LIB_NAME

[Descrição da biblioteca]

## Instalação

\`\`\`bash
npm install $LIB_NAME
# ou
pnpm add $LIB_NAME
\`\`\`

## Uso Básico

\`\`\`typescript
// Exemplo de uso
\`\`\`

## Configuração

[Informações de configuração]

## Exemplos Práticos

### Exemplo 1

\`\`\`typescript
// Código de exemplo
\`\`\`

## Boas Práticas

1. [Prática 1]
2. [Prática 2]

## Referências

- [Documentação Oficial]($LIB_URL)
EOF

        echo -e "${GREEN}✅ Guia customizado criado em docs/$LIB_NAME/custom-guide.md${NC}"
    else
        echo ""
        echo "Operação cancelada."
        exit 0
    fi
else
    echo -e "${GREEN}✓${NC}"

    # Criar diretório
    echo -n "📁 Criando diretório... "
    mkdir -p "docs/$LIB_NAME"
    echo -e "${GREEN}✓${NC}"

    # Baixar llms.txt
    echo -n "📥 Baixando llms.txt... "
    FILENAME=$(basename "$LIB_URL")
    if curl -sL "$LIB_URL" -o "docs/$LIB_NAME/$FILENAME"; then
        echo -e "${GREEN}✓${NC}"
    else
        echo -e "${RED}✗${NC}"
        exit 1
    fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}✅ Biblioteca adicionada com sucesso!${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "${YELLOW}⚠️  Não esqueça de atualizar:${NC}"
echo "   - docs/INDEX.md"
echo "   - docs/DOCUMENTATION-SOURCES.md"
echo "   - README.md"
echo ""
