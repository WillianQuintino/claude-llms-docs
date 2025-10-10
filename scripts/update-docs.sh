#!/bin/bash

# Script para atualizar todas as documentações oficiais (llms.txt)
# Uso: ./scripts/update-docs.sh

set -e

echo "🔄 Atualizando documentações oficiais..."
echo ""

# Cores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Array de bibliotecas com llms.txt oficial
declare -A LIBRARIES=(
    ["daisyui"]="https://daisyui.com/llms.txt"
    ["nextjs"]="https://nextjs.org/docs/llms-full.txt"
    ["tauri"]="https://tauri.app/llms.txt"
    ["vite"]="https://vite.dev/llms.txt"
    ["zod"]="https://zod.dev/llms.txt"
    ["prettier"]="https://prettier.io/llms.txt"
    ["turborepo"]="https://turbo.build/llms.txt"
)

# Contador
updated=0
failed=0

# Atualizar cada biblioteca
for lib in "${!LIBRARIES[@]}"; do
    url="${LIBRARIES[$lib]}"
    filename=$(basename "$url")
    output_path="docs/$lib/$filename"

    echo -n "📥 Atualizando $lib... "

    # Criar diretório se não existir
    mkdir -p "docs/$lib"

    # Baixar documentação
    if curl -sL "$url" -o "$output_path"; then
        echo -e "${GREEN}✓${NC}"
        ((updated++))
    else
        echo -e "${YELLOW}✗ Falhou${NC}"
        ((failed++))
    fi
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}✅ Atualizadas: $updated${NC}"
if [ $failed -gt 0 ]; then
    echo -e "${YELLOW}⚠️  Falharam: $failed${NC}"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Atualização concluída em $(date '+%Y-%m-%d %H:%M:%S')"
