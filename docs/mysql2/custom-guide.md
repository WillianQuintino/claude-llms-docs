# MySQL2 - Documentação Customizada para o Projeto
# Fonte: https://sidorares.github.io/node-mysql2/docs
# Data de criação: 2025-10-10
# Tipo: Documentação customizada (não existe llms.txt oficial)

## Sobre MySQL2

MySQL2 é um cliente MySQL para Node.js com foco em performance. Este projeto usa o padrão singleton para conexões.

## Padrão Singleton Usado no Projeto

**Arquivo**: `apps/web/lib/database.ts`

```typescript
import mysql from 'mysql2/promise';

let connection: mysql.Connection | null = null;

export async function getConnection() {
  if (!connection) {
    connection = await mysql.createConnection({
      host: process.env.DB_HOST,
      port: parseInt(process.env.DB_PORT || '3306'),
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
    });
  }
  return connection;
}
```

## Queries Básicas

### SELECT
```typescript
const [rows] = await connection.execute(
  'SELECT * FROM users WHERE email = ?',
  [email]
);
```

### INSERT
```typescript
const [result] = await connection.execute(
  'INSERT INTO users (name, email, password) VALUES (?, ?, ?)',
  [name, email, hashedPassword]
);
const insertId = (result as mysql.ResultSetHeader).insertId;
```

### UPDATE
```typescript
await connection.execute(
  'UPDATE users SET name = ? WHERE id = ?',
  [name, id]
);
```

### DELETE
```typescript
await connection.execute(
  'DELETE FROM users WHERE id = ?',
  [id]
);
```

## Type Safety

### Tipando Resultados
```typescript
interface User {
  id: number;
  name: string;
  email: string;
  password: string;
  role: string;
  created_at: Date;
}

const [rows] = await connection.execute<mysql.RowDataPacket[]>(
  'SELECT * FROM users WHERE id = ?',
  [id]
);
const user = rows[0] as User;
```

### ResultSetHeader
```typescript
import { ResultSetHeader } from 'mysql2';

const [result] = await connection.execute(
  'INSERT INTO users ...',
  [...]
);
const { insertId, affectedRows } = result as ResultSetHeader;
```

## Tratamento de Erros

```typescript
try {
  const conn = await getConnection();
  const [rows] = await conn.execute('SELECT ...');
  return rows;
} catch (error) {
  console.error('Database error:', error);
  throw new Error('Failed to fetch data');
}
```

## Prepared Statements

```typescript
// Proteção contra SQL Injection
const [rows] = await connection.execute(
  'SELECT * FROM users WHERE email = ? AND role = ?',
  [email, role] // Parâmetros são escapados automaticamente
);
```

## Transactions

```typescript
const conn = await getConnection();
await conn.beginTransaction();

try {
  await conn.execute('INSERT INTO users ...');
  await conn.execute('INSERT INTO logs ...');
  await conn.commit();
} catch (error) {
  await conn.rollback();
  throw error;
}
```

## Schema do Projeto

### Tabela Users
```sql
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role VARCHAR(50) DEFAULT 'admin',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## Boas Práticas

1. **Use Prepared Statements**: Sempre use `?` para parâmetros
2. **Singleton Connection**: Reutilize a conexão (já implementado em `lib/database.ts`)
3. **Type Safety**: Sempre type os resultados das queries
4. **Error Handling**: Sempre use try/catch
5. **Transactions**: Use para operações que precisam ser atômicas

## Variáveis de Ambiente

```env
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=password
DB_NAME=tv_monitor
```

## Referências

- [MySQL2 Documentation](https://sidorares.github.io/node-mysql2/docs)
- [MySQL2 GitHub](https://github.com/sidorares/node-mysql2)
