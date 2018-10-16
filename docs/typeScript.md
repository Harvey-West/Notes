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
    (x: number):number;
}
let squareItBasic:SquareFunction = (num) => num * num;
```
