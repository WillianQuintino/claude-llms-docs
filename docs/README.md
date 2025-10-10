# 📚 Documentações do Projeto

Bem-vindo ao repositório de documentações do projeto **Tauri v2 + Next.js Monorepo**.

## 🎯 Objetivo

Este diretório contém documentações oficiais e customizadas das principais bibliotecas utilizadas no projeto, otimizadas para consulta rápida por Large Language Models (LLMs) e desenvolvedores.

## 📂 Estrutura

```
.claude/docs/
├── README.md                      # Este arquivo
├── INDEX.md                       # Índice completo de todas as documentações
├── DOCUMENTATION-SOURCES.md       # Fontes e status de cada documentação
│
├── daisyui/
│   └── llms.txt                   # ✅ Oficial
├── nextjs/
│   └── llms-full.txt              # ✅ Oficial
├── tauri/
│   └── llms.txt                   # ✅ Oficial
├── vite/
│   └── llms.txt                   # ✅ Oficial
├── zod/
│   └── llms.txt                   # ✅ Oficial
├── prettier/
│   └── llms.txt                   # ✅ Oficial
│
├── react/
│   └── custom-guide.md            # 📝 Customizada
├── mysql2/
│   └── custom-guide.md            # 📝 Customizada
├── nextauth/
│   └── custom-guide.md            # 📝 Customizada
└── shadcn/
    └── custom-guide.md            # 📝 Customizada
```

## ✅ Status Completo

### Documentações Oficiais (7)
Arquivos `llms.txt` oficiais mantidos pelas próprias bibliotecas:
- **TurboRepo** - Monorepo build system (Rust)
- **DaisyUI v5** - CSS library para Tailwind CSS 4
- **Next.js 15+** - Framework React com App Router
- **Tauri v2** - Framework desktop/mobile
- **Vite** - Build tool moderna
- **Zod v4** - Schema validation TypeScript-first
- **Prettier** - Code formatter

### Documentações Customizadas (4)
Guias criados especificamente para o projeto:
- **React 18+** - Hooks e padrões usados no projeto
- **MySQL2** - Padrão singleton e queries
- **NextAuth.js v4** - Autenticação e configuração
- **Shadcn UI** - Componentes e integração com DaisyUI

## 🚀 Como Usar

### Para Claude Code (LLM)
1. **Consulte primeiro** os arquivos em `.claude/docs/`
2. Use [`INDEX.md`](./INDEX.md) para localizar rapidamente uma biblioteca
3. Priorize documentações locais sobre busca online

### Para Desenvolvedores
1. Acesse [`INDEX.md`](./INDEX.md) para ver todas as documentações disponíveis
2. Cada documentação contém exemplos práticos do projeto
3. Use como referência rápida durante desenvolvimento

## 📖 Arquivos Principais

| Arquivo | Descrição |
|---------|-----------|
| [`INDEX.md`](./INDEX.md) | Índice completo com links para todas as docs |
| [`DOCUMENTATION-SOURCES.md`](./DOCUMENTATION-SOURCES.md) | URLs oficiais e status de atualização |
| `*/llms.txt` | Documentação oficial otimizada para LLMs |
| `*/custom-guide.md` | Guias customizados para o projeto |

## 🔄 Atualização

**Última atualização**: 2025-10-10

Para atualizar ou adicionar documentação:
1. Verifique se existe `llms.txt` oficial no site da biblioteca
2. Se existir, baixe e salve em `.claude/docs/[biblioteca]/llms.txt`
3. Se não existir, crie um guia customizado em `.claude/docs/[biblioteca]/custom-guide.md`
4. Atualize `INDEX.md` e `DOCUMENTATION-SOURCES.md`

## 💡 Boas Práticas

### Prioridade de Consulta
1. **Primeiro**: Arquivos locais em `.claude/docs/`
2. **Segundo**: Conhecimento interno do Claude
3. **Terceiro**: Busca online (apenas se necessário)

### Manutenção
- ✅ Verificar atualizações mensalmente
- ✅ Manter metadados atualizados (data, versão)
- ✅ Criar guias customizados quando relevante ao projeto
- ✅ Priorizar exemplos práticos sobre documentação genérica

## 📝 Notas

- Arquivos `llms.txt` são otimizados especificamente para Large Language Models
- Documentações customizadas focam em casos de uso reais do projeto
- Todas as documentações incluem exemplos práticos com TypeScript
- Guias customizados seguem a arquitetura e padrões do projeto

## 🔗 Links Úteis

- [Instruções do Projeto](../.claude/instructions.md)
- [Regras do Projeto](../.claude/project-rules.md)
- [Arquitetura](../.claude/ARCHITECTURE-CONTEXT.md)
- [Workflow](../.claude/WORKFLOW-GUIDE.md)

---

**Mantido por**: Claude Code
**Projeto**: Tauri v2 + Next.js Monorepo
