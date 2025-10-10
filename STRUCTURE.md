# 📂 Estrutura do Repositório

Visão geral completa da estrutura do repositório Claude LLMs Docs.

## 🌳 Tree View

```
claude-llms-docs/
│
├── 📄 README.md                      # Documentação principal
├── 📄 CLAUDE.md                      # Instruções para Claude Code
├── 📄 QUICK-START.md                 # Guia de início rápido
├── 📄 PUBLISHING.md                  # Como publicar no GitHub
├── 📄 CONTRIBUTING.md                # Guia de contribuição
├── 📄 STRUCTURE.md                   # Este arquivo
├── 📄 LICENSE                        # Licença MIT
├── 📄 .gitignore                     # Arquivos ignorados pelo Git
│
├── 📁 .github/
│   └── workflows/
│       └── update-docs.yml           # GitHub Action para auto-update
│
├── 📁 docs/                          # Documentações das bibliotecas
│   ├── 📄 README.md                  # Visão geral das docs
│   ├── 📄 INDEX.md                   # Índice completo
│   ├── 📄 DOCUMENTATION-SOURCES.md   # Fontes e status
│   │
│   ├── 📁 daisyui/
│   │   └── llms.txt                  # ✅ Oficial
│   │
│   ├── 📁 nextjs/
│   │   └── llms-full.txt             # ✅ Oficial
│   │
│   ├── 📁 tauri/
│   │   └── llms.txt                  # ✅ Oficial
│   │
│   ├── 📁 turborepo/
│   │   └── llms.txt                  # ✅ Oficial
│   │
│   ├── 📁 vite/
│   │   └── llms.txt                  # ✅ Oficial
│   │
│   ├── 📁 zod/
│   │   └── llms.txt                  # ✅ Oficial
│   │
│   ├── 📁 prettier/
│   │   └── llms.txt                  # ✅ Oficial
│   │
│   ├── 📁 react/
│   │   └── custom-guide.md           # 📝 Customizado
│   │
│   ├── 📁 mysql2/
│   │   └── custom-guide.md           # 📝 Customizado
│   │
│   ├── 📁 nextauth/
│   │   └── custom-guide.md           # 📝 Customizado
│   │
│   └── 📁 shadcn/
│       └── custom-guide.md           # 📝 Customizado
│
├── 📁 templates/
│   └── custom-guide-template.md      # Template para novos guias
│
└── 📁 scripts/
    ├── update-docs.sh                # Atualizar todas as docs
    ├── add-library.sh                # Adicionar nova biblioteca
    └── check-updates.sh              # Verificar atualizações
```

## 📊 Estatísticas

### Arquivos por Tipo

| Tipo | Quantidade | Descrição |
|------|------------|-----------|
| Documentação (.md) | 19 | READMEs, guias, instruções |
| llms.txt oficiais | 7 | Docs oficiais de bibliotecas |
| Guias customizados | 4 | Docs criadas manualmente |
| Scripts (.sh) | 3 | Automação |
| Workflows (.yml) | 1 | GitHub Actions |
| **Total** | **34** | **Todos os arquivos** |

### Documentações por Categoria

#### UI/Frontend (3)
- ✅ DaisyUI (oficial)
- 📝 Shadcn UI (customizado)
- 📝 React (customizado)

#### Framework & Build Tools (4)
- ✅ TurboRepo (oficial)
- ✅ Next.js (oficial)
- ✅ Tauri (oficial)
- ✅ Vite (oficial)

#### Validação & Utilitários (2)
- ✅ Zod (oficial)
- ✅ Prettier (oficial)

#### Backend & Database (2)
- 📝 MySQL2 (customizado)
- 📝 NextAuth.js (customizado)

## 📝 Descrição dos Arquivos

### Arquivos Raiz

#### `README.md`
- Documentação principal do repositório
- Inclui: overview, instalação, uso, bibliotecas, contribuição
- **Público alvo**: Usuários finais

#### `CLAUDE.md`
- Instruções específicas para Claude Code
- Explica como adicionar/gerenciar documentações
- **Público alvo**: Claude Code AI

#### `QUICK-START.md`
- Guia de início rápido
- Passos simples para começar a usar
- **Público alvo**: Desenvolvedores novos no repo

#### `PUBLISHING.md`
- Como publicar no GitHub
- Configuração de repository, releases, etc
- **Público alvo**: Mantenedores

#### `CONTRIBUTING.md`
- Guia de contribuição
- Processo de PR, padrões de código
- **Público alvo**: Contribuidores

#### `STRUCTURE.md`
- Este arquivo
- Visão geral da estrutura
- **Público alvo**: Todos

#### `LICENSE`
- Licença MIT do repositório
- Nota sobre licenças de docs de terceiros
- **Público alvo**: Todos (legal)

### Diretório `.github/`

#### `workflows/update-docs.yml`
- GitHub Action para atualização automática
- Roda semanalmente (segunda-feira 00:00 UTC)
- Cria PR com atualizações

### Diretório `docs/`

#### `README.md`
- Apresentação do diretório de docs
- Explica estrutura e propósito

#### `INDEX.md`
- Índice completo de todas as bibliotecas
- Categorizado por tipo
- Links para cada documentação

#### `DOCUMENTATION-SOURCES.md`
- URLs oficiais de cada biblioteca
- Status de arquivamento
- Data de última atualização

#### Subdiretórios de Bibliotecas

Cada biblioteca tem:
- `llms.txt` (se oficial) OU
- `custom-guide.md` (se customizado)

### Diretório `templates/`

#### `custom-guide-template.md`
- Template base para criar novos guias
- Estrutura padronizada
- Seções pré-definidas

### Diretório `scripts/`

#### `update-docs.sh`
```bash
# Atualiza todas as documentações oficiais
./scripts/update-docs.sh
```

#### `add-library.sh`
```bash
# Adiciona nova biblioteca
./scripts/add-library.sh nome-lib https://lib.com/llms.txt
```

#### `check-updates.sh`
```bash
# Verifica atualizações disponíveis
./scripts/check-updates.sh
```

## 🎯 Fluxos de Trabalho

### Adicionar Nova Biblioteca

```
1. Verificar llms.txt oficial
   ↓
2a. Se existir → Usar add-library.sh
   ↓
   Baixar llms.txt oficial
   ↓
   Salvar em docs/[lib]/llms.txt

2b. Se NÃO existir → Criar customizado
   ↓
   Copiar template
   ↓
   Preencher com informações
   ↓
   Salvar em docs/[lib]/custom-guide.md

3. Atualizar índices
   ↓
   INDEX.md
   DOCUMENTATION-SOURCES.md
   README.md

4. Commit e PR
```

### Atualizar Documentações

```
1. Executar check-updates.sh
   ↓
2. Se houver atualizações
   ↓
3. Executar update-docs.sh
   ↓
4. Verificar mudanças (git diff)
   ↓
5. Commit e push
```

### GitHub Actions Workflow

```
Agendado (segunda 00:00)
   ↓
Executar update-docs.sh
   ↓
Verificar mudanças (git diff)
   ↓
Se houver mudanças:
   ↓
   Criar PR automaticamente
   ↓
   Mantenedor revisa
   ↓
   Merge PR
```

## 🔗 Relacionamentos

```
README.md
   ├─→ QUICK-START.md (primeiros passos)
   ├─→ CONTRIBUTING.md (como contribuir)
   └─→ docs/INDEX.md (ver todas as docs)

CLAUDE.md
   ├─→ templates/ (como criar novos guias)
   └─→ scripts/ (automação)

docs/INDEX.md
   └─→ docs/[biblioteca]/ (cada doc individual)

scripts/
   ├─→ update-docs.sh (usa: DOCUMENTATION-SOURCES.md)
   ├─→ add-library.sh (usa: templates/)
   └─→ check-updates.sh (usa: docs/)
```

## 📏 Tamanho Aproximado

| Item | Tamanho | Arquivos |
|------|---------|----------|
| Documentações oficiais | ~5-10 MB | 7 llms.txt |
| Guias customizados | ~50 KB | 4 .md |
| Scripts e configs | ~20 KB | 3 .sh + 1 .yml |
| README e docs do repo | ~100 KB | 6 .md |
| **Total** | **~5-10 MB** | **34 arquivos** |

## 🚀 Como Navegar

### Para Usuários
1. Comece em `README.md`
2. Vá para `QUICK-START.md`
3. Copie docs necessárias de `docs/`

### Para Claude Code
1. Leia `CLAUDE.md`
2. Consulte `docs/INDEX.md` para localizar docs
3. Use scripts/ para manutenção

### Para Contribuidores
1. Leia `README.md`
2. Siga `CONTRIBUTING.md`
3. Use `templates/` e `scripts/`

### Para Mantenedores
1. Configure via `PUBLISHING.md`
2. Gerencie com `scripts/`
3. Monitore `.github/workflows/`

---

**Atualizado em**: 2025-10-10
**Versão**: 1.0.0
