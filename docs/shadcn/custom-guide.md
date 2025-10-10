# Shadcn UI - Documentação Customizada para o Projeto
# Fonte: https://ui.shadcn.com/docs
# Data de criação: 2025-10-10
# Tipo: Documentação customizada (não existe llms.txt oficial)

## Sobre Shadcn UI

Shadcn UI não é uma biblioteca de componentes tradicional. São componentes React reutilizáveis que você copia para o seu projeto e customiza.

## Filosofia

- **Não é uma dependência npm**: Você copia os componentes para o projeto
- **Código seu**: Você tem controle total sobre o código
- **Baseado em Radix UI**: Usa primitivos acessíveis do Radix
- **Estilizado com Tailwind**: Classes utilitárias do Tailwind CSS

## Instalação no Projeto

```bash
pnpm dlx shadcn@latest init
```

Configuração típica:
- TypeScript: Yes
- Style: New York ou Default
- Base color: Slate
- CSS variables: Yes

## Adicionar Componentes

```bash
# Adicionar componente específico
pnpm dlx shadcn@latest add button

# Adicionar múltiplos componentes
pnpm dlx shadcn@latest add button card input label
```

## Componentes Comuns Usados no Projeto

### Button
**Localização**: `packages/ui/src/components/button.tsx`

```tsx
import { Button } from '@/components/button';

<Button variant="default">Click me</Button>
<Button variant="destructive">Delete</Button>
<Button variant="outline">Cancel</Button>
<Button variant="ghost">Ghost</Button>
<Button variant="link">Link</Button>

// Sizes
<Button size="sm">Small</Button>
<Button size="default">Default</Button>
<Button size="lg">Large</Button>
<Button size="icon">🔥</Button>
```

### Card
**Localização**: `packages/ui/src/components/card.tsx`

```tsx
import {
  Card,
  CardHeader,
  CardTitle,
  CardDescription,
  CardContent,
  CardFooter,
} from '@/components/card';

<Card>
  <CardHeader>
    <CardTitle>Card Title</CardTitle>
    <CardDescription>Card Description</CardDescription>
  </CardHeader>
  <CardContent>
    <p>Card content goes here</p>
  </CardContent>
  <CardFooter>
    <Button>Action</Button>
  </CardFooter>
</Card>
```

### Input
**Localização**: `packages/ui/src/components/input.tsx`

```tsx
import { Input } from '@/components/input';

<Input type="email" placeholder="Email" />
<Input type="password" placeholder="Password" />
<Input type="text" disabled />
```

### Label
**Localização**: `packages/ui/src/components/label.tsx`

```tsx
import { Label } from '@/components/label';

<div>
  <Label htmlFor="email">Email</Label>
  <Input id="email" type="email" />
</div>
```

### Form (com React Hook Form + Zod)

```tsx
'use client';

import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import * as z from 'zod';
import { Button } from '@/components/button';
import { Input } from '@/components/input';
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from '@/components/form';

const formSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
});

export default function LoginForm() {
  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
  });

  function onSubmit(values: z.infer<typeof formSchema>) {
    console.log(values);
  }

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)}>
        <FormField
          control={form.control}
          name="email"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Email</FormLabel>
              <FormControl>
                <Input type="email" {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />
        <Button type="submit">Submit</Button>
      </form>
    </Form>
  );
}
```

### Dialog (Modal)

```tsx
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from '@/components/dialog';

<Dialog>
  <DialogTrigger asChild>
    <Button>Open Dialog</Button>
  </DialogTrigger>
  <DialogContent>
    <DialogHeader>
      <DialogTitle>Are you sure?</DialogTitle>
      <DialogDescription>
        This action cannot be undone.
      </DialogDescription>
    </DialogHeader>
    {/* Content */}
  </DialogContent>
</Dialog>
```

### Select (Dropdown)

```tsx
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/select';

<Select>
  <SelectTrigger>
    <SelectValue placeholder="Select option" />
  </SelectTrigger>
  <SelectContent>
    <SelectItem value="option1">Option 1</SelectItem>
    <SelectItem value="option2">Option 2</SelectItem>
  </SelectContent>
</Select>
```

### Table

```tsx
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/table';

<Table>
  <TableHeader>
    <TableRow>
      <TableHead>Name</TableHead>
      <TableHead>Email</TableHead>
    </TableRow>
  </TableHeader>
  <TableBody>
    <TableRow>
      <TableCell>John Doe</TableCell>
      <TableCell>john@example.com</TableCell>
    </TableRow>
  </TableBody>
</Table>
```

### Toast (Notifications)

```tsx
'use client';

import { useToast } from '@/components/use-toast';
import { Button } from '@/components/button';

export function ToastDemo() {
  const { toast } = useToast();

  return (
    <Button
      onClick={() => {
        toast({
          title: "Success",
          description: "Your action was completed.",
        });
      }}
    >
      Show Toast
    </Button>
  );
}
```

## Customização

### Cores (Tailwind CSS Variables)

**Arquivo**: `packages/ui/src/styles/globals.css`

```css
@layer base {
  :root {
    --background: 0 0% 100%;
    --foreground: 222.2 84% 4.9%;
    --primary: 222.2 47.4% 11.2%;
    --primary-foreground: 210 40% 98%;
    /* ... */
  }

  .dark {
    --background: 222.2 84% 4.9%;
    --foreground: 210 40% 98%;
    /* ... */
  }
}
```

### Variantes de Componentes

Componentes Shadcn usam `class-variance-authority` (CVA):

```tsx
import { cva } from 'class-variance-authority';

const buttonVariants = cva(
  'inline-flex items-center justify-center rounded-md',
  {
    variants: {
      variant: {
        default: 'bg-primary text-primary-foreground',
        destructive: 'bg-destructive text-destructive-foreground',
      },
      size: {
        default: 'h-10 px-4 py-2',
        sm: 'h-9 px-3',
      },
    },
  }
);
```

## Integração com DaisyUI

O projeto usa **Shadcn UI** E **DaisyUI** juntos:
- **Shadcn**: Para componentes complexos (forms, dialogs, etc.)
- **DaisyUI**: Para componentes simples e rápidos

```tsx
// Shadcn Button
import { Button } from '@/components/button';
<Button variant="outline">Shadcn</Button>

// DaisyUI Button
<button className="btn btn-primary">DaisyUI</button>
```

## CLI Útil

```bash
# Listar componentes disponíveis
pnpm dlx shadcn@latest add

# Adicionar todos os componentes
pnpm dlx shadcn@latest add --all

# Atualizar componentes
pnpm dlx shadcn@latest update
```

## Estrutura no Projeto

```
packages/ui/src/
├── components/
│   ├── button.tsx
│   ├── card.tsx
│   ├── input.tsx
│   ├── label.tsx
│   ├── form.tsx
│   └── ...
└── lib/
    └── utils.ts  # cn() helper
```

## Utils Helper

**Arquivo**: `packages/ui/src/lib/utils.ts`

```typescript
import { clsx, type ClassValue } from 'clsx';
import { twMerge } from 'tailwind-merge';

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}
```

Uso:
```tsx
<div className={cn('base-class', condition && 'conditional-class')} />
```

## Boas Práticas

1. **Customize livremente**: O código é seu, modifique conforme necessário
2. **Use cn()**: Helper para merge de classes Tailwind
3. **TypeScript**: Componentes são totalmente tipados
4. **Acessibilidade**: Componentes seguem WAI-ARIA
5. **Dark mode**: Suporte nativo com CSS variables
6. **Combine com DaisyUI**: Use ambos conforme necessidade

## Referências

- [Shadcn UI Documentation](https://ui.shadcn.com/)
- [Radix UI Primitives](https://www.radix-ui.com/)
- [Class Variance Authority](https://cva.style/docs)
