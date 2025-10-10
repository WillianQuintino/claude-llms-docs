# 🤝 Contributing to Claude LLMs Docs

Obrigado por considerar contribuir! Este guia ajudará você a adicionar novas bibliotecas ou melhorar as existentes.

## 📋 Índice

- [Como Contribuir](#como-contribuir)
- [Adicionar Nova Biblioteca](#adicionar-nova-biblioteca)
- [Atualizar Documentação Existente](#atualizar-documentação-existente)
- [Melhorar Scripts](#melhorar-scripts)
- [Padrões de Código](#padrões-de-código)
- [Pull Request Process](#pull-request-process)

## 🎯 Como Contribuir

Contribuições são bem-vindas nas seguintes áreas:

1. **Adicionar novas bibliotecas** com llms.txt oficial ou guia customizado
2. **Atualizar documentações** existentes
3. **Melhorar scripts** de automação
4. **Corrigir bugs** em documentações ou scripts
5. **Melhorar documentação** do repositório

## ➕ Adicionar Nova Biblioteca

### Passo 1: Verificar se já existe

Consulte [`docs/INDEX.md`](docs/INDEX.md) para ver bibliotecas já documentadas.

### Passo 2: Fork e Clone

```bash
# Fork no GitHub
# Depois clone seu fork
git clone https://github.com/SEU-USUARIO/claude-llms-docs.git
cd claude-llms-docs
```

### Passo 3: Criar Branch

```bash
git checkout -b add/nome-da-biblioteca
```

### Passo 4: Verificar llms.txt Oficial

```bash
# Testar se existe llms.txt oficial
curl -s -o /dev/null -w "%{http_code}" "https://biblioteca.com/llms.txt"

# Também tente variações:
# - https://biblioteca.com/docs/llms.txt
# - https://docs.biblioteca.com/llms.txt
```

### Passo 5a: Se Existir llms.txt Oficial (200)

```bash
# Use o script helper
./scripts/add-library.sh nome-biblioteca https://biblioteca.com/llms.txt

# Ou manualmente:
mkdir -p docs/nome-biblioteca
curl -s "https://biblioteca.com/llms.txt" -o docs/nome-biblioteca/llms.txt
```

### Passo 5b: Se NÃO Existir llms.txt Oficial (404)

```bash
# Usar script (responda 's' quando perguntar)
./scripts/add-library.sh nome-biblioteca https://biblioteca.com/docs

# Ou manualmente:
mkdir -p docs/nome-biblioteca
cp templates/custom-guide-template.md docs/nome-biblioteca/custom-guide.md

# Editar o arquivo com informações da biblioteca
```

### Passo 6: Atualizar Índices

Atualize **TODOS** estes arquivos:

#### `docs/INDEX.md`

```markdown
### ✅ [Categoria Apropriada]

#### Nome da Biblioteca
- **Arquivo**: [`nome-biblioteca/llms.txt`](./nome-biblioteca/llms.txt)
- **Fonte**: https://biblioteca.com/llms.txt
- **Descrição**: Breve descrição
- **Status**: ✅ Documentação oficial arquivada
```

#### `docs/DOCUMENTATION-SOURCES.md`

Adicione na tabela de Status:

```markdown
| Nome Biblioteca | https://biblioteca.com/llms.txt | ✅ Arquivado (YYYY-MM-DD) | `.claude/docs/nome-biblioteca/llms.txt` |
```

#### `README.md`

Adicione na tabela de bibliotecas:

```markdown
| **Nome da Biblioteca** | Descrição breve | [`docs/nome-biblioteca/llms.txt`](docs/nome-biblioteca/llms.txt) |
```

Atualize os contadores:
```markdown
**Documentações Oficiais (X):**  # Incremente se for oficial
**Guias Customizados (X):**      # Incremente se for customizado
```

### Passo 7: Testar Localmente

```bash
# Verificar se arquivo foi criado
ls -la docs/nome-biblioteca/

# Testar script de update (se oficial)
./scripts/update-docs.sh

# Verificar se links estão corretos
grep -r "nome-biblioteca" docs/INDEX.md
```

### Passo 8: Commit e Push

```bash
git add .
git commit -m "feat: add [nome-biblioteca] documentation

- Add official llms.txt from [URL]
- Update INDEX.md, DOCUMENTATION-SOURCES.md, README.md
- Tested with update script"

git push origin add/nome-biblioteca
```

### Passo 9: Abrir Pull Request

1. Vá para https://github.com/seu-usuario/claude-llms-docs
2. Clique em **Compare & pull request**
3. Use o template:

```markdown
## 📚 Adicionar [Nome da Biblioteca]

### Tipo de Documentação
- [ ] llms.txt oficial
- [ ] Guia customizado

### Informações
- **Biblioteca**: Nome da Biblioteca
- **Fonte**: https://biblioteca.com/llms.txt
- **Categoria**: [UI/Frontend | Backend | Framework | etc]

### Checklist
- [ ] Arquivo de documentação adicionado
- [ ] `docs/INDEX.md` atualizado
- [ ] `docs/DOCUMENTATION-SOURCES.md` atualizado
- [ ] `README.md` atualizado
- [ ] Contadores atualizados corretamente
- [ ] Testado localmente

### Descrição
[Breve descrição da biblioteca e por que é útil ter documentada]
```

## 🔄 Atualizar Documentação Existente

### Para llms.txt Oficiais

```bash
git checkout -b update/nome-biblioteca

# Atualizar
curl -s "https://biblioteca.com/llms.txt" -o docs/nome-biblioteca/llms.txt

# Verificar mudanças
git diff docs/nome-biblioteca/llms.txt

# Se houver mudanças significativas
git add docs/nome-biblioteca/llms.txt
git commit -m "chore: update [nome-biblioteca] llms.txt

- Updated from official source
- Date: $(date '+%Y-%m-%d')"

git push origin update/nome-biblioteca
```

### Para Guias Customizados

```bash
git checkout -b improve/nome-biblioteca-docs

# Editar arquivo
nano docs/nome-biblioteca/custom-guide.md

# Adicionar exemplos, melhorar seções, etc

git add docs/nome-biblioteca/custom-guide.md
git commit -m "docs: improve [nome-biblioteca] custom guide

- Add TypeScript examples
- Update configuration section
- Add troubleshooting tips"

git push origin improve/nome-biblioteca-docs
```

## 🛠️ Melhorar Scripts

### Adicionar Nova Funcionalidade

```bash
git checkout -b feature/improve-scripts

# Editar script
nano scripts/update-docs.sh

# Testar
chmod +x scripts/update-docs.sh
./scripts/update-docs.sh

git add scripts/
git commit -m "feat: improve update-docs script

- Add progress bar
- Better error handling
- Colorful output"

git push origin feature/improve-scripts
```

## 📏 Padrões de Código

### Guias Customizados

Devem incluir:

```markdown
# [Biblioteca] - Documentação Customizada
# Fonte: [URL]
# Data de criação: YYYY-MM-DD
# Tipo: Documentação customizada

## Sobre [Biblioteca]
[Descrição]

## Instalação
[Comandos npm/pnpm/yarn]

## Uso Básico
[Exemplos TypeScript]

## Configuração
[Setup e configs]

## Exemplos Práticos
[Casos reais de uso]

## Boas Práticas
[Recomendações]

## Referências
[Links oficiais]
```

### Scripts Shell

- Use `#!/bin/bash`
- Adicione `set -e` no início
- Use cores para output (GREEN, YELLOW, RED, NC)
- Adicione comentários descritivos
- Valide argumentos de entrada
- Forneça mensagens de erro claras

### Commits

Siga [Conventional Commits](https://www.conventionalcommits.org/):

```bash
feat: add new feature
fix: fix bug
docs: update documentation
chore: routine task
refactor: code refactoring
test: add tests
```

## 🔍 Pull Request Process

### Antes de Abrir PR

- [ ] Testado localmente
- [ ] Todos os índices atualizados
- [ ] Commit messages claros
- [ ] Sem arquivos desnecessários (node_modules, .DS_Store, etc)

### Template de PR

```markdown
## Descrição
[Breve descrição das mudanças]

## Tipo de Mudança
- [ ] Nova biblioteca
- [ ] Atualização de docs
- [ ] Melhoria de scripts
- [ ] Correção de bug
- [ ] Documentação do repositório

## Checklist
- [ ] Código segue os padrões do projeto
- [ ] Documentação atualizada
- [ ] Testado localmente
- [ ] Commit messages são descritivos

## Informações Adicionais
[Qualquer contexto adicional]
```

### Review Process

1. Mantenedor revisará o PR
2. Feedback será fornecido se necessário
3. Após aprovação, PR será merged
4. Nova release pode ser criada se aplicável

## ❓ Dúvidas

- Leia [`README.md`](README.md)
- Consulte [`CLAUDE.md`](CLAUDE.md)
- Veja [`QUICK-START.md`](QUICK-START.md)
- Abra uma [Issue](https://github.com/seu-usuario/claude-llms-docs/issues)

## 🙏 Reconhecimentos

Todos os contribuidores serão listados em:
- Release notes
- README.md (seção de contribuidores)

Obrigado por contribuir! 🎉

---

**Code of Conduct**: Seja respeitoso e construtivo. Queremos uma comunidade acolhedora para todos.
