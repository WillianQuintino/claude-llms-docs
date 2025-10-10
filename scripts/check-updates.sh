#!/bin/bash

# Script para verificar se há atualizações disponíveis nas documentações
# Uso: ./scripts/check-updates.sh

set -e

echo "🔍 Verificando atualizações disponíveis..."
echo ""

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0;33m'

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

# Contadores
needs_update=0
up_to_date=0

# Verificar cada biblioteca
for lib in "${!LIBRARIES[@]}"; do
    url="${LIBRARIES[$lib]}"
    filename=$(basename "$url")
    local_path="docs/$lib/$filename"

    echo -n "📦 $lib: "

    # Verificar se arquivo local existe
    if [ ! -f "$local_path" ]; then
        echo -e "${YELLOW}Arquivo local não encontrado${NC}"
        ((needs_update++))
        continue
    fi

    # Baixar versão atual temporariamente
    temp_file=$(mktemp)
    if ! curl -sL "$url" -o "$temp_file"; then
        echo -e "${YELLOW}Erro ao buscar versão online${NC}"
        rm -f "$temp_file"
        continue
    fi

    # Comparar arquivos
    if cmp -s "$local_path" "$temp_file"; then
        echo -e "${GREEN}✓ Atualizado${NC}"
        ((up_to_date++))
    else
        echo -e "${YELLOW}⚠ Atualização disponível${NC}"
        ((needs_update++))

        # Mostrar diferença de tamanho
        local_size=$(wc -c < "$local_path")
        remote_size=$(wc -c < "$temp_file")
        echo "  Local: $local_size bytes | Remoto: $remote_size bytes"
    fi

    rm -f "$temp_file"
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}✅ Atualizadas: $up_to_date${NC}"
if [ $needs_update -gt 0 ]; then
    echo -e "${YELLOW}⚠️  Precisam atualização: $needs_update${NC}"
    echo ""
    echo "Execute './scripts/update-docs.sh' para atualizar"
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
