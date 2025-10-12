# Jotai - Custom Guide
# Source: https://jotai.org/docs
# Date: 2025-10-12
# Type: Custom guide (no official llms.txt available)

## About Jotai

Jotai is a primitive and flexible state management library for React. It takes an atomic approach to global React state management with a bottom-up approach inspired by Recoil.

## Core Concepts

### Atoms

Atoms are units of state. They can be read from and written to from any component:

```typescript
import { atom } from 'jotai';

// Primitive atom
const countAtom = atom(0);

// Derived atom (read-only)
const doubleCountAtom = atom((get) => get(countAtom) * 2);

// Derived atom (read-write)
const incrementAtom = atom(
  (get) => get(countAtom),
  (get, set) => set(countAtom, get(countAtom) + 1)
);
```

### Using Atoms in Components

```typescript
import { useAtom, useAtomValue, useSetAtom } from 'jotai';

function Counter() {
  // Read and write
  const [count, setCount] = useAtom(countAtom);

  // Read only
  const double = useAtomValue(doubleCountAtom);

  // Write only (better performance)
  const increment = useSetAtom(incrementAtom);

  return (
    <div>
      <p>Count: {count}</p>
      <p>Double: {double}</p>
      <button onClick={() => setCount(c => c + 1)}>Increment</button>
      <button onClick={increment}>Increment (write-only)</button>
    </div>
  );
}
```

## TypeScript Support

```typescript
// Type-safe atoms
interface User {
  id: string;
  name: string;
  email: string;
}

const userAtom = atom<User | null>(null);

// Derived atoms with types
const userNameAtom = atom(
  (get) => get(userAtom)?.name ?? 'Guest'
);
```

## Persistent Storage

```typescript
import { atomWithStorage } from 'jotai/utils';

// Persists to localStorage
const themeAtom = atomWithStorage<'light' | 'dark'>('theme', 'light');

// Custom storage
const userAtom = atomWithStorage<User | null>(
  'user',
  null,
  {
    getItem: (key) => {
      const value = localStorage.getItem(key);
      return value ? JSON.parse(value) : null;
    },
    setItem: (key, value) => {
      localStorage.setItem(key, JSON.stringify(value));
    },
    removeItem: (key) => {
      localStorage.removeItem(key);
    },
  }
);
```

## Async Atoms

```typescript
// Async read
const userDataAtom = atom(async (get) => {
  const userId = get(userIdAtom);
  const response = await fetch(`/api/users/${userId}`);
  return response.json();
});

// Use with Suspense
function UserProfile() {
  const userData = useAtomValue(userDataAtom); // Suspends until loaded
  return <div>{userData.name}</div>;
}

function App() {
  return (
    <Suspense fallback={<LoadingSpinner />}>
      <UserProfile />
    </Suspense>
  );
}
```

## Common Patterns

### Form State Management

```typescript
// Form atoms
const emailAtom = atom('');
const passwordAtom = atom('');

// Derived validation
const isValidAtom = atom((get) => {
  const email = get(emailAtom);
  const password = get(passwordAtom);
  return email.includes('@') && password.length >= 8;
});

function LoginForm() {
  const [email, setEmail] = useAtom(emailAtom);
  const [password, setPassword] = useAtom(passwordAtom);
  const isValid = useAtomValue(isValidAtom);

  return (
    <form>
      <input value={email} onChange={(e) => setEmail(e.target.value)} />
      <input value={password} onChange={(e) => setPassword(e.target.value)} />
      <button disabled={!isValid}>Login</button>
    </form>
  );
}
```

### Authentication State

```typescript
interface AuthUser {
  id: string;
  email: string;
  role: string;
}

// Persistent auth state
export const authUserAtom = atomWithStorage<AuthUser | null>(
  'auth-user',
  null
);

// Derived atoms
export const isAuthenticatedAtom = atom(
  (get) => get(authUserAtom) !== null
);

export const userRoleAtom = atom(
  (get) => get(authUserAtom)?.role ?? null
);

// Auth actions
export const logoutAtom = atom(
  null,
  (get, set) => {
    set(authUserAtom, null);
  }
);
```

### Loading States

```typescript
const isLoadingAtom = atom(false);
const errorAtom = atom<Error | null>(null);
const dataAtom = atom<Data[]>([]);

// Fetch action
const fetchDataAtom = atom(
  null,
  async (get, set) => {
    set(isLoadingAtom, true);
    set(errorAtom, null);

    try {
      const response = await fetch('/api/data');
      const data = await response.json();
      set(dataAtom, data);
    } catch (error) {
      set(errorAtom, error as Error);
    } finally {
      set(isLoadingAtom, false);
    }
  }
);
```

## Organizing Atoms

### Feature-Based Structure

```typescript
// src/state/authAtoms.ts
export const authUserAtom = atomWithStorage<User | null>('auth-user', null);
export const isAuthenticatedAtom = atom((get) => get(authUserAtom) !== null);

// src/state/themeAtoms.ts
export const themeAtom = atomWithStorage<'light' | 'dark'>('theme', 'light');
export const isDarkModeAtom = atom((get) => get(themeAtom) === 'dark');

// src/state/index.ts
export * from './authAtoms';
export * from './themeAtoms';
```

## Advanced Features

### Atom Families

```typescript
import { atomFamily } from 'jotai/utils';

// Create atoms dynamically
const todoAtomFamily = atomFamily((id: string) =>
  atom({ id, text: '', completed: false })
);

function Todo({ id }: { id: string }) {
  const [todo, setTodo] = useAtom(todoAtomFamily(id));
  return <div>{todo.text}</div>;
}
```

### Reset to Default

```typescript
import { RESET } from 'jotai/utils';

const countAtom = atom(0);

function Counter() {
  const [count, setCount] = useAtom(countAtom);

  return (
    <div>
      <p>{count}</p>
      <button onClick={() => setCount(c => c + 1)}>+1</button>
      <button onClick={() => setCount(RESET)}>Reset</button>
    </div>
  );
}
```

### Atom with Reducer

```typescript
import { atomWithReducer } from 'jotai/utils';

type Action =
  | { type: 'INCREMENT' }
  | { type: 'DECREMENT' }
  | { type: 'SET'; value: number };

const counterAtom = atomWithReducer(
  0,
  (state, action: Action) => {
    switch (action.type) {
      case 'INCREMENT': return state + 1;
      case 'DECREMENT': return state - 1;
      case 'SET': return action.value;
      default: return state;
    }
  }
);
```

## Debugging

```typescript
import { useAtomValue } from 'jotai';
import { useAtomDevtools } from 'jotai-devtools';

function DebugAtom({ atom, name }: { atom: Atom<any>, name: string }) {
  useAtomDevtools(atom, { name });
  return null;
}

// In your app
<DebugAtom atom={authUserAtom} name="Auth User" />
```

## Performance Tips

1. **Use `useSetAtom` for write-only** - Avoids re-renders
2. **Split atoms** - Keep atoms small and focused
3. **Use derived atoms** - Don't duplicate state
4. **Avoid unnecessary reads** - Only read atoms you need
5. **Use atom families** - For dynamic collections

## Best Practices

1. **Co-locate atoms** - Keep atoms near components that use them
2. **Name atoms clearly** - Use descriptive names ending in "Atom"
3. **Type everything** - Use TypeScript for type safety
4. **Use atomWithStorage** - For persistent state
5. **Prefer derived atoms** - Over storing computed values
6. **Split state** - Don't create god atoms

## Common Use Cases in This Project

### Theme Management

```typescript
import { atomWithStorage } from 'jotai/utils';

export const themeAtom = atomWithStorage<'light' | 'dark'>('theme', 'light');
```

### Authentication

```typescript
export const authUserAtom = atomWithStorage<User | null>('auth-user', null);
export const isAuthenticatedAtom = atom((get) => get(authUserAtom) !== null);
```

### Form State

```typescript
export const formDataAtom = atom({
  name: '',
  email: '',
  role: 'recantiano' as const,
});
```

## Resources

- [Jotai Documentation](https://jotai.org/docs)
- [Jotai GitHub](https://github.com/pmndrs/jotai)
- [Jotai Devtools](https://jotai.org/docs/tools/devtools)
- [Comparison with other libraries](https://jotai.org/docs/basics/comparison)
