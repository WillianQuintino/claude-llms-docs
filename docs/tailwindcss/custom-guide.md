# Tailwind CSS v4 - Custom Guide
# Source: https://tailwindcss.com/docs
# Date: 2025-10-12
# Type: Custom guide (no official llms.txt available)

## About Tailwind CSS

Tailwind CSS is a utility-first CSS framework for rapidly building custom user interfaces. Version 4 introduces a new architecture with enhanced performance and developer experience.

## Installation & Setup

```bash
npm install -D tailwindcss@next @tailwindcss/postcss@next
```

### Configuration (v4)

Tailwind CSS v4 uses CSS-based configuration instead of `tailwind.config.js`:

```css
/* app/globals.css */
@import "tailwindcss";

@theme {
  --color-primary: #3b82f6;
  --color-secondary: #8b5cf6;
  --font-display: "Inter", sans-serif;
}
```

## Core Concepts

### Utility-First

Build complex components from simple utility classes:

```tsx
<button className="bg-primary hover:bg-primary/90 text-white px-4 py-2 rounded-lg transition-colors">
  Click me
</button>
```

### Responsive Design

Mobile-first breakpoint system:

```tsx
<div className="w-full md:w-1/2 lg:w-1/3">
  Responsive width
</div>
```

Breakpoints:
- `sm:` 640px
- `md:` 768px
- `lg:` 1024px
- `xl:` 1280px
- `2xl:` 1536px

### Dark Mode

```tsx
<div className="bg-white dark:bg-gray-900 text-gray-900 dark:text-white">
  Dark mode support
</div>
```

## Common Patterns in This Project

### Layout

```tsx
// Container with max width
<div className="container mx-auto px-4">
  Content
</div>

// Flex layouts
<div className="flex items-center justify-between gap-4">
  <span>Left</span>
  <span>Right</span>
</div>

// Grid layouts
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
  {items.map(item => <Card key={item.id} />)}
</div>
```

### Typography

```tsx
<h1 className="text-4xl font-bold text-gray-900 dark:text-white">
  Heading
</h1>

<p className="text-base text-gray-600 dark:text-gray-400 leading-relaxed">
  Paragraph text
</p>
```

### Spacing

Use consistent spacing scale (4px base):
- `p-4` = 16px padding
- `m-6` = 24px margin
- `gap-4` = 16px gap
- `space-y-4` = 16px vertical spacing between children

### Colors

```tsx
// Background
<div className="bg-blue-500 hover:bg-blue-600">

// Text
<p className="text-gray-700 dark:text-gray-300">

// Border
<div className="border border-gray-200 dark:border-gray-800">
```

### Transitions & Animations

```tsx
// Smooth transitions
<button className="transition-all duration-300 hover:scale-105">

// Multiple properties
<div className="transition-[background-color,transform] duration-200">
```

## Working with DaisyUI

This project uses DaisyUI on top of Tailwind. DaisyUI provides semantic component classes:

```tsx
// Combine Tailwind utilities with DaisyUI components
<button className="btn btn-primary px-8">
  DaisyUI button with custom padding
</button>

// Override DaisyUI styles
<div className="card bg-base-100 shadow-xl p-6">
  Custom padding on DaisyUI card
</div>
```

## Custom Utilities

### Using Arbitrary Values

```tsx
// Custom dimensions
<div className="w-[350px] h-[calc(100vh-64px)]">

// Custom colors
<div className="bg-[#1a1a1a] text-[#f5f5f5]">
```

### Using the `!` Modifier

Force override when needed:

```tsx
<button className="btn bg-red-500!">
  Force red background
</button>
```

## Performance Tips

1. **Use `@apply` sparingly** - Prefer utility classes in JSX
2. **Purge unused styles** - Tailwind v4 does this automatically
3. **Use semantic color names** - Define in `@theme`
4. **Group related utilities** - Use `clsx` or `cn` helpers

## Integration with Next.js

PostCSS is configured automatically in Next.js 15+:

```js
// postcss.config.js
module.exports = {
  plugins: {
    '@tailwindcss/postcss': {},
  },
}
```

## Best Practices

1. **Consistent spacing scale** - Stick to 4px increments
2. **Mobile-first** - Start with mobile styles, add breakpoints up
3. **Semantic colors** - Use theme colors, not arbitrary values
4. **Reusable components** - Extract repeated patterns into components
5. **Accessibility** - Use `focus:`, `focus-visible:` states
6. **Dark mode** - Always provide `dark:` variants for colors

## Common Utility Classes

### Display
- `block`, `inline-block`, `inline`, `flex`, `grid`, `hidden`

### Flexbox
- `flex-row`, `flex-col`, `items-center`, `justify-between`, `gap-4`

### Grid
- `grid-cols-3`, `gap-6`, `col-span-2`

### Sizing
- `w-full`, `h-screen`, `max-w-lg`, `min-h-[500px]`

### Spacing
- `p-4`, `px-6`, `py-2`, `m-4`, `mx-auto`, `space-y-4`

### Typography
- `text-sm`, `text-lg`, `font-bold`, `leading-relaxed`, `tracking-wide`

### Colors
- `bg-white`, `text-gray-900`, `border-gray-200`

### Effects
- `shadow-lg`, `rounded-lg`, `opacity-50`, `blur-sm`

### Transitions
- `transition-all`, `duration-300`, `ease-in-out`

## Resources

- [Tailwind CSS v4 Docs](https://tailwindcss.com/docs)
- [Tailwind CSS v4 Release](https://tailwindcss.com/blog/tailwindcss-v4-alpha)
- [Play CDN](https://tailwindcss.com/docs/installation/play-cdn)
- [Editor Setup](https://tailwindcss.com/docs/editor-setup)
