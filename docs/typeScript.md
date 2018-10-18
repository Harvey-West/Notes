# TypeScript

## Function Typing

One method to show types for a function in TypeScript:

``` !ts
init : (s: string, p: string, c: string) => void
    = function(s, p, c)
    {
        //...
    };
//or
init : (s: string, p: string, c: string) => void;
init = (s, p, c) => something;
```

## Ambient Declarations

An ambient declaration is where you declare something which you don't necessarily have in your file. An example of this is the document variable that exists in the browser!

``` !ts
declare var document; //declare is the special word in this case

document.title = "Hello";
```

Using ambient declarations you can also typically pull the type definitions for files such as JQuery etc via www.typescript.codeplex.com or http://jpapa.me/typings

References are then done via:```/// <reference path="./path/file.d.ts">```

## Optional Parameters

You can define optional parameters for a typescript function by doing the below as an example:

``` !js
let squareIt : (rect:{h:number; w?:number}) => number
    = function(rect:{h:number; w?:number;}){
        if(rect.w === undefined){
            rect.h * rect.h;
        }
        return rect.h * rect.w;
    }
```

## Interfaces

An interface will let you create functions with a type almost and then when you create functions with that type it will check it against that interface.

``` !js
interface SquareFunction{
    (x: number):number;git s
}
let squareItBasic:SquareFunction = (num) => num * num;
```

Interfaces can also be used to functions which then return functions..

### Interfaces and clases 

Note that private variables in classes don't work for anything less than ES5 (IE7 or below).

Interfaces easily can be used for classes so a class may have some properties and functions:

``` !js
interface Car{
    engine: string;
    model?: string;
    constructor:(engine:string) => void;
}

class Car {
    private _engine: string; //Underscore is convention only for private

    constructor(_engine:string){
        this._engine = _engine;
    }

    get engine(): string{
        return this._engine;
    }

    set engine(value: string){
        if(value == undefined) throw 'Engine requires a string to be set';
        this._engine = value;
    }

    start(){
        return "Started " + this.engine;
    }
}
```

## Casting types

Sometimes you can't create the type through a function that clearly defines that it will return the type you want in a way that TypeScript identifies. This is one use case but there are many others where you want to cast your types.

Take a look at this example:

``` !js
let table:HTMLTableElement = document.createElement('table');
//The above code will fail because createElement does not return
//type HTMLTableElement all the time! As such we do:
let table:HTMLTableElement = <HTMLTableElement>document.createElement('table');
//And now it works and we get intellisense!
```