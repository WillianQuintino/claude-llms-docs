# SWR - Custom Guide
# Source: https://swr.vercel.app
# Date: 2025-10-12
# Type: Custom guide (no official llms.txt available)

## About SWR

SWR (stale-while-revalidate) is a React Hooks library for data fetching. It provides a simple and powerful way to fetch data with built-in caching, revalidation, focus tracking, refetching on interval, and more.

## Installation

```bash
npm install swr
```

## Basic Usage

```typescript
import useSWR from 'swr';

// Fetcher function
const fetcher = (url: string) => fetch(url).then(res => res.json());

function Profile() {
  const { data, error, isLoading } = useSWR('/api/user', fetcher);

  if (error) return <div>Failed to load</div>;
  if (isLoading) return <div>Loading...</div>;

  return <div>Hello {data.name}!</div>;
}
```

## TypeScript Support

```typescript
interface User {
  id: string;
  name: string;
  email: string;
}

function Profile() {
  const { data, error, isLoading } = useSWR<User>('/api/user', fetcher);

  return <div>{data?.name}</div>; // Type-safe
}
```

## Global Configuration

```typescript
import { SWRConfig } from 'swr';

function App() {
  return (
    <SWRConfig
      value={{
        fetcher: (url: string) => fetch(url).then(res => res.json()),
        revalidateOnFocus: false,
        refreshInterval: 0,
      }}
    >
      <Component />
    </SWRConfig>
  );
}
```

## Common Patterns

### With Axios

```typescript
import axios from 'axios';

const fetcher = (url: string) => axios.get(url).then(res => res.data);

function Component() {
  const { data } = useSWR('/api/data', fetcher);
  return <div>{data}</div>;
}
```

### With Firebase

```typescript
import { doc, getDoc } from 'firebase/firestore';
import { db } from '@/lib/firebase';

const firestoreFetcher = async (path: string) => {
  const docRef = doc(db, path);
  const docSnap = await getDoc(docRef);
  return docSnap.exists() ? docSnap.data() : null;
};

function UserProfile({ userId }: { userId: string }) {
  const { data } = useSWR(`users/${userId}`, firestoreFetcher);
  return <div>{data?.name}</div>;
}
```

### Conditional Fetching

```typescript
// Only fetch when userId is available
function Profile({ userId }: { userId: string | null }) {
  const { data } = useSWR(
    userId ? `/api/users/${userId}` : null,
    fetcher
  );

  if (!userId) return <div>Please login</div>;
  if (!data) return <div>Loading...</div>;

  return <div>{data.name}</div>;
}
```

### Dependent Requests

```typescript
function UserRepos({ userId }: { userId: string }) {
  // Fetch user first
  const { data: user } = useSWR(`/api/users/${userId}`, fetcher);

  // Then fetch repos (only when user is loaded)
  const { data: repos } = useSWR(
    user ? `/api/users/${user.id}/repos` : null,
    fetcher
  );

  return <div>{repos?.length} repos</div>;
}
```

## Mutations

### Manual Mutation

```typescript
import { mutate } from 'swr';

async function updateUser(id: string, data: Partial<User>) {
  // Optimistic update
  mutate(`/api/users/${id}`, { ...data }, false);

  // Send request
  await fetch(`/api/users/${id}`, {
    method: 'PATCH',
    body: JSON.stringify(data),
  });

  // Revalidate
  mutate(`/api/users/${id}`);
}
```

### Using `useSWRMutation`

```typescript
import useSWRMutation from 'swr/mutation';

async function updateUser(url: string, { arg }: { arg: Partial<User> }) {
  return fetch(url, {
    method: 'PATCH',
    body: JSON.stringify(arg),
  }).then(res => res.json());
}

function EditProfile() {
  const { trigger, isMutating } = useSWRMutation('/api/user', updateUser);

  return (
    <button
      disabled={isMutating}
      onClick={() => trigger({ name: 'New Name' })}
    >
      Update
    </button>
  );
}
```

### Optimistic UI

```typescript
import { useSWRConfig } from 'swr';

function TodoList() {
  const { data: todos } = useSWR<Todo[]>('/api/todos', fetcher);
  const { mutate } = useSWRConfig();

  const addTodo = async (text: string) => {
    const newTodo = { id: Date.now(), text, done: false };

    // Optimistically update UI
    mutate('/api/todos', [...(todos || []), newTodo], false);

    // Send to server
    await fetch('/api/todos', {
      method: 'POST',
      body: JSON.stringify(newTodo),
    });

    // Revalidate
    mutate('/api/todos');
  };

  return <div>{/* ... */}</div>;
}
```

## Pagination

```typescript
function UserList() {
  const [pageIndex, setPageIndex] = useState(0);

  const { data, error, isLoading } = useSWR(
    `/api/users?page=${pageIndex}`,
    fetcher
  );

  return (
    <div>
      {data?.users.map(user => <div key={user.id}>{user.name}</div>)}
      <button onClick={() => setPageIndex(i => i - 1)}>Previous</button>
      <button onClick={() => setPageIndex(i => i + 1)}>Next</button>
    </div>
  );
}
```

## Infinite Loading

```typescript
import useSWRInfinite from 'swr/infinite';

function InfiniteList() {
  const getKey = (pageIndex: number, previousPageData: any) => {
    if (previousPageData && !previousPageData.hasMore) return null;
    return `/api/items?page=${pageIndex}`;
  };

  const { data, size, setSize, isLoading } = useSWRInfinite(getKey, fetcher);

  const items = data ? data.flatMap(page => page.items) : [];
  const hasMore = data?.[data.length - 1]?.hasMore;

  return (
    <div>
      {items.map(item => <div key={item.id}>{item.name}</div>)}
      {hasMore && (
        <button onClick={() => setSize(size + 1)}>Load More</button>
      )}
    </div>
  );
}
```

## Prefetching

```typescript
import { mutate } from 'swr';

// Prefetch on hover
function UserLink({ userId }: { userId: string }) {
  const prefetch = () => {
    mutate(`/api/users/${userId}`, fetcher(`/api/users/${userId}`));
  };

  return (
    <a href={`/users/${userId}`} onMouseEnter={prefetch}>
      View Profile
    </a>
  );
}
```

## Error Handling

```typescript
function Profile() {
  const { data, error } = useSWR('/api/user', fetcher, {
    onError: (err) => {
      console.error('Failed to fetch:', err);
    },
    onErrorRetry: (error, key, config, revalidate, { retryCount }) => {
      // Never retry on 404
      if (error.status === 404) return;

      // Only retry up to 10 times
      if (retryCount >= 10) return;

      // Retry after 5 seconds
      setTimeout(() => revalidate({ retryCount }), 5000);
    },
  });

  if (error) return <ErrorMessage error={error} />;
  return <div>{data?.name}</div>;
}
```

## Revalidation

```typescript
import { useSWRConfig } from 'swr';

function Component() {
  const { mutate } = useSWRConfig();

  // Revalidate specific key
  const refresh = () => mutate('/api/user');

  // Revalidate all keys
  const refreshAll = () => mutate(() => true);

  return <button onClick={refresh}>Refresh</button>;
}
```

## Auto Revalidation

```typescript
useSWR('/api/user', fetcher, {
  refreshInterval: 1000,              // Poll every second
  revalidateOnFocus: true,            // Revalidate on window focus
  revalidateOnReconnect: true,        // Revalidate on network reconnect
  revalidateIfStale: true,            // Revalidate if data is stale
  dedupingInterval: 2000,             // Dedupe requests within 2s
});
```

## Suspense Mode

```typescript
function Profile() {
  const { data } = useSWR('/api/user', fetcher, { suspense: true });
  // No need to check loading state
  return <div>{data.name}</div>;
}

function App() {
  return (
    <Suspense fallback={<Loading />}>
      <Profile />
    </Suspense>
  );
}
```

## Best Practices

1. **Use semantic keys** - Keys should describe the data
2. **Global fetcher** - Configure once in SWRConfig
3. **Dedupe requests** - SWR automatically deduplicates
4. **Optimistic updates** - For better UX
5. **Error boundaries** - Handle errors gracefully
6. **Prefetch on hover** - Improve perceived performance
7. **TypeScript** - Always type your data

## Common Use Cases in This Project

### Firebase Integration

```typescript
const firebaseFetcher = async (path: string) => {
  const docRef = doc(db, path);
  const docSnap = await getDoc(docRef);
  return docSnap.data();
};

const { data: user } = useSWR(`users/${userId}`, firebaseFetcher);
```

### Protected Routes

```typescript
function ProtectedData() {
  const { data: session } = useSWR('/api/auth/session', fetcher);

  const { data } = useSWR(
    session ? '/api/protected-data' : null,
    fetcher
  );

  return <div>{data}</div>;
}
```

### Real-time Updates

```typescript
useSWR('/api/events', fetcher, {
  refreshInterval: 5000, // Poll every 5 seconds
  revalidateOnFocus: true,
});
```

## Resources

- [SWR Documentation](https://swr.vercel.app)
- [SWR Examples](https://swr.vercel.app/examples/basic)
- [API Reference](https://swr.vercel.app/docs/api)
- [TypeScript Guide](https://swr.vercel.app/docs/typescript)
