# CLAUDE.md

Este arquivo fornece instruções para o Claude Code sobre como gerenciar e gerar documentações `llms.txt` para projetos.

## 🎯 Objetivo deste Repositório

Este repositório contém:
1. **Documentações llms.txt oficiais** de bibliotecas populares
2. **Guias customizados** para bibliotecas sem llms.txt
3. **Instruções e templates** para criar novas documentações
4. **Scripts de automação** para manter docs atualizadas

## 📚 Como Usar Este Repositório em Seus Projetos

### Opção 1: Copiar Documentações Existentes

```bash
# Copiar todas as docs para seu projeto
cp -r docs/ /caminho/do/seu/projeto/.claude/docs/

# Copiar apenas uma biblioteca específica
cp -r docs/daisyui /caminho/do/seu/projeto/.claude/docs/
```

### Opção 2: Usar como Submódulo Git

```bash
cd /caminho/do/seu/projeto
git submodule add https://github.com/seu-usuario/claude-llms-docs .claude/docs
git submodule update --init --recursive
```

## 🤖 Instruções para Claude Code

### Quando Adicionar Nova Documentação

1. **Verificar se existe llms.txt oficial**
   ```bash
   curl -s -o /dev/null -w "%{http_code}" "https://[biblioteca].com/llms.txt"
   ```

2. **Se existir llms.txt oficial (200)**:
   ```bash
   # Criar diretório
   mkdir -p docs/[biblioteca-nome]

   # Baixar llms.txt
   curl -s "https://[biblioteca].com/llms.txt" -o docs/[biblioteca-nome]/llms.txt
   ```

3. **Se NÃO existir llms.txt oficial (404)**:
   - Criar guia customizado em `docs/[biblioteca-nome]/custom-guide.md`
   - Usar template em `templates/custom-guide-template.md`
   - Focar em casos de uso práticos do projeto
   - Incluir exemplos com TypeScript

4. **Atualizar índices**:
   - Atualizar `docs/INDEX.md`
   - Atualizar `docs/DOCUMENTATION-SOURCES.md`
   - Atualizar status da documentação

### Template para Buscar llms.txt

Use este padrão para tentar encontrar llms.txt em sites comuns:

```
Padrões de URL comuns:
1. https://[dominio]/llms.txt
2. https://[dominio]/docs/llms.txt
3. https://docs.[dominio]/llms.txt
4. https://[dominio]/llms-full.txt

Exemplos:
- https://daisyui.com/llms.txt ✅
- https://nextjs.org/docs/llms-full.txt ✅
- https://turbo.build/llms.txt ✅
- https://zod.dev/llms.txt ✅
```

### Estrutura de Documentação Customizada

Quando criar guia customizado, incluir:

```markdown
# [Biblioteca] - Documentação Customizada
# Fonte: [URL oficial]
# Data de criação: [YYYY-MM-DD]
# Tipo: Documentação customizada (não existe llms.txt oficial)

## Sobre [Biblioteca]
[Descrição breve]

## Uso no Projeto
[Como é usado especificamente no projeto]

## Exemplos Práticos
[Código TypeScript com casos reais]

## Configuração
[Setup e configuração]

## Boas Práticas
[Padrões e recomendações]

## Referências
[Links para docs oficiais]
```

## 📋 Checklist para Adicionar Nova Biblioteca

- [ ] Verificar se biblioteca é essencial para o projeto
- [ ] Buscar llms.txt oficial em URLs comuns
- [ ] Se encontrar oficial:
  - [ ] Baixar e salvar em `docs/[biblioteca]/llms.txt`
  - [ ] Não modificar conteúdo original
- [ ] Se NÃO encontrar oficial:
  - [ ] Criar guia customizado focado no projeto
  - [ ] Usar template como base
  - [ ] Incluir exemplos práticos
- [ ] Atualizar `docs/INDEX.md`
- [ ] Atualizar `docs/DOCUMENTATION-SOURCES.md`
- [ ] Adicionar à lista no README.md

## 🔄 Manutenção e Atualização

### Verificar Atualizações de llms.txt Oficiais

Execute periodicamente:

```bash
# Usar script de atualização
./scripts/update-docs.sh

# Ou manualmente para cada biblioteca
curl -s "https://[biblioteca]/llms.txt" -o docs/[biblioteca]/llms.txt
```

### Quando Atualizar Documentações Customizadas

- Nova versão major da biblioteca lançada
- Mudanças significativas na API
- Novos recursos usados no projeto
- Feedback de uso indicando falta de info

## 🎨 Bibliotecas Já Documentadas

### Oficiais (llms.txt)
1. ✅ TurboRepo - https://turbo.build/llms.txt
2. ✅ DaisyUI - https://daisyui.com/llms.txt
3. ✅ Next.js - https://nextjs.org/docs/llms-full.txt
4. ✅ Tauri - https://tauri.app/llms.txt
5. ✅ Vite - https://vite.dev/llms.txt
6. ✅ Zod - https://zod.dev/llms.txt
7. ✅ Prettier - https://prettier.io/llms.txt

### Customizadas (custom-guide.md)
1. ✅ React - docs/react/custom-guide.md
2. ✅ MySQL2 - docs/mysql2/custom-guide.md
3. ✅ NextAuth.js - docs/nextauth/custom-guide.md
4. ✅ Shadcn UI - docs/shadcn/custom-guide.md

## 📝 Prioridade de Consulta

Quando Claude Code trabalhar em um projeto:

1. **PRIMEIRO**: Arquivos em `.claude/docs/` ou `docs/` locais
2. **SEGUNDO**: Conhecimento interno do Claude
3. **TERCEIRO**: Busca web (apenas se necessário)

## ⚙️ Scripts Disponíveis

### `scripts/update-docs.sh`
Atualiza todas as documentações oficiais

### `scripts/add-library.sh [nome] [url]`
Adiciona nova biblioteca ao repositório

### `scripts/check-updates.sh`
Verifica se há atualizações disponíveis

## 🤝 Contribuindo

Para adicionar novas bibliotecas a este repositório:

1. Fork o repositório
2. Adicione a documentação seguindo as instruções acima
3. Atualize todos os índices
4. Crie Pull Request com descrição clara

## 📄 Licença

Este repositório contém documentações de terceiros. Cada arquivo `llms.txt` mantém sua licença original da biblioteca correspondente.

Guias customizados são distribuídos sob MIT License.

---

**Mantido por**: Comunidade Claude Code
**Propósito**: Facilitar acesso rápido a documentações para LLMs
