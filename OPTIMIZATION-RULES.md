# Regras do Projeto - Gerenciamento de Documentações

## Estrutura de Documentações LLMs

### Organização de Arquivos
- Todos os arquivos `llms.txt` devem ficar em `.claude/docs/`
- Nomenclatura: `[biblioteca]-llms.txt` (ex: `daisyui-llms.txt`)
- Manter índice atualizado em `docs/llms-sources.md`

### Quando Adicionar Nova Documentação

**Se a documentação tem llms.txt:**
1. Baixar o arquivo: `curl [URL]/llms.txt -o .claude/docs/[nome]-llms.txt`
2. Adicionar entrada no índice com URL e data

**Se a documentação NÃO tem llms.txt:**
1. Criar arquivo `.claude/docs/[nome]-llms.txt`
2. Incluir:
   - Título e descrição da biblioteca
   - Instalação e configuração básica
   - Exemplos de uso mais comuns
   - API/componentes principais
   - Links para documentação oficial
3. Formato: markdown claro e conciso
4. Foco: informações essenciais para uso prático

### Template para Gerar llms.txt

Quando precisar criar um llms.txt de uma biblioteca sem arquivo oficial:

```
# [Nome da Biblioteca]

> [Descrição breve]

## Instalação

[comandos de instalação]

## Uso Básico

[exemplos práticos]

## Componentes/APIs Principais

[lista das funcionalidades mais importantes]

## Exemplos Comuns

[código de exemplos frequentes]

## Referências

- Documentação: [URL]
- GitHub: [URL]
```

### Atualização Automática

Sempre que uma nova biblioteca/framework for mencionada no projeto:
1. Verificar se já existe em `.claude/docs/`
2. Se não existir, perguntar se devo adicionar
3. Buscar se existe llms.txt oficial
4. Criar/baixar e atualizar o índice

### Comandos Úteis

- "adiciona docs de [biblioteca]" → busca e adiciona automaticamente
- "atualiza todas as docs" → revalida todos os arquivos
- "lista docs disponíveis" → mostra índice completo

## 🚀 Otimização de Documentações LLMs

### Detecção Automática de Arquivos Não Otimizados

Claude deve **automaticamente detectar e alertar** quando encontrar:

1. **Arquivo muito grande**: `llms.txt` ou `llms-full.txt` > 200KB
2. **Estrutura pobre**: Menos de 5 headings (#, ##) nos primeiros 1000 caracteres
3. **Conteúdo plano**: Parágrafos contínuos sem organização

### Ação ao Detectar

```markdown
**Mensagem ao usuário**:
"🔍 Detectei que `[arquivo]` não está otimizado ([tamanho] KB, estrutura pobre).

Isso pode dificultar minha leitura eficiente. Posso criar uma versão otimizada?

Ações disponíveis:
1. Criar versão otimizada (recomendado)
2. Manter como está
3. Criar índice de navegação"
```

### Padrão de Otimização

Ao criar versão otimizada de `docs/[lib]/llms.txt`:

1. **Criar arquivo**: `docs/[lib]/llms-optimized.md`
2. **Manter original**: `docs/[lib]/llms.txt` (backup)
3. **Atualizar INDEX.md**: Referenciar versão otimizada

#### Estrutura do Arquivo Otimizado

```markdown
# [Biblioteca] - Guia Otimizado para LLMs
# 📄 Fonte Original: [URL do llms.txt original]
# 📅 Data de otimização: [YYYY-MM-DD]
# 📊 Original: [XXX KB] → Otimizado: [YYY KB] (~XX% redução)
# ⚡ Otimizado para consulta rápida por LLMs

## 🗂️ Navegação Rápida

**Início Rápido**:
- [Instalação](#instalação)
- [Configuração](#configuração)
- [Primeiros Passos](#primeiros-passos)

**Referência**:
- [API Principal](#api-principal)
- [Componentes](#componentes)
- [Hooks/Utilities](#hooks-utilities)

**Prático**:
- [Exemplos Comuns](#exemplos-comuns)
- [Padrões Recomendados](#padrões-recomendados)
- [Troubleshooting](#troubleshooting)

---

## ⚡ Quick Start

### Instalação
```bash
npm install [biblioteca]
```

### Setup Básico
```typescript
// Configuração mínima funcional
import { Main } from '[biblioteca]';

export default function App() {
  return <Main />;
}
```

---

## 📖 Referência Principal

### API Core

#### [FunçãoPrincipal]
**Propósito**: [1 linha]
**Uso**:
```typescript
[código conciso]
```
**Parâmetros importantes**:
- `param1`: [descrição breve]
- `param2`: [descrição breve]

#### [OutraFunção]
...

---

## 💡 Exemplos Práticos

### Caso 1: [Nome do Caso de Uso]
```typescript
// Exemplo funcional completo
// Comentários apenas quando necessário
```

### Caso 2: [Outro Caso]
...

---

## 🔧 Troubleshooting

| Problema | Solução Rápida |
|----------|----------------|
| [Erro comum] | [Fix em 1 linha] |
| [Outro erro] | [Fix em 1 linha] |

---

## 📚 Documentação Completa

Para referência detalhada completa, consulte:
- 📖 Oficial: [link]
- 🌐 Original llms.txt: `docs/[lib]/llms.txt` (backup local)
```

### Regras de Otimização

#### ✅ **MANTER e Priorizar**:
1. Instalação e setup
2. API/componentes principais (top 10-15)
3. Exemplos práticos (3-5 casos comuns)
4. Troubleshooting (5-10 problemas frequentes)
5. Links para docs completas

#### ❌ **REMOVER ou Resumir**:
1. Histórico de versões detalhado → Link para changelog
2. Contribuição guidelines → Link para CONTRIBUTING.md
3. Governança/licença extensas → Manter só licença tipo
4. Exemplos redundantes → Consolidar em 1-2
5. Listas exaustivas → Top 10-15 itens
6. Parágrafos introdutórios longos → Resumir em 2-3 linhas
7. Múltiplos exemplos da mesma coisa → 1 exemplo bem feito

#### 🔄 **REORGANIZAR**:
1. Índice navegável no topo (links âncora)
2. Ordem lógica: Quick Start → API → Exemplos → Troubleshooting
3. Separadores visuais claros (---, ##)
4. Tabelas para informação comparativa
5. Code blocks com syntax highlighting

### Critérios de Qualidade

Documentação otimizada deve ter:
- ✅ **Tamanho**: < 100KB (idealmente 50-80KB)
- ✅ **Estrutura**: Mínimo 10 seções (##) bem definidas
- ✅ **Navegação**: Índice clicável no início
- ✅ **Código**: Apenas exemplos executáveis
- ✅ **Densidade**: Alto sinal/ruído (informação útil/total)

### Script de Otimização

Criar `scripts/optimize-docs.sh`:

```bash
#!/bin/bash
# Otimiza documentação grande

FILE=$1
SIZE=$(wc -c < "$FILE")

if [ $SIZE -gt 200000 ]; then
  echo "⚠️  Arquivo muito grande: $(($SIZE / 1024))KB"
  echo "💡 Criando versão otimizada..."

  # Claude Code irá criar versão otimizada
  # seguindo template acima
fi
```

### Workflow de Otimização

```
1. Detectar arquivo > 200KB ou mal estruturado
   ↓
2. Alertar usuário com tamanho e problema
   ↓
3. Se autorizado:
   ↓
4. Ler arquivo original identificando seções
   ↓
5. Extrair conteúdo essencial:
   - Quick start (10-15%)
   - API principal (40-50%)
   - Exemplos (20-30%)
   - Troubleshooting (10-15%)
   ↓
6. Criar arquivo otimizado com estrutura padrão
   ↓
7. Salvar original como backup
   ↓
8. Atualizar referências (INDEX.md)
   ↓
9. Confirmar redução de tamanho
```

### Como Claude Deve Usar Docs Otimizadas

**Ao buscar informação**:
1. Ler índice primeiro (não o arquivo todo)
2. Identificar seção relevante
3. Ler apenas essa seção
4. Se precisar mais detalhes, consultar original

**Exemplo**:
```
User: "Como configurar Next.js?"

Claude:
1. Abre docs/nextjs/llms-optimized.md
2. Lê índice → encontra "#configuração"
3. Lê apenas seção de configuração
4. Responde com informação dessa seção
(Não lê arquivo completo de 5MB!)
```

## 🎯 Manutenção Contínua

### Quando Re-otimizar

- Nova versão major da biblioteca lançada
- Arquivo original atualizado e cresceu >20%
- Feedbacks de uso indicando falta de informação
- Mudanças significativas na API

### Checklist de Qualidade

Antes de marcar documentação como otimizada:
- [ ] Índice navegável criado
- [ ] Tamanho reduzido em pelo menos 50%
- [ ] Mantém top 10-15 APIs/componentes
- [ ] 3-5 exemplos práticos incluídos
- [ ] Links para docs completas presentes
- [ ] Troubleshooting com 5-10 problemas comuns
- [ ] Código testável (não pseudo-código)
- [ ] Original mantido como backup