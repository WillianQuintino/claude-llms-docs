# React - Documentação Customizada para o Projeto
# Fonte: https://react.dev/reference/react
# Data de criação: 2025-10-10
# Versão: React 18+
# Tipo: Documentação customizada (não existe llms.txt oficial)

## Sobre React

React é uma biblioteca JavaScript para construir interfaces de usuário. Este guia foca nos recursos usados no projeto.

## Hooks Essenciais Usados no Projeto

### useState
Gerencia estado local em componentes
```tsx
const [state, setState] = useState<Type>(initialValue);
```

### useEffect
Executa efeitos colaterais em componentes
```tsx
useEffect(() => {
  // código do efeito
  return () => {
    // cleanup (opcional)
  };
}, [dependencies]);
```

### useContext
Consome valores de contexto
```tsx
const value = useContext(MyContext);
```

### useRef
Referência mutável que persiste entre renders
```tsx
const ref = useRef<HTMLDivElement>(null);
```

### useMemo
Memoiza valores computados
```tsx
const memoizedValue = useMemo(() => computeExpensiveValue(a, b), [a, b]);
```

### useCallback
Memoiza funções
```tsx
const memoizedCallback = useCallback(() => {
  doSomething(a, b);
}, [a, b]);
```

## Componentes no Projeto

### Server Components (Next.js App Router)
```tsx
// app/page.tsx
export default async function Page() {
  const data = await fetchData();
  return <div>{data}</div>;
}
```

### Client Components
```tsx
'use client';

import { useState } from 'react';

export default function ClientComponent() {
  const [count, setCount] = useState(0);
  return <button onClick={() => setCount(count + 1)}>{count}</button>;
}
```

## TypeScript com React

### Props Typing
```tsx
interface ButtonProps {
  label: string;
  onClick: () => void;
  disabled?: boolean;
}

const Button: React.FC<ButtonProps> = ({ label, onClick, disabled }) => {
  return <button onClick={onClick} disabled={disabled}>{label}</button>;
};
```

### Children
```tsx
interface LayoutProps {
  children: React.ReactNode;
}

const Layout: React.FC<LayoutProps> = ({ children }) => {
  return <div>{children}</div>;
};
```

## Event Handling

```tsx
// Mouse events
onClick: React.MouseEventHandler<HTMLButtonElement>
onMouseEnter: React.MouseEventHandler<HTMLDivElement>

// Form events
onChange: React.ChangeEventHandler<HTMLInputElement>
onSubmit: React.FormEventHandler<HTMLFormElement>

// Keyboard events
onKeyDown: React.KeyboardEventHandler<HTMLInputElement>
```

## Boas Práticas no Projeto

1. **Use TypeScript**: Sempre defina tipos para props e state
2. **Client Components**: Adicione `'use client'` quando usar hooks ou interatividade
3. **Server Components**: Use por padrão, são mais performáticos
4. **Evite re-renders**: Use `useMemo` e `useCallback` quando necessário
5. **Key prop**: Sempre use `key` em listas

## Referências

- [React Documentation](https://react.dev/)
- [React Reference](https://react.dev/reference/react)
- [Next.js + React](https://nextjs.org/docs/app/building-your-application/rendering)
