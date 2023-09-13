# demo-di-app

This is an npm package with 2 applications (web & Node.js) to demonstrate the usage of the same JavaScript code in the
browser and Node.js without any transformations, just with dependency
injection ([@teqfw/di](https://github.com/teqfw/di)):

![packages](./assets/teqfw_di_demo_pkg.png)

The code in this package ([@flancer64/demo-di-app](https://github.com/flancer64/demo-di-app)) has dependencies on
another package ([@flancer64/demo-di-lib](https://github.com/flancer64/demo-di-lib)).
To load the sources, you just need to configure the resolver for both Node.js and browser code. All other code remains
unchanged.

## nodejs

```javascript
// ./index.js
import {dirname, join} from 'node:path';
import Container from '@teqfw/di';

// Create the objects container
/** @type {TeqFw_Di_Api_Container} */
const container = new Container();

// Add path mapping for the sources (app itself and used library)
const root = dirname(import.meta.url);
const pathApp = join(root, 'src');
const pathLib = join(root, 'node_modules', '@flancer64', 'demo-di-lib', 'src');
const resolver = container.getResolver();
resolver.addNamespaceRoot('App_', pathApp);
resolver.addNamespaceRoot('Sample_Lib_', pathLib);

// Compose the application and run it
const app = await container.get('App_Main$');
app('Hello from the Node.js!');
```

## browser

```html
<!-- ./index.html -->
<script type="module">
    import Container from 'https://unpkg.com/@teqfw/di';

    // Create the objects container
    /** @type {TeqFw_Di_Api_Container} */
    const container = new Container();

    // Add path mapping for the sources (app itself and used library)
    const url = new URL(location.href);
    const root = url.pathname.replace('index.html', '');
    const pathApp = url.origin + root + 'src';
    const pathLib = 'https://unpkg.com/@flancer64/demo-di-lib/src';
    const resolver = container.getResolver();
    resolver.addNamespaceRoot('App_', pathApp);
    resolver.addNamespaceRoot('Sample_Lib_', pathLib);

    // Compose the application and run it
    const app = await container.get('App_Main$');
    app('Hello from the Web!');
</script>
```