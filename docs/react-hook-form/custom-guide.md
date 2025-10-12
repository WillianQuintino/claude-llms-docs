# React Hook Form - Custom Guide
# Source: https://react-hook-form.com
# Date: 2025-10-12
# Type: Custom guide (no official llms.txt available)

## About React Hook Form

React Hook Form is a performant, flexible, and extensible form library with easy-to-use validation. It minimizes re-renders and provides better performance compared to other form libraries.

## Installation

```bash
npm install react-hook-form
```

## Basic Usage

```typescript
import { useForm } from 'react-hook-form';

interface FormData {
  email: string;
  password: string;
}

function LoginForm() {
  const { register, handleSubmit, formState: { errors } } = useForm<FormData>();

  const onSubmit = (data: FormData) => {
    console.log(data);
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email')} />
      <input type="password" {...register('password')} />
      <button type="submit">Submit</button>
    </form>
  );
}
```

## With Validation

### Built-in Validation

```typescript
function RegisterForm() {
  const { register, handleSubmit, formState: { errors } } = useForm<FormData>();

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input
        {...register('email', {
          required: 'Email é obrigatório',
          pattern: {
            value: /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i,
            message: 'Email inválido'
          }
        })}
      />
      {errors.email && <span>{errors.email.message}</span>}

      <input
        type="password"
        {...register('password', {
          required: 'Senha é obrigatória',
          minLength: {
            value: 8,
            message: 'Senha deve ter no mínimo 8 caracteres'
          }
        })}
      />
      {errors.password && <span>{errors.password.message}</span>}

      <button type="submit">Registrar</button>
    </form>
  );
}
```

### With Zod Schema

```typescript
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';

const schema = z.object({
  email: z.string().email('Email inválido'),
  password: z.string().min(8, 'Senha deve ter no mínimo 8 caracteres'),
  confirmPassword: z.string(),
}).refine((data) => data.password === data.confirmPassword, {
  message: 'As senhas não coincidem',
  path: ['confirmPassword'],
});

type FormData = z.infer<typeof schema>;

function RegisterForm() {
  const { register, handleSubmit, formState: { errors } } = useForm<FormData>({
    resolver: zodResolver(schema),
  });

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email')} />
      {errors.email && <span>{errors.email.message}</span>}

      <input type="password" {...register('password')} />
      {errors.password && <span>{errors.password.message}</span>}

      <input type="password" {...register('confirmPassword')} />
      {errors.confirmPassword && <span>{errors.confirmPassword.message}</span>}

      <button type="submit">Registrar</button>
    </form>
  );
}
```

## Advanced Features

### Default Values

```typescript
const { register } = useForm<FormData>({
  defaultValues: {
    email: 'user@example.com',
    role: 'recantiano',
  }
});
```

### Watch Fields

```typescript
function Form() {
  const { register, watch } = useForm();

  const watchEmail = watch('email'); // Watch single field
  const watchAll = watch(); // Watch all fields

  return (
    <div>
      <input {...register('email')} />
      <p>Email: {watchEmail}</p>
    </div>
  );
}
```

### Controlled Components

```typescript
import { Controller } from 'react-hook-form';

function Form() {
  const { control } = useForm();

  return (
    <Controller
      name="role"
      control={control}
      render={({ field }) => (
        <select {...field}>
          <option value="recantiano">Recantiano</option>
          <option value="missionario">Missionário</option>
        </select>
      )}
    />
  );
}
```

### Custom Components

```typescript
import { Controller } from 'react-hook-form';
import { CustomSelect } from './CustomSelect';

function Form() {
  const { control } = useForm();

  return (
    <Controller
      name="category"
      control={control}
      render={({ field }) => (
        <CustomSelect
          value={field.value}
          onChange={field.onChange}
          options={categories}
        />
      )}
    />
  );
}
```

## Form State

### Loading State

```typescript
function Form() {
  const { register, handleSubmit, formState: { isSubmitting } } = useForm();

  const onSubmit = async (data: FormData) => {
    await new Promise(resolve => setTimeout(resolve, 2000));
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email')} />
      <button disabled={isSubmitting}>
        {isSubmitting ? 'Carregando...' : 'Enviar'}
      </button>
    </form>
  );
}
```

### Dirty Fields

```typescript
function Form() {
  const { register, formState: { isDirty, dirtyFields } } = useForm();

  return (
    <form>
      <input {...register('email')} />
      <button disabled={!isDirty}>Salvar</button>
    </form>
  );
}
```

### Touched Fields

```typescript
function Form() {
  const { register, formState: { touchedFields } } = useForm();

  return (
    <div>
      <input {...register('email')} />
      {touchedFields.email && <span>Email foi tocado</span>}
    </div>
  );
}
```

## Reset Form

```typescript
function Form() {
  const { register, reset, handleSubmit } = useForm();

  const onSubmit = async (data: FormData) => {
    await api.post('/submit', data);
    reset(); // Reset to default values
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email')} />
      <button type="submit">Enviar</button>
      <button type="button" onClick={() => reset()}>Limpar</button>
    </form>
  );
}
```

## Set Values Programmatically

```typescript
function Form() {
  const { register, setValue } = useForm();

  useEffect(() => {
    // Load data from API
    fetch('/api/user').then(res => res.json()).then(data => {
      setValue('email', data.email);
      setValue('name', data.name);
    });
  }, [setValue]);

  return (
    <form>
      <input {...register('email')} />
      <input {...register('name')} />
    </form>
  );
}
```

## Array Fields

```typescript
import { useFieldArray } from 'react-hook-form';

function Form() {
  const { register, control } = useForm();
  const { fields, append, remove } = useFieldArray({
    control,
    name: 'items',
  });

  return (
    <form>
      {fields.map((field, index) => (
        <div key={field.id}>
          <input {...register(`items.${index}.name`)} />
          <button type="button" onClick={() => remove(index)}>
            Remover
          </button>
        </div>
      ))}

      <button type="button" onClick={() => append({ name: '' })}>
        Adicionar Item
      </button>
    </form>
  );
}
```

## Nested Objects

```typescript
interface FormData {
  user: {
    name: string;
    email: string;
    address: {
      street: string;
      city: string;
    };
  };
}

function Form() {
  const { register } = useForm<FormData>();

  return (
    <form>
      <input {...register('user.name')} />
      <input {...register('user.email')} />
      <input {...register('user.address.street')} />
      <input {...register('user.address.city')} />
    </form>
  );
}
```

## Custom Validation

```typescript
function Form() {
  const { register } = useForm();

  return (
    <input
      {...register('username', {
        validate: async (value) => {
          const response = await fetch(`/api/check-username/${value}`);
          const available = await response.json();
          return available || 'Username já está em uso';
        }
      })}
    />
  );
}
```

## Multiple Validations

```typescript
const { register } = useForm();

<input
  {...register('email', {
    validate: {
      required: (value) => value.length > 0 || 'Campo obrigatório',
      email: (value) => value.includes('@') || 'Email inválido',
      domain: (value) => value.endsWith('@example.com') || 'Deve ser @example.com',
    }
  })}
/>
```

## Integration with UI Libraries

### With DaisyUI

```typescript
function Form() {
  const { register, formState: { errors } } = useForm();

  return (
    <form>
      <div className="form-control">
        <label className="label">
          <span className="label-text">Email</span>
        </label>
        <input
          {...register('email', { required: true })}
          className={`input input-bordered ${errors.email ? 'input-error' : ''}`}
        />
        {errors.email && (
          <label className="label">
            <span className="label-text-alt text-error">
              {errors.email.message}
            </span>
          </label>
        )}
      </div>
    </form>
  );
}
```

### With Shadcn UI

```typescript
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';

function Form() {
  const { register, formState: { errors } } = useForm();

  return (
    <form>
      <div className="space-y-2">
        <Label htmlFor="email">Email</Label>
        <Input
          id="email"
          {...register('email', { required: 'Email é obrigatório' })}
        />
        {errors.email && (
          <p className="text-sm text-destructive">{errors.email.message}</p>
        )}
      </div>
    </form>
  );
}
```

## Error Handling

### Manual Errors

```typescript
function Form() {
  const { register, setError, formState: { errors } } = useForm();

  const onSubmit = async (data: FormData) => {
    try {
      await api.post('/submit', data);
    } catch (error) {
      setError('email', {
        type: 'manual',
        message: 'Este email já está em uso',
      });
    }
  };

  return <form onSubmit={handleSubmit(onSubmit)}>...</form>;
}
```

### Clear Errors

```typescript
const { clearErrors } = useForm();

// Clear single error
clearErrors('email');

// Clear multiple errors
clearErrors(['email', 'password']);

// Clear all errors
clearErrors();
```

## Performance Optimization

### Isolate Re-renders

```typescript
import { useFormContext } from 'react-hook-form';

function EmailField() {
  const { register } = useFormContext();
  return <input {...register('email')} />;
}

function Form() {
  const methods = useForm();

  return (
    <FormProvider {...methods}>
      <form onSubmit={methods.handleSubmit(onSubmit)}>
        <EmailField /> {/* Isolated re-render */}
      </form>
    </FormProvider>
  );
}
```

## Best Practices

1. **Use Zod for validation** - Type-safe schemas
2. **Isolate components** - Use `useFormContext` for better performance
3. **Use TypeScript** - Type your form data
4. **Handle loading states** - Show feedback during submission
5. **Reset after submit** - Clear form after successful submission
6. **Validate on blur** - Better UX than on change
7. **Use semantic error messages** - In Portuguese for this project

## Common Patterns in This Project

### Login Form

```typescript
const loginSchema = z.object({
  email: z.string().email('Email inválido'),
  password: z.string().min(8, 'Senha deve ter no mínimo 8 caracteres'),
});

type LoginFormData = z.infer<typeof loginSchema>;

function LoginForm() {
  const { register, handleSubmit, formState: { errors, isSubmitting } } = useForm<LoginFormData>({
    resolver: zodResolver(loginSchema),
  });

  const onSubmit = async (data: LoginFormData) => {
    await authService.login(data.email, data.password);
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
      <div className="form-control">
        <label className="label">
          <span className="label-text">Email</span>
        </label>
        <input
          {...register('email')}
          className="input input-bordered"
        />
        {errors.email && (
          <span className="text-error text-sm">{errors.email.message}</span>
        )}
      </div>

      <button type="submit" className="btn btn-primary" disabled={isSubmitting}>
        {isSubmitting ? 'Entrando...' : 'Entrar'}
      </button>
    </form>
  );
}
```

### Register Form with Role Selection

```typescript
const registerSchema = z.object({
  name: z.string().min(3, 'Nome deve ter no mínimo 3 caracteres'),
  email: z.string().email('Email inválido'),
  password: z.string().min(8, 'Senha deve ter no mínimo 8 caracteres'),
  role: z.enum(['recantiano', 'missionario', 'pai']),
});

type RegisterFormData = z.infer<typeof registerSchema>;

function RegisterForm() {
  const { register, handleSubmit, formState: { errors, isSubmitting } } = useForm<RegisterFormData>({
    resolver: zodResolver(registerSchema),
    defaultValues: {
      role: 'recantiano',
    },
  });

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('name')} />
      <input {...register('email')} />
      <input type="password" {...register('password')} />

      <select {...register('role')} className="select select-bordered">
        <option value="recantiano">Recantiano</option>
        <option value="missionario">Missionário</option>
        <option value="pai">Pai/Mãe</option>
      </select>

      <button type="submit" disabled={isSubmitting}>
        {isSubmitting ? 'Registrando...' : 'Registrar'}
      </button>
    </form>
  );
}
```

## Resources

- [React Hook Form Documentation](https://react-hook-form.com)
- [API Reference](https://react-hook-form.com/api)
- [Examples](https://react-hook-form.com/form-builder)
- [TypeScript Support](https://react-hook-form.com/ts)
