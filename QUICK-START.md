# 🚀 Quick Start Guide

Guia rápido para começar a usar o repositório Claude LLMs Docs.

## 📥 Instalação em Seu Projeto

### Opção 1: Copiar Manualmente (Recomendado)

```bash
# Copiar todas as documentações
cp -r claude-llms-docs/docs /seu-projeto/.claude/docs

# Ou copiar apenas bibliotecas específicas
cp -r claude-llms-docs/docs/nextjs /seu-projeto/.claude/docs/
cp -r claude-llms-docs/docs/react /seu-projeto/.claude/docs/
```

### Opção 2: Git Submodule

```bash
cd /seu-projeto
git submodule add https://github.com/seu-usuario/claude-llms-docs .claude/docs
git submodule update --init --recursive
```

### Opção 3: Clonar Diretamente

```bash
cd /seu-projeto/.claude
git clone https://github.com/seu-usuario/claude-llms-docs docs
```

## ⚙️ Configurar Claude Code

### 1. Criar `.claude/instructions.md`

```markdown
# Instruções Claude Code

## Prioridade de Consulta de Documentações

1. **PRIMEIRO**: Arquivos em `.claude/docs/` (documentações locais)
2. **SEGUNDO**: Conhecimento interno do Claude
3. **TERCEIRO**: Busca web (apenas se necessário)

Sempre consulte `.claude/docs/INDEX.md` para localizar documentações disponíveis.
```

### 2. Adicionar ao `.gitignore` (Opcional)

Se estiver usando submodule, adicione ao `.gitignore`:

```gitignore
# Claude docs (gerenciado via submodule)
.claude/docs/
```

## 📖 Usar com Claude Code

### Consultar Documentação

Simplesmente pergunte ao Claude sobre uma biblioteca:

```
Claude, como uso DaisyUI para criar um botão?
```

Claude consultará automaticamente `.claude/docs/daisyui/llms.txt`!

### Adicionar Nova Biblioteca

#### Se tiver llms.txt oficial:

```bash
cd claude-llms-docs
./scripts/add-library.sh tailwindcss https://tailwindcss.com/llms.txt
```

#### Se NÃO tiver llms.txt oficial:

```bash
cd claude-llms-docs
./scripts/add-library.sh minha-lib https://minha-lib.com/docs

# Responda 's' quando perguntar sobre criar guia customizado
# Edite: docs/minha-lib/custom-guide.md
```

## 🔄 Atualizar Documentações

### Atualizar Todas

```bash
cd claude-llms-docs
./scripts/update-docs.sh
```

### Verificar Atualizações Disponíveis

```bash
cd claude-llms-docs
./scripts/check-updates.sh
```

### Atualizar Biblioteca Específica

```bash
curl -s "https://biblioteca.com/llms.txt" -o docs/biblioteca/llms.txt
```

## 📝 Criar Guia Customizado

### 1. Use o Template

```bash
cp templates/custom-guide-template.md docs/minha-lib/custom-guide.md
```

### 2. Preencha as Seções

Edite `docs/minha-lib/custom-guide.md`:

- Descrição da biblioteca
- Exemplos práticos com TypeScript
- Casos de uso do SEU projeto
- Boas práticas

### 3. Atualize os Índices

```markdown
# docs/INDEX.md
- ✅ Minha Lib - [`minha-lib/custom-guide.md`](./minha-lib/custom-guide.md)
```

## 🎯 Melhores Práticas

### 1. Mantenha Docs Atualizadas

Execute `./scripts/update-docs.sh` mensalmente

### 2. Documente Apenas o Essencial

Não documente bibliotecas que:
- Têm API muito simples
- São raramente usadas
- Já são muito bem conhecidas

### 3. Foque em Casos Práticos

Guias customizados devem ter:
- ✅ Exemplos reais do projeto
- ✅ Padrões usados pela equipe
- ❌ Documentação genérica/completa

### 4. Use TypeScript

Sempre use TypeScript nos exemplos para melhor type safety.

## 🔗 Estrutura de Referência

```
seu-projeto/
└── .claude/
    ├── instructions.md        # Configure prioridade de docs
    └── docs/                  # Clone/submodule deste repo
        ├── INDEX.md
        ├── daisyui/
        │   └── llms.txt
        ├── nextjs/
        │   └── llms-full.txt
        └── react/
            └── custom-guide.md
```

## 💡 Dicas

### Verificar se Claude Está Usando Docs

Pergunte ao Claude:
```
Você consultou a documentação local para responder isso?
```

### Adicionar Apenas o Necessário

Não copie TODAS as docs. Copie apenas as bibliotecas que você usa!

```bash
# Apenas Next.js e React
cp -r claude-llms-docs/docs/nextjs /seu-projeto/.claude/docs/
cp -r claude-llms-docs/docs/react /seu-projeto/.claude/docs/
```

### Criar Alias Úteis

Adicione ao seu `.bashrc` ou `.zshrc`:

```bash
alias docs-update='cd ~/claude-llms-docs && ./scripts/update-docs.sh'
alias docs-check='cd ~/claude-llms-docs && ./scripts/check-updates.sh'
alias docs-add='cd ~/claude-llms-docs && ./scripts/add-library.sh'
```

## ❓ Problemas Comuns

### Claude não está usando docs locais

**Solução**: Verifique se `.claude/instructions.md` existe e está configurado corretamente.

### Script não executa

**Solução**: Dê permissão de execução:
```bash
chmod +x scripts/*.sh
```

### llms.txt não encontrado (404)

**Solução**: Crie um guia customizado:
```bash
./scripts/add-library.sh nome-lib https://lib.com/docs
# Responda 's' para criar customizado
```

## 🆘 Precisa de Ajuda?

- 📖 Leia: [README.md](README.md)
- 🤖 Consulte: [CLAUDE.md](CLAUDE.md)
- 🐛 Reporte: [GitHub Issues](https://github.com/seu-usuario/claude-llms-docs/issues)

---

**Pronto para começar?** Execute:

```bash
cd /seu-projeto
mkdir -p .claude
cp -r /caminho/para/claude-llms-docs/docs .claude/
```

🎉 **Agora o Claude tem acesso às documentações offline!**
