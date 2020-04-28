# Angular

- [Angular](#angular)
  - [Components](#components)
  - [Modules](#modules)
    - [Providers](#providers)
    - [Imports](#imports)
  - [Directives](#directives)
  - [Pipes](#pipes)
    - [Custom Pipe](#custom-pipe)
  - [Interpolation binding](#interpolation-binding)
  - [Dependency Injection](#dependency-injection)
  - [Code Scaffolding](#code-scaffolding)
  - [Routes](#routes)
  - [Folder structure](#folder-structure)
    - [app.module.ts](#appmodulets)
    - [Services](#services)
    - [tsconfig](#tsconfig)
    - [module-routing.module.ts](#module-routingmodulets)
  - [Documentation](#documentation)

## Components

Denoted by `@Component`
Components control views. They also communicate with other components and services to bring functionality to the app.

<https://angular.io/api/core/Component>

## Modules

Denoted by `@ngModule`
Consist of one or more components, services, directives, pipes and more. They do not control any html. A module file structure could be like:
my-account.module.ts
my-account-routing.module.ts

my-account.module.ts may import a shared module: `import {Shared Module } from '../shared/shared.module';`

<https://angular.io/api/core/NgModule>

### Providers

The set of injectable objects that are available in the injector of this module. Dependencies whose providers are listed here become available for injection into any component, directive, pipe, or service that is a child of this injector. The NgModule used for bootstrapping uses the root injector, and can provide dependencies to any part of the app.

The below is an example which defines a class that is injected in the HelloWorld NgModule:

```javascript
@Injectable()
export class Greeter {
   greet(name:string) {
     return 'Hello ' + name + '!';
   }
   constructor(){}
}

//HelloWorld is a module, which has the provider Greeter.
@NgModule({
  providers: [
    Greeter
  ]
})
class HelloWorld {
  greeter:Greeter;

  constructor(greeter:Greeter) {
    this.greeter = greeter;
  }
}
```

### Imports

The following example allows MainModule to use anything exported by CommonModule:

```javascript
@NgModule({
  imports: [CommonModule]
})
class MainModule {
}
```

## Directives

Think of things like `*ngFor` which lets you create any number of list elements based on some data: `<li *ngFor="let hero of heroes"><span>{{hero.name}}</span></li>`.

## Pipes

A pipe takes in data as in input and transforms it into a desired output.

Below we pipe the iterpolated birthday variable through a pipe "|" to the Date pipe.

```javascript
import { Component } from '@angular/core';

@Component({
    selector: 'app-hero-birthday',
    template: `<p>The hero's birthday is {{ birthday | date }}</p>`
})

export class HeroBirthdayComponent {
    birthday = new Date(1988, 3, 15); // April 15, 1988
}
```

### Custom Pipe

```javascript
import { Pipe, PipeTransform } from '@angular/core';
/*
 * Raise the value exponentially
 * Takes an exponent argument that defaults to 1.
 * Usage:
 *   value | exponentialStrength:exponent
 * Example:
 *   {{ 2 | exponentialStrength:10 }}
 *   formats to: 1024
*/
@Pipe({name: 'exponentialStrength'})
export class ExponentialStrengthPipe implements PipeTransform {
  transform(value: number, exponent?: number): number {
    return Math.pow(value, isNaN(exponent) ? 1 : exponent);
  }
}
```

## Interpolation binding
<!--The {{}} syntax is interpolation binding syntax-->
`<h1>{{title}}</h1>`

## Dependency Injection

You always import the Component symbol from the Angular core library and annotate the component class with @Component.

@Component is a decorator function that specifies the Angular metadata for the component.

## Code Scaffolding

Run `ng generate component component-name` to generate a new component. You can also use `ng generate directive|pipe|service|class|guard|interface|enum|module`.

## Routes

```javascript
{
    path: 'home',
    //Enables lazy loading of routes
    loadChildren: './path/my-account/my-account.module#MyAccountModule'
    /*The idea behind canActivate is that if the guard decides that
    you are authorised to access this route, it will permit
    you to accessing it.
    A guard can return a URL tree
    which means a new navigation will be kicked off.
    https://angular.io/api/router/CanActivate
    */
    canActivate: [AuthGuard]
},
{
    path: '',
    redirectTo: '/home',
    //PathMatch required, otherwise it would cause an infinite loop on every page as all pages have '' in!
    pathMatch: 'full'
},
{
    path: '404',
    //Requires you to import it above
    component: NotFoundComponent,
    data:{
        title: 'Page not found',
        public: true,
        anchor: 'header'
    }
}
```

## Folder structure

```directory
project
|--e2e
|--src
    |--index.html
    |--robots.txt
    |--sass
    |--environments
    |--assets
    |--app
        |--components
            |--my-account
            |--header
            |--footer
        |--models
            |--User.interface.ts
            |--User.ts
        |--modules
            |--my-account.module.ts
            |--my-account-routing.module.ts
        |--pages
        |--pipes
        |--services
        |--app-routing.module.ts
        |--app.component.html
        |--app.component.scss
        |--app.component.ts
        |--app.module.ts
```

### app.module.ts

What I have found is that you declare components here, import modules and declare services. Not sure if that's always.

### Services

You just need to mark a service as @Injectable() for a service.

### tsconfig

If you specify some things within you tsconfig you can make it so environment variables and services etc. are much easier to import into your files. THIS REQUIRES A `index.ts` file to be created in the folder it looks within. For some reason using `*` meant it tried to match a file literally `*.ts` and it was not working.

```JSON
compilerOptions:{
    "baseUrl": "src",
    "paths": {
        "@app/*": ["app/*"],
        "@env/*": ["environment/*"],
        "@services/*": ["app/services/*"]
    }
}
```

### module-routing.module.ts

You should find that for lazy loading you want to define your routing for that module at this level. Therefore when someone actually comes to this route then you can specify the component that is meant to be rendered on that path. See the below code example:

```typescript
const routes: Routes[
    {
        path: '',
        component: DefaultComponent,
        data: {
            title: 'Default Title'
        }
        path: 'about'
        component: About,
        data: {
            title: 'About'
        }
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class DefaultRoutingModule{}
```

## Documentation

You can use Microsoft's TSDoc with TypeDoc. But as this is an angular application, you might as well use compodoc which understands the angular things and then gives you extra stuff like routing diagrams.

You install it with `npm install --save-dev @compodoc/compodoc` then you include in your package.json:

```json
"scripts": {
  "compodoc": "npx compodoc -p tsconfig.json"
}
```

When you run `npm run compodoc` it should generate your documentation in `/documentation`.
