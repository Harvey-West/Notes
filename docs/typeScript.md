# TypeScript

## Function Typing

One method to show types for a function in TypeScript:

``` !ts
init : (s: string, p: string, c: string) => void
    = function(startButton, pauseButton, clearButton)
    {
        //...
    };
```

## Ambient Declarations

An ambient declaration is where you declare something which you don't necessarily have in your file. An example of this is the document variable that exists in the browser!

``` !ts
declare var document; //declare is the special word in this case

document.title = "Hello";
```

Using ambient declarations you can also typically pull the type definitions for files such as JQuery etc via www.typescript.codeplex.com or http://jpapa.me/typings

References are then done via:```/// <reference path="./path/file.d.ts">```