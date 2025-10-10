# Next.js 15+ - Guia Otimizado para LLMs (App Router)
# 📄 Fonte Original: https://nextjs.org/docs/llms-full.txt
# 📅 Data de otimização: 2025-10-10
# 📊 Original: 2.7 MB → Otimizado: ~80 KB (~97% redução)
# ⚡ Otimizado para consulta rápida por LLMs
# 🎯 Foco: Next.js 15+ com App Router, React 19, Turbopack

## 🗂️ Navegação Rápida

**Início Rápido**:
- [Instalação](#instalação)
- [Estrutura de Projeto](#estrutura-de-projeto)
- [Criar Primeira Página](#criar-primeira-página)

**Core Concepts**:
- [Server vs Client Components](#server-vs-client-components)
- [Routing e Navegação](#routing-e-navegação)
- [Layouts e Templates](#layouts-e-templates)
- [Data Fetching](#data-fetching)

**APIs Essenciais**:
- [Route Handlers (API)](#route-handlers)
- [Server Actions](#server-actions)
- [Middleware](#middleware)
- [Image Optimization](#image-optimization)

**Prático**:
- [Exemplos Comuns](#exemplos-comuns)
- [Padrões Recomendados](#padrões-recomendados)
- [Troubleshooting](#troubleshooting)

---

## ⚡ Quick Start

### Instalação

```bash
# Criar novo projeto
npx create-next-app@latest

# Ou manualmente
pnpm add next@latest react@latest react-dom@latest
```

**package.json scripts**:
```json
{
  "scripts": {
    "dev": "next dev --turbopack",
    "build": "next build",
    "start": "next start"
  }
}
```

### Estrutura de Projeto

```
app/
├── layout.tsx          # Root layout (obrigatório)
├── page.tsx            # Homepage (/)
├── loading.tsx         # Loading UI
├── error.tsx           # Error UI
├── not-found.tsx       # 404 page
│
├── dashboard/
│   ├── layout.tsx      # Layout do dashboard
│   ├── page.tsx        # /dashboard
│   └── users/
│       └── page.tsx    # /dashboard/users
│
└── api/
    └── users/
        └── route.ts    # API endpoint
```

### Criar Primeira Página

**app/layout.tsx** (obrigatório):
```tsx
export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  )
}
```

**app/page.tsx**:
```tsx
export default function HomePage() {
  return <h1>Hello Next.js 15!</h1>
}
```

---

## 📖 Core Concepts

### Server vs Client Components

**Server Components (padrão)**:
```tsx
// app/page.tsx - Server Component por padrão
export default async function Page() {
  const data = await fetch('https://api.example.com/data')
  const json = await data.json()

  return <div>{json.title}</div>
}
```

**Client Components** (use `'use client'`):
```tsx
'use client'

import { useState } from 'react'

export default function Counter() {
  const [count, setCount] = useState(0)

  return (
    <button onClick={() => setCount(count + 1)}>
      Count: {count}
    </button>
  )
}
```

**Quando usar**:
- **Server**: Data fetching, acesso a DB, lógica backend
- **Client**: Interatividade (onClick, useState), browser APIs

### Routing e Navegação

**File-system routing**:
```
app/
├── page.tsx           # /
├── about/page.tsx     # /about
└── blog/
    ├── page.tsx       # /blog
    └── [slug]/
        └── page.tsx   # /blog/:slug (dynamic)
```

**Link Component**:
```tsx
import Link from 'next/link'

export default function Nav() {
  return (
    <nav>
      <Link href="/">Home</Link>
      <Link href="/about">About</Link>
      <Link href="/blog/hello">Blog Post</Link>
    </nav>
  )
}
```

**Programmatic Navigation**:
```tsx
'use client'

import { useRouter } from 'next/navigation'

export default function Button() {
  const router = useRouter()

  return (
    <button onClick={() => router.push('/dashboard')}>
      Go to Dashboard
    </button>
  )
}
```

**Dynamic Routes**:
```tsx
// app/blog/[slug]/page.tsx
export default function BlogPost({
  params,
}: {
  params: { slug: string }
}) {
  return <h1>Post: {params.slug}</h1>
}

// Gera paths estáticos no build
export async function generateStaticParams() {
  const posts = await getPosts()

  return posts.map((post) => ({
    slug: post.slug,
  }))
}
```

### Layouts e Templates

**Layout** (compartilhado, não re-renderiza):
```tsx
// app/dashboard/layout.tsx
export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <div>
      <nav>Dashboard Nav</nav>
      <main>{children}</main>
    </div>
  )
}
```

**Template** (re-renderiza a cada navegação):
```tsx
// app/dashboard/template.tsx
export default function Template({ children }: { children: React.ReactNode }) {
  return <div>{children}</div>
}
```

### Data Fetching

**Server Component** (recomendado):
```tsx
export default async function Page() {
  // Cached por padrão
  const data = await fetch('https://api.example.com/data')
  const json = await data.json()

  return <div>{json.title}</div>
}
```

**Com revalidação**:
```tsx
export default async function Page() {
  // Revalida a cada 60 segundos
  const data = await fetch('https://api.example.com/data', {
    next: { revalidate: 60 }
  })

  return <div>{data.title}</div>
}
```

**Sem cache**:
```tsx
// Sempre fresh data
const data = await fetch('https://api.example.com/data', {
  cache: 'no-store'
})
```

---

## 🔌 APIs Essenciais

### Route Handlers

**app/api/users/route.ts**:
```typescript
import { NextResponse } from 'next/server'

// GET /api/users
export async function GET(request: Request) {
  const users = await getUsers()
  return NextResponse.json(users)
}

// POST /api/users
export async function POST(request: Request) {
  const body = await request.json()
  const user = await createUser(body)
  return NextResponse.json(user, { status: 201 })
}

// DELETE /api/users/[id]
export async function DELETE(
  request: Request,
  { params }: { params: { id: string } }
) {
  await deleteUser(params.id)
  return new NextResponse(null, { status: 204 })
}
```

**Com autenticação**:
```typescript
import { getServerSession } from 'next-auth'
import { authOptions } from '@/app/api/auth/[...nextauth]/route'

export async function GET(request: Request) {
  const session = await getServerSession(authOptions)

  if (!session) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
  }

  const data = await getData(session.user.id)
  return NextResponse.json(data)
}
```

### Server Actions

**Form com Server Action**:
```tsx
// app/actions.ts
'use server'

import { revalidatePath } from 'next/cache'

export async function createUser(formData: FormData) {
  const name = formData.get('name')
  const email = formData.get('email')

  await db.user.create({
    data: { name, email }
  })

  revalidatePath('/users')
}

// app/page.tsx
import { createUser } from './actions'

export default function Page() {
  return (
    <form action={createUser}>
      <input name="name" required />
      <input name="email" type="email" required />
      <button type="submit">Create User</button>
    </form>
  )
}
```

**Com validação (Zod)**:
```tsx
'use server'

import { z } from 'zod'

const UserSchema = z.object({
  name: z.string().min(3),
  email: z.string().email(),
})

export async function createUser(formData: FormData) {
  const validated = UserSchema.parse({
    name: formData.get('name'),
    email: formData.get('email'),
  })

  await db.user.create({ data: validated })
}
```

### Middleware

**middleware.ts** (na raiz do projeto):
```typescript
import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'

export function middleware(request: NextRequest) {
  // Verificar autenticação
  const token = request.cookies.get('token')

  if (!token && request.nextUrl.pathname.startsWith('/dashboard')) {
    return NextResponse.redirect(new URL('/login', request.url))
  }

  return NextResponse.next()
}

export const config = {
  matcher: ['/dashboard/:path*']
}
```

### Image Optimization

```tsx
import Image from 'next/image'

export default function Avatar() {
  return (
    <Image
      src="/profile.jpg"
      alt="Profile"
      width={200}
      height={200}
      priority // Para LCP
    />
  )
}
```

**Com remote images**:
```tsx
// next.config.js
module.exports = {
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'example.com',
      },
    ],
  },
}

// Component
<Image
  src="https://example.com/image.jpg"
  alt="Remote image"
  width={500}
  height={300}
/>
```

---

## 💡 Exemplos Comuns

### 1. Página com Data Fetching

```tsx
// app/users/page.tsx
export default async function UsersPage() {
  const users = await fetch('https://api.example.com/users').then(r => r.json())

  return (
    <div>
      <h1>Users</h1>
      <ul>
        {users.map((user) => (
          <li key={user.id}>{user.name}</li>
        ))}
      </ul>
    </div>
  )
}
```

### 2. Formulário com Server Action

```tsx
// app/actions.ts
'use server'

export async function createPost(formData: FormData) {
  const title = formData.get('title')
  const content = formData.get('content')

  await db.post.create({
    data: { title, content }
  })

  redirect('/posts')
}

// app/posts/new/page.tsx
import { createPost } from '@/app/actions'

export default function NewPost() {
  return (
    <form action={createPost}>
      <input name="title" placeholder="Title" required />
      <textarea name="content" placeholder="Content" required />
      <button type="submit">Create Post</button>
    </form>
  )
}
```

### 3. Layout com Navegação

```tsx
// app/dashboard/layout.tsx
import Link from 'next/link'

export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <div className="flex">
      <nav className="w-64">
        <Link href="/dashboard">Dashboard</Link>
        <Link href="/dashboard/users">Users</Link>
        <Link href="/dashboard/settings">Settings</Link>
      </nav>
      <main className="flex-1">{children}</main>
    </div>
  )
}
```

### 4. API Route com Database

```typescript
// app/api/posts/route.ts
import { NextResponse } from 'next/server'
import { prisma } from '@/lib/prisma'

export async function GET() {
  const posts = await prisma.post.findMany({
    orderBy: { createdAt: 'desc' }
  })

  return NextResponse.json(posts)
}

export async function POST(request: Request) {
  const body = await request.json()

  const post = await prisma.post.create({
    data: {
      title: body.title,
      content: body.content,
    }
  })

  return NextResponse.json(post, { status: 201 })
}
```

---

## 🎯 Padrões Recomendados

### Estrutura de Pastas

```
app/
├── (auth)/              # Route group (não afeta URL)
│   ├── login/
│   └── register/
├── (dashboard)/
│   ├── layout.tsx
│   ├── users/
│   └── settings/
├── _components/         # Private folder (não roteável)
│   ├── Button.tsx
│   └── Card.tsx
├── api/
└── layout.tsx
```

### Separação de Concerns

```tsx
// ✅ Bom: Server Component busca dados
export default async function Page() {
  const data = await fetchData()
  return <ClientComponent data={data} />
}

// ❌ Evitar: Client Component fazendo fetch
'use client'
export default function Page() {
  const [data, setData] = useState(null)

  useEffect(() => {
    fetch('/api/data').then(...)
  }, [])
}
```

### Error Handling

```tsx
// app/error.tsx - Erro específico da rota
'use client'

export default function Error({
  error,
  reset,
}: {
  error: Error
  reset: () => void
}) {
  return (
    <div>
      <h2>Something went wrong!</h2>
      <button onClick={() => reset()}>Try again</button>
    </div>
  )
}

// app/global-error.tsx - Erro global
'use client'

export default function GlobalError({
  error,
  reset,
}: {
  error: Error
  reset: () => void
}) {
  return (
    <html>
      <body>
        <h2>Application Error!</h2>
        <button onClick={() => reset()}>Try again</button>
      </body>
    </html>
  )
}
```

---

## 🔧 Troubleshooting

| Problema | Solução |
|----------|---------|
| `Error: useState in Server Component` | Adicione `'use client'` no topo do arquivo |
| `Error: cookies() in Client Component` | Use Server Component ou Route Handler |
| Hydration mismatch | Verifique diferenças entre server/client render |
| Layout não re-renderiza | Use `template.tsx` ao invés de `layout.tsx` |
| Cache muito agressivo | Use `{cache: 'no-store'}` ou `revalidate: 0` |
| Dynamic route não funciona | Verifique nome da pasta: `[param]` não `{param}` |
| Middleware não executa | Verifique `matcher` no config |
| Image não carrega | Adicione domínio em `next.config.js` > `images.remotePatterns` |

---

## 📚 Documentação Completa

**Para referência detalhada**:
- 📖 [Documentação Oficial Next.js](https://nextjs.org/docs)
- 🌐 [llms-full.txt original](./llms-full.txt) (backup local - 2.7MB)
- 📺 [Next.js Learn Course](https://nextjs.org/learn)
- 🐙 [GitHub Examples](https://github.com/vercel/next.js/tree/canary/examples)

**Tópicos Avançados** (consulte docs completas):
- Partial Prerendering (PPR)
- Streaming e Suspense
- Route Groups avançados
- Parallel Routes
- Intercepting Routes
- Incremental Static Regeneration (ISR)
- Edge Runtime
- Instrumentation
- Testing

---

**Versão Next.js**: 15.0.0+
**Router**: App Router
**React**: 19.0.0+
**Última atualização**: 2025-10-10
