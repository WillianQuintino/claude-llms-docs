# Fontes de Documentação Oficial

Este arquivo contém as URLs das documentações oficiais das bibliotecas usadas no projeto.
Sempre consulte os arquivos `llms.txt` locais antes de buscar online.

## Bibliotecas com llms.txt Oficial

### UI/Frontend
- **DaisyUI**: https://daisyui.com/llms.txt
- **dnd-kit**: https://docs.dndkit.com/llms.txt
- **Shadcn UI**: https://ui.shadcn.com/docs (não possui llms.txt oficial)
- **React**: https://react.dev/reference/react (não possui llms.txt oficial)

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
| DaisyUI | https://daisyui.com/llms.txt | ✅ Arquivado (2025-10-10) | `docs/daisyui/llms.txt` |
| dnd-kit | https://docs.dndkit.com/llms.txt | ✅ Arquivado (2025-01-15) | `docs/dnd-kit/llms.txt` |
| TurboRepo | https://turbo.build/llms.txt | ✅ Arquivado (2025-10-10) | `docs/turborepo/llms.txt` |
| Next.js | https://nextjs.org/docs/llms-full.txt | ✅ Arquivado (2025-10-10) | `docs/nextjs/llms-full.txt` |
| Tauri | https://tauri.app/llms.txt | ✅ Arquivado (2025-10-10) | `docs/tauri/llms.txt` |
| Vite | https://vite.dev/llms.txt | ✅ Arquivado (2025-10-10) | `docs/vite/llms.txt` |
| Zod | https://zod.dev/llms.txt | ✅ Arquivado (2025-10-10) | `docs/zod/llms.txt` |
| Prettier | https://prettier.io/llms.txt | ✅ Arquivado (2025-10-10) | `docs/prettier/llms.txt` |
| Firebase | https://firebase.google.com/docs/llms.txt | ✅ Arquivado (2025-10-10) | `docs/firebase/llms.txt` |
| React | https://react.dev/reference/react | 📝 Custom (2025-10-10) | `docs/react/custom-guide.md` |
| MySQL2 | https://sidorares.github.io/node-mysql2/docs | 📝 Custom (2025-10-10) | `docs/mysql2/custom-guide.md` |
| NextAuth.js | https://next-auth.js.org/ | 📝 Custom (2025-10-10) | `docs/nextauth/custom-guide.md` |
| Shadcn UI | https://ui.shadcn.com/docs | 📝 Custom (2025-10-10) | `docs/shadcn/custom-guide.md` |
| Tailwind CSS | https://tailwindcss.com/docs | 📝 Custom (2025-10-10) | `docs/tailwindcss/custom-guide.md` |
| Jotai | https://jotai.org/docs | 📝 Custom (2025-10-10) | `docs/jotai/custom-guide.md` |
| SWR | https://swr.vercel.app | 📝 Custom (2025-10-10) | `docs/swr/custom-guide.md` |
| React Hook Form | https://react-hook-form.com | 📝 Custom (2025-10-10) | `docs/react-hook-form/custom-guide.md` |
| WhatsApp Web.js | https://docs.wwebjs.dev | 📝 Custom (2025-10-10) | `docs/whatsapp-web-js/custom-guide.md` |

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
