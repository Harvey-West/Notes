# TypeScript

## Function Typing

One method to show types for a function in TypeScript:

``` ts
init : (s: string, p: string, c: string) => void
    = function(s, p, c)
    {
        //...
    };
//or
init : (s: string, p: string, c: string) => void;
init = (s, p, c) => something;
```

---

## Ambient Declarations

An ambient declaration is where you declare something which you don't
necessarily have in your file. An example of this is the document variable that
exists in the browser!

``` !ts
declare var document; //declare is the special word in this case

document.title = "Hello";
```

Using ambient declarations you can also typically pull the type definitions for
files such as JQuery etc via www.typescript.codeplex.com or
http://jpapa.me/typings

References are then done via:```/// <reference path="./path/file.d.ts">```

---

## Optional Parameters

You can define optional parameters for a typescript function by doing the below
as an example:

``` ts
let squareIt : (rect:{h:number; w?:number}) => number
    = function(rect:{h:number; w?:number;}){
        if(rect.w === undefined){
            rect.h * rect.h;
        }
        return rect.h * rect.w;
    }
```

---

## Interfaces

An interface will let you create functions with a type almost and then when you
create functions with that type it will check it against that interface. It is
a way to provide a contract that other objects must implement.

``` ts
interface SquareFunction{
    (x: number):number;
}
let squareItBasic:SquareFunction = (num) => num * num;
```

Interfaces can also be used to functions which then return functions..

### Interfaces and classes

Note that private variables in classes don't work for anything less than ES5
(IE7 or below).

Interfaces easily can be used for classes so a class may have some properties
and functions:

``` ts
interface InterfaceEngine{
    engine: string;
    model?: string; //This is an optional member
    constructor:(engine:string) => void;
    start(callback:(startStatus:boolean, engineType: string) => void) : void;
}

class Car implements InterfaceEngine{
    private _engine: string; //Underscore is convention only for private
    //New versions of TS/ES I think implement private a better way.
  
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

    start(callback: (startStatus:boolean, engineType:string) =>) {
        window.setTimeout(() => {
            callback(true, this.engineType);
        }, 1000);
        return "Started " + this.engine;
    }
}
```

You can also do something called "polymorphic behaviour". Basically what this
means is that if you set the engine type in the above example to something like:

``` ts
class Auto{
    engine: InterfaceEngine;
}
```

Then your engine can have many different implementations of ```startengine()```.

### When you need to cast an interface

If for example you implement an interface for an object like engine and your
constructor will take anything that implements that interface. You may find that
when you extend that object to include other members, how do you access them?
TypeScript will through an error because the type of the object you're
referencing is actually a type of the interface. So you then need to cast that
new object to an existing or new type which then allows TS to know that the
member access is valid.

### Extending interfaces

Extending interfaces is like multiple inheritance or class extension.

``` ts
interface InterfaceElectricEngine extends InterfaceEngine{
    //This defined InterfaceEngine members PLUS custom members in 
    //InterfaceElectricEngine
    weight?: integer;
    capacity: integer;
}
```

---

## Casting types

Sometimes you can't create the type through a function that clearly defines that
it will return the type you want in a way that TypeScript identifies. This is
one use case but there are many others where you want to cast your types.

Take a look at this example:

``` ts
let table:HTMLTableElement = document.createElement('table');
//The above code will fail because createElement does not return
//type HTMLTableElement all the time! As such we do:
let table:HTMLTableElement = <HTMLTableElement>document.createElement('table');
//And now it works and we get intellisense!
```

---

## Extending Types

This is done via the ```extends``` keyword and it ***must*** include
the ```super()``` command:

``` ts
class ParentClass{
    myParameter: string;
    constructor(myParameter:string){
        this.myParameter = myParameter;
    }
}
class ChildClass extends ParentsClass{
    mySecondParemeter: string;
    constructor(myParameter: string, mySecondParameter: boolean){
        super(myParameter);
        this.mySecondParameter = mySecondParameter;
    }
}
```

## Declaration Files

## Modules

Modules allow code to be reused in a clear and concise way.

``` ts
namespace dataservice {
    //code
};
```
