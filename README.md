# 📚 Claude LLMs Docs

> Repositório centralizado de documentações `llms.txt` para uso com Claude Code e outros Large Language Models

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Maintained](https://img.shields.io/badge/Maintained-Yes-green.svg)](https://github.com/seu-usuario/claude-llms-docs)

## 🎯 O que é este repositório?

Este repositório contém documentações oficiais (`llms.txt`) e guias customizados de bibliotecas JavaScript/TypeScript populares, otimizados para uso com **Claude Code** e outros Large Language Models.

### Por que usar?

- ✅ **Acesso offline** a documentações essenciais
- ✅ **Respostas mais rápidas** do Claude (sem necessidade de busca web)
- ✅ **Documentações focadas** em casos de uso práticos
- ✅ **Sempre atualizadas** com scripts de automação
- ✅ **Padronizadas** seguindo formato `llms.txt`

## 📦 Bibliotecas Documentadas (11)

### Documentações Oficiais (7)

| Biblioteca | Descrição | Arquivo |
|-----------|-----------|---------|
| **TurboRepo** | Monorepo build system (Rust) | [`docs/turborepo/llms.txt`](docs/turborepo/llms.txt) |
| **DaisyUI** | CSS library para Tailwind CSS 4 | [`docs/daisyui/llms.txt`](docs/daisyui/llms.txt) |
| **Next.js** | Framework React com App Router | [`docs/nextjs/llms-full.txt`](docs/nextjs/llms-full.txt) |
| **Tauri** | Framework desktop/mobile | [`docs/tauri/llms.txt`](docs/tauri/llms.txt) |
| **Vite** | Build tool moderna | [`docs/vite/llms.txt`](docs/vite/llms.txt) |
| **Zod** | Schema validation TypeScript-first | [`docs/zod/llms.txt`](docs/zod/llms.txt) |
| **Prettier** | Code formatter | [`docs/prettier/llms.txt`](docs/prettier/llms.txt) |

### Guias Customizados (4)

| Biblioteca | Descrição | Arquivo |
|-----------|-----------|---------|
| **React** | Hooks e padrões React 18+ | [`docs/react/custom-guide.md`](docs/react/custom-guide.md) |
| **MySQL2** | Cliente MySQL com padrão singleton | [`docs/mysql2/custom-guide.md`](docs/mysql2/custom-guide.md) |
| **NextAuth.js** | Autenticação para Next.js | [`docs/nextauth/custom-guide.md`](docs/nextauth/custom-guide.md) |
| **Shadcn UI** | Componentes React reutilizáveis | [`docs/shadcn/custom-guide.md`](docs/shadcn/custom-guide.md) |

## 🚀 Como Usar

### Opção 1: Copiar para seu Projeto

```bash
# Copiar todas as documentações
cp -r docs/ /caminho/do/seu/projeto/.claude/docs/

# Ou copiar apenas uma biblioteca específica
cp -r docs/nextjs /caminho/do/seu/projeto/.claude/docs/
```

### Opção 2: Git Submodule

```bash
cd /caminho/do/seu/projeto
git submodule add https://github.com/seu-usuario/claude-llms-docs .claude/docs
git submodule update --init --recursive
```

### Opção 3: Download Direto

Baixe as documentações que precisa diretamente de:
```
https://raw.githubusercontent.com/seu-usuario/claude-llms-docs/main/docs/[biblioteca]/llms.txt
```

## 📖 Estrutura do Repositório

```
claude-llms-docs/
├── README.md                  # Este arquivo
├── CLAUDE.md                  # Instruções para Claude Code
├── LICENSE                    # Licença MIT
│
├── docs/                      # Documentações
│   ├── INDEX.md              # Índice completo
│   ├── DOCUMENTATION-SOURCES.md  # Fontes e status
│   │
│   ├── daisyui/
│   │   └── llms.txt          # Oficial
│   ├── nextjs/
│   │   └── llms-full.txt     # Oficial
│   ├── react/
│   │   └── custom-guide.md   # Customizado
│   └── ...
│
├── templates/                 # Templates para novos guias
│   ├── custom-guide-template.md
│   └── llms-txt-template.txt
│
└── scripts/                   # Scripts de automação
    ├── update-docs.sh        # Atualizar todas as docs
    ├── add-library.sh        # Adicionar nova biblioteca
    └── check-updates.sh      # Verificar atualizações
```

## 🤖 Usando com Claude Code

### 1. Configure o Claude para usar as docs

Adicione ao seu `.claude/instructions.md`:

```markdown
## Prioridade de Consulta de Documentações

1. **PRIMEIRO**: Arquivos em `.claude/docs/` (documentações locais)
2. **SEGUNDO**: Conhecimento interno do Claude
3. **TERCEIRO**: Busca web (apenas se necessário)

Sempre consulte `.claude/docs/INDEX.md` para localizar documentações disponíveis.
```

### 2. Claude encontrará automaticamente as docs

Quando você perguntar sobre uma biblioteca, Claude consultará primeiro as documentações locais!

## 📝 Adicionar Nova Biblioteca

### Passo 1: Verificar se existe llms.txt oficial

```bash
curl -s -o /dev/null -w "%{http_code}" "https://[biblioteca].com/llms.txt"
```

### Passo 2a: Se existir (código 200)

```bash
mkdir -p docs/[biblioteca-nome]
curl -s "https://[biblioteca].com/llms.txt" -o docs/[biblioteca-nome]/llms.txt
```

### Passo 2b: Se NÃO existir (código 404)

Crie um guia customizado usando o template:

```bash
cp templates/custom-guide-template.md docs/[biblioteca-nome]/custom-guide.md
# Edite o arquivo com informações da biblioteca
```

### Passo 3: Atualizar índices

- Atualize `docs/INDEX.md`
- Atualize `docs/DOCUMENTATION-SOURCES.md`
- Atualize este README.md

## 🔄 Manutenção

### Atualizar Documentações Oficiais

```bash
# Atualizar todas as documentações
./scripts/update-docs.sh

# Atualizar biblioteca específica
curl -s "https://[biblioteca]/llms.txt" -o docs/[biblioteca]/llms.txt
```

### Verificar se há Atualizações

```bash
./scripts/check-updates.sh
```

## 🛠️ Scripts Disponíveis

| Script | Descrição |
|--------|-----------|
| `update-docs.sh` | Atualiza todas as documentações oficiais |
| `add-library.sh [nome] [url]` | Adiciona nova biblioteca |
| `check-updates.sh` | Verifica atualizações disponíveis |

## 🤝 Contribuindo

Contribuições são bem-vindas! Para adicionar uma nova biblioteca:

1. Fork este repositório
2. Crie uma branch (`git checkout -b feature/add-nova-biblioteca`)
3. Adicione a documentação seguindo as instruções acima
4. Atualize todos os índices
5. Commit suas mudanças (`git commit -m 'Add: Documentação da biblioteca X'`)
6. Push para a branch (`git push origin feature/add-nova-biblioteca`)
7. Abra um Pull Request

### Guidelines para Contribuições

- ✅ Sempre busque primeiro o `llms.txt` oficial
- ✅ Guias customizados devem focar em casos práticos
- ✅ Inclua exemplos TypeScript quando possível
- ✅ Atualize todos os arquivos de índice
- ✅ Mantenha formatação consistente

## 📋 Roadmap

- [ ] Adicionar mais bibliotecas populares
- [ ] Criar GitHub Action para auto-update
- [ ] Adicionar validação de formato llms.txt
- [ ] Criar CLI para gerenciar documentações
- [ ] Adicionar versionamento das documentações
- [ ] Criar mirror de CDN para acesso rápido

## 📄 Licença

Este repositório é distribuído sob a licença **MIT**.

**Nota importante**: Os arquivos `llms.txt` incluídos mantêm suas licenças originais das respectivas bibliotecas. Este repositório apenas redistribui documentações publicamente disponíveis.

## 🔗 Links Úteis

- [Claude Code](https://claude.com/claude-code)
- [Formato llms.txt](https://llmstxt.org/)
- [DaisyUI llms.txt](https://daisyui.com/llms.txt)
- [Next.js llms.txt](https://nextjs.org/docs/llms-full.txt)

## 💬 Suporte

- **Issues**: [GitHub Issues](https://github.com/seu-usuario/claude-llms-docs/issues)
- **Discussões**: [GitHub Discussions](https://github.com/seu-usuario/claude-llms-docs/discussions)

---

**Mantido por**: Comunidade Claude Code
**Última atualização**: 2025-10-10
**Versão**: 1.0.0

⭐ Se este repositório foi útil, considere dar uma estrela!
