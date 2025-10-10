# NextAuth.js - Documentação Customizada para o Projeto
# Fonte: https://next-auth.js.org/
# Data de criação: 2025-10-10
# Versão: NextAuth.js v4
# Tipo: Documentação customizada (não existe llms.txt oficial)

## Sobre NextAuth.js

NextAuth.js é uma solução completa de autenticação para Next.js. Este projeto usa NextAuth v4 com Credentials Provider e MySQL.

## Configuração no Projeto

**Arquivo**: `apps/web/app/api/auth/[...nextauth]/route.ts`

```typescript
import NextAuth, { NextAuthOptions } from 'next-auth';
import CredentialsProvider from 'next-auth/providers/credentials';
import bcrypt from 'bcryptjs';
import { getConnection } from '@/lib/database';

export const authOptions: NextAuthOptions = {
  providers: [
    CredentialsProvider({
      name: 'Credentials',
      credentials: {
        email: { label: "Email", type: "email" },
        password: { label: "Password", type: "password" }
      },
      async authorize(credentials) {
        // Validação e autenticação
        const conn = await getConnection();
        const [rows] = await conn.execute(
          'SELECT * FROM users WHERE email = ?',
          [credentials?.email]
        );

        const user = rows[0];
        if (!user) return null;

        const isValid = await bcrypt.compare(
          credentials?.password || '',
          user.password
        );

        if (!isValid) return null;

        return {
          id: user.id.toString(),
          email: user.email,
          name: user.name,
          role: user.role,
        };
      }
    })
  ],
  callbacks: {
    async jwt({ token, user }) {
      if (user) {
        token.id = user.id;
        token.role = user.role;
      }
      return token;
    },
    async session({ session, token }) {
      if (session.user) {
        session.user.id = token.id as string;
        session.user.role = token.role as string;
      }
      return session;
    }
  },
  pages: {
    signIn: '/auth/login',
  },
  session: {
    strategy: 'jwt',
  },
  secret: process.env.NEXTAUTH_SECRET,
};

const handler = NextAuth(authOptions);
export { handler as GET, handler as POST };
```

## Type Extensions

**Arquivo**: `apps/web/types/next-auth.d.ts`

```typescript
import 'next-auth';
import 'next-auth/jwt';

declare module 'next-auth' {
  interface User {
    id: string;
    role: string;
  }

  interface Session {
    user: {
      id: string;
      email: string;
      name: string;
      role: string;
    };
  }
}

declare module 'next-auth/jwt' {
  interface JWT {
    id: string;
    role: string;
  }
}
```

## Uso em Server Components

```typescript
import { getServerSession } from 'next-auth';
import { authOptions } from '@/app/api/auth/[...nextauth]/route';

export default async function DashboardPage() {
  const session = await getServerSession(authOptions);

  if (!session) {
    redirect('/auth/login');
  }

  return <div>Welcome {session.user.name}</div>;
}
```

## Uso em Client Components

```typescript
'use client';

import { useSession, signIn, signOut } from 'next-auth/react';

export default function LoginButton() {
  const { data: session, status } = useSession();

  if (status === 'loading') {
    return <div>Loading...</div>;
  }

  if (session) {
    return (
      <button onClick={() => signOut()}>
        Sign out {session.user.name}
      </button>
    );
  }

  return <button onClick={() => signIn()}>Sign in</button>;
}
```

## Middleware para Proteção de Rotas

**Arquivo**: `apps/web/middleware.ts`

```typescript
import { withAuth } from 'next-auth/middleware';

export default withAuth({
  pages: {
    signIn: '/auth/login',
  },
});

export const config = {
  matcher: ['/dashboard/:path*'],
};
```

## Login Form

```typescript
'use client';

import { signIn } from 'next-auth/react';
import { useState } from 'react';

export default function LoginForm() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    const result = await signIn('credentials', {
      email,
      password,
      redirect: false,
    });

    if (result?.error) {
      console.error('Login failed:', result.error);
    } else {
      window.location.href = '/dashboard';
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="email"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        placeholder="Email"
      />
      <input
        type="password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        placeholder="Password"
      />
      <button type="submit">Login</button>
    </form>
  );
}
```

## Verificação de Permissões

```typescript
import { getServerSession } from 'next-auth';
import { authOptions } from '@/app/api/auth/[...nextauth]/route';

export async function requireAdmin() {
  const session = await getServerSession(authOptions);

  if (!session || session.user.role !== 'admin') {
    throw new Error('Unauthorized');
  }

  return session;
}
```

## Credenciais Padrão do Projeto

```env
# Admin user
ADMIN_EMAIL=admin@admin.com
ADMIN_PASSWORD=admin@5550123
ADMIN_NAME=Administrator

# NextAuth
NEXTAUTH_SECRET=your-secret-key
NEXTAUTH_URL=http://localhost:3000
```

## Callbacks Importantes

### JWT Callback
Chamado quando um JWT é criado ou atualizado
```typescript
async jwt({ token, user, account }) {
  // Adicionar dados customizados ao token
  return token;
}
```

### Session Callback
Chamado quando uma sessão é verificada
```typescript
async session({ session, token }) {
  // Adicionar dados do token à sessão
  return session;
}
```

## Boas Práticas

1. **Sempre use HTTPS** em produção
2. **Secret forte**: Use `NEXTAUTH_SECRET` complexo
3. **Type Safety**: Estenda os tipos do NextAuth
4. **Server-side**: Prefira `getServerSession()` em Server Components
5. **Client-side**: Use `useSession()` em Client Components
6. **Middleware**: Proteja rotas com middleware
7. **Password Hashing**: Use bcryptjs com salt rounds >= 12

## Referências

- [NextAuth.js Documentation](https://next-auth.js.org/)
- [Getting Started](https://next-auth.js.org/getting-started/introduction)
- [Credentials Provider](https://next-auth.js.org/providers/credentials)
