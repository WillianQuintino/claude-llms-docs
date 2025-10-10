# Fontes de Documentação Oficial

Este arquivo contém as URLs das documentações oficiais das bibliotecas usadas no projeto.
Sempre consulte os arquivos `llms.txt` locais antes de buscar online.

## Bibliotecas com llms.txt Oficial

### UI/Frontend
- **DaisyUI**: https://daisyui.com/llms.txt
- **Shadcn UI**: https://ui.shadcn.com/docs (verificar se tem llms.txt)
- **React**: https://react.dev/reference/react

### Build Tools & Framework
- **TurboRepo**: https://turbo.build/llms.txt
- **Next.js**: https://nextjs.org/docs/llms-full.txt
- **Vite**: https://vite.dev/llms.txt
- **Tauri**: https://tauri.app/llms.txt

### Validação & Utilitários
- **Zod**: https://zod.dev/llms.txt
- **Prettier**: https://prettier.io/docs/ (verificar se tem llms.txt)

### Backend & Database
- **MySQL2**: https://sidorares.github.io/node-mysql2/docs (verificar se tem llms.txt)
- **NextAuth.js**: https://next-auth.js.org/getting-started/introduction (verificar se tem llms.txt)

## Status de Arquivamento

| Biblioteca | URL Oficial | Status | Caminho Local |
|-----------|-------------|--------|---------------|
| DaisyUI | https://daisyui.com/llms.txt | ✅ Arquivado (2025-10-10) | `.claude/docs/daisyui/llms.txt` |
| TurboRepo | https://turbo.build/llms.txt | ✅ Arquivado (2025-10-10) | `.claude/docs/turborepo/llms.txt` |
| Next.js | https://nextjs.org/docs/llms-full.txt | ✅ Arquivado (2025-10-10) | `.claude/docs/nextjs/llms-full.txt` |
| Tauri | https://tauri.app/llms.txt | ✅ Arquivado (2025-10-10) | `.claude/docs/tauri/llms.txt` |
| Vite | https://vite.dev/llms.txt | ✅ Arquivado (2025-10-10) | `.claude/docs/vite/llms.txt` |
| Zod | https://zod.dev/llms.txt | ✅ Arquivado (2025-10-10) | `.claude/docs/zod/llms.txt` |
| Prettier | https://prettier.io/llms.txt | ✅ Arquivado (2025-10-10) | `.claude/docs/prettier/llms.txt` |
| React | https://react.dev/reference/react | 📝 Custom (2025-10-10) | `.claude/docs/react/custom-guide.md` |
| MySQL2 | https://sidorares.github.io/node-mysql2/docs | 📝 Custom (2025-10-10) | `.claude/docs/mysql2/custom-guide.md` |
| NextAuth.js | https://next-auth.js.org/ | 📝 Custom (2025-10-10) | `.claude/docs/nextauth/custom-guide.md` |
| Shadcn UI | https://ui.shadcn.com/docs | 📝 Custom (2025-10-10) | `.claude/docs/shadcn/custom-guide.md` |

## Como Atualizar Documentações

1. Verificar se existe `llms.txt` na URL da biblioteca
2. Baixar e salvar em `.claude/docs/[biblioteca]/llms.txt`
3. Adicionar metadados no cabeçalho do arquivo
4. Atualizar status nesta tabela (⏳ → ✅)
5. Atualizar `INDEX.md` com o novo arquivo

## Metadados a Adicionar

Ao salvar um arquivo de documentação, adicione no início:

```
# [Nome da Biblioteca] - Documentação Oficial
# Fonte: [URL completa]
# Data de captura: [YYYY-MM-DD]
# Versão da biblioteca: [versão se conhecida]
#
# ============================================
# Conteúdo original abaixo
# ============================================

[conteúdo original...]
```

## Notas

- **Prioridade 1**: Arquivos já baixados em `.claude/docs/`
- **Prioridade 2**: Conhecimento interno do Claude
- **Prioridade 3**: Buscar online apenas se necessário
- Manter documentações atualizadas conforme versões do projeto
- Verificar periodicamente se há atualizações nas fontes oficiais
