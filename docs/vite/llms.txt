# Vite

> The Build Tool for the Web

- 💡 Instant Server Start
- ⚡️ Lightning Fast HMR
- 🛠️ Rich Features
- 📦 Optimized Build
- 🔩 Universal Plugin Interface
- 🔑 Fully Typed APIs

Vite is a new breed of frontend build tooling that significantly improves the frontend development experience. It consists of two major parts:

- A dev server that serves your source files over [native ES modules](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules), with [rich built-in features](https://vite.dev/guide/features.md) and astonishingly fast [Hot Module Replacement (HMR)](https://vite.dev/guide/features.md#hot-module-replacement).

- A [build command](https://vite.dev/guide/build.md) that bundles your code with [Rollup](https://rollupjs.org), pre-configured to output highly optimized static assets for production.

In addition, Vite is highly extensible via its [Plugin API](https://vite.dev/guide/api-plugin.md) and [JavaScript API](https://vite.dev/guide/api-javascript.md) with full typing support.

## Table of Contents

### Introduction

- [Getting Started](/guide.md)
- [Project Philosophy](/guide/philosophy.md)
- [Why Vite](/guide/why.md)

### Guide

- [Features](/guide/features.md)
- [Command Line Interface](/guide/cli.md)
- [Using Plugins](/guide/using-plugins.md)
- [Dependency Pre-Bundling](/guide/dep-pre-bundling.md)
- [Static Asset Handling](/guide/assets.md)
- [Building for Production](/guide/build.md)
- [Deploying a Static Site](/guide/static-deploy.md)
- [Env Variables and Modes](/guide/env-and-mode.md)
- [Server-Side Rendering (SSR)](/guide/ssr.md)
- [Backend Integration](/guide/backend-integration.md)
- [Troubleshooting](/guide/troubleshooting.md)
- [Performance](/guide/performance.md)
- [Rolldown Integration](/guide/rolldown.md)
- [Migration from v6](/guide/migration.md)
- [Breaking Changes](/changes.md)

### APIs

- [Plugin API](/guide/api-plugin.md)
- [HMR API](/guide/api-hmr.md)
- [JavaScript API](/guide/api-javascript.md)
- [Configuring Vite](/config.md)

### Environment API

- [Environment API](/guide/api-environment.md)
- [Using `Environment` Instances](/guide/api-environment-instances.md)
- [Environment API for Plugins](/guide/api-environment-plugins.md)
- [Environment API for Frameworks](/guide/api-environment-frameworks.md)
- [Environment API for Runtimes](/guide/api-environment-runtimes.md)

### Config

- [Configuring Vite](/config.md)
- [Shared Options](/config/shared-options.md)
- [Server Options](/config/server-options.md)
- [Build Options](/config/build-options.md)
- [Preview Options](/config/preview-options.md)
- [Dep Optimization Options](/config/dep-optimization-options.md)
- [SSR Options](/config/ssr-options.md)
- [Worker Options](/config/worker-options.md)



### Future

- [`this.environment` in Hooks](/changes/this-environment-in-hooks.md)
- [HMR `hotUpdate` Plugin Hook](/changes/hotupdate-hook.md)
- [Move to Per-environment APIs](/changes/per-environment-apis.md)
- [SSR Using `ModuleRunner` API](/changes/ssr-using-modulerunner.md)
- [Shared Plugins during Build](/changes/shared-plugins-during-build.md)


### Other

- [Plugins](/plugins.md)
- [Releases](/releases.md)
