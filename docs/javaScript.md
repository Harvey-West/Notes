# Javascript Notes

## Let vs Var

``` !js
let carIds = [1,2,3];  
var varCarIds = [1,2,3];
```

Let focuses on code scope. So if I tried to call it before declaring it, it will fail!
Var is different in that it doesn't error so much as say undefined if declared later.  
Furthermore this code will produce which is desirable!

``` !js
if(true){
    let inCode = true;
}
console.log(inCode);
//inCode is not in the same scope and will then fail!
```

## Rest parameters

Rest parameters is where at the end of a function definition of parameters you can take any number of params and put them into an array. Take the below example:  

``` !js
function sendCars(day, ...allCarIds){
    allCarIds.forEach(id => console.log(id));
}
sendCars('Monday', 100, 200, 300);
// The result will be that it only prints out 100, 200, 300!
```

## Destructuring  

### Destructuring Arrays

This is a method to assign values already existing in an array to variables. This is useful if you're getting some values but are waiting for the rest later! Take the below example:  

``` !js
let carIds = [1,2,5];
let [car1, car2, car3] = carIds;

console.log(car1, car2, car3);
//Logs out 1, 2, 5!
```

You can also do this with rest paramets and therefore maybe do some funky recursion:  

``` !js
let [car1, ...remainingCars] = carIds;
console.log(car1, remainingCars);

//Prints out 1, [2, 5]
```

or  

``` !js
[,, ...remainingCars] = carIds;
coinsole.log(remainingCars);

//Prints out [5]!
```

### Destructing Objects

``` !js
let car = {id: 3, make: 'honda'};
let {id, style} = car;
//Do not put the curly brace on a new line as the compiler
//Will think that it's a code block and not destructuring!
//To do that you do:
//({id, style} = car);

console.log(id, style);
//Prints out 3, convertible
```

## Spread Syntax

This allows you to take an array and spread out the elements to be assigned to parameters.

``` !js
function startCars(car1, car2, car3) {
    console.log(car1, car2, car3);
}

let carIds = [100, 300, 500];

//Here we take an array and we break it up to map to
//the parameters of the function!
startCars(...carIds);
//100 300 500
```

Interesting behaviour for strings:

``` !js
function startCars(car1, car2, car3) {
    console.log(car1, car2, car3);
}

let carName = 'Ben';

startCars(...carName);
//B e n
```

## Types

### Type Conversion

Parse functions typically only parse the first characters that match the type you are trying to convert to. If they reach a character which is not part of that type it failes ignores them and returns what it found already (skipping numbers later down the line);  
If it starts with a character it cannot convert if fails straight away.

#### String to Integer

``` !js
Number.parseInt('55');
```

#### String to Number (float)

``` !js
Number.parseFloat('55.99');
```

## Operators

### Equality Operators

Javascript will try and convert these variables to be the same type!

``` !js
if (var1 == var2){}
```

To prevent this use ```===``` as this will prevent type conversion. Same for ```!==``` compared to ```!=```.

### Unary Operators

``` !js
++var1
var1++ //This would not convert a string to a numeric if used in an expression till after the expression.
```

``` !js
+var1 \\This converts a string to a numeric type! Retains the sign on the number too.
-var1 \\This could change the sign of a variable before an expression
```

### Conditional Operator

If foo > 5 then it will evaluate to the true part of the expression, otherwise false.

``` !js
var result = (foo > 5) ? console.log(true) : console.log(false);
```

### Assignment Operators

``` !js
var1 += 10;
var1 -= 10;
var1 <<= 1; //Shift bits to the left. Equivalent to multiplying it by 2.
var1 >>= 1; //Shift bits to the right. Equivalent to dividing it by 2.
var1 >>>= 1; //Shift bits to the right but keep the sign.
```

## IIFE (Immediately Invoked Function Expression)

Running the function immediately as it's declared.
The below function is called right away!

``` !js
(function() {
    console.log('in function');
})();
```

To make it into an IIFE you can do:

``` !js
let app = (function() {
    let carId = 1;
    console.log('in function');
    return{}; //What gets assigned to app.
})();//Can even pass in args via the () bit.
```

## Closures

Via an IIFE we can make the functions and variables hang around after initial execution.

``` !js
let app = (function() {
    let carId = 1;
    let getId = function() {
        return carId;
    };
    return{
        return getId: getId
    };  
})();
console.log(app.getId()); // prints out 1!
```

## This keyword

Here's an example (works without strict mode):

``` !js
let fun = function() {
    console.log(this === window);
}
fun(); //This returns true! It equals the global object.
```

Equally:

``` !js
let o = {
    carId: 1,
    getId: function() {
        return this.carId;
    }
};
console.log(o.getId()); //Prints out 1 as it refers to the object that holds the function.
```

If you were to print out this in the previous example it would print the object o i.e. {carId: 1, getId: function}.

### Call and Apply

Main purpose of these is to change the purpose of this.

#### Call

``` !js
let o = {
    carId: 1,
    getId: function() {
        return this.carId;
    }
};
let newCar = {carId: 2};
console.log(o.getId.call(newCar));//Prints out 2!
```

#### Apply

Similar to call but you can pass in arguments.

``` !js
let o = {
    carId: 1,
    getId: function(prefix) {
        return prefix + this.carId;
    }
};
let newCar = {carId: 2};
console.log(o.getId.apply(newCar, ['ID: ']));//Prints out ID: 2
```

### Bind

This lets us make a copy of the function and assigns a new context or modifies this.

``` !js
let o = {
    carId: 1,
    getId: function() {
        return this.carId;
    }
};
let newCar = {carId: 2};
let newFn = o.getId.bind(newCar);
console.log(newFn()); //Prints out 2
```

## Arrow Functions

A concise and modern syntax for function definitions that do NOT have their own "this" value! This will refer to the enclosing context.

To see some examples with arrow functions:

``` !js
let getId = () => 1; //Nothing in () i.e. no parameters

console.log(getId()); //Prints 1.

let getGreeting = (prefix, suffix) => prefix + 'Alan' + suffix;
/*or let getGreeting = prefix, suffix) => {
* return prefix + 'Alan' + suffix;
*}
*/

console.log(getGreeting('Hey ', '!')); //Hey Alan!
```

## Interpolation

``` !js
let trackCar = function(carId, city='NY'){
    console.log(`Tracking ${carId} in ${city}.`);
};

console.log(trackCar(123));
//Tracking in 123 in NY.

console.log(trackCar(123, 'Chicago'));
//Tracking 123 in Chicago.
```

## Constructors

Remember convention is to uppercase the constructor function!

### Prototypes

Prototypes help you manage memory and many other features. Take the below example:

``` !js
function Car(id){
    this.carId = id;
    this.start = function(){
        console.log('start: ' + this.carId);
    };
}

let car = new Car(123);
car.start(); //start: 123
```

The function this.start will be replicated thousands of times if you call ```new Car(id)```!

To fix this we can do the below:

``` !js
function Car(id){
    this.carId = id;
}

Car.prototype.start = function() {
    console.log('start: ' + this.carId);
};

let car = new Car(1);
car.start(); //start: 1
```

## JSON

### Creating JSON

To create JSON style strings we can do:

``` !js
let car = {
    id: 1,
    make: 'tesla'
};

console.log(JSON.stringify(car));
//Prints {"id":1, "make":"tesla"}
```

### Parsing JSON

``` !js
let jsonIn =
`
    [
        {"carId" : 1},
        {"carId" : 2}
        {"carId" : 3}
    ]
`;

let carIds = JSON.parse(jsonIn);
console.log(carIds);
//[{...},{...},{...}] all 3 objects are printed in an array.
```

## Array Iteration

Just going to give an example of different functions and their outputs while working with arrays (or JSON).

``` !js
let jsonIn =
`
    [
        {"carId" : 1, make: 'Tesla'},
        {"carId" : 2, make: 'Nissan'}
        {"carId" : 3, make: 'BMW'}
    ]
`;

let carIds = JSON.parse(jsonIn);
```

### For Each

If we now call ```carIds.forEach(car => console.log(car));``` this will take each object assign it to "car" and pass it to the console to print it on a new line.

Alternatively we can do ```carIds.forEach((car,index) => console.log(car,index));``` which prints the index along with the car.

### Filter

We can also filter and loop through the array and return only results that match certain criteria: ```let teslas = carIds.filter(car => car.make === 'Tesla');```.

### Every

Every simply returns a boolean about whether a condition you specify is met for every index ```let result = carIds.every(car => car.carId > 0);```.

### Find

Locates the first match of something within an array: ```let car = carIds.find(car => car.carId > 2);```.

## Class

``` !js
class Car {
    constructor(id){
        this.id = id;
    }
    identify(suffix){
        return `Car Id: ${this.id} ${suffix}`;
    }
}

let car = new Car(1);
console.log(car.identify("!")); //Prints "Car: 123!"
```

### Inheritance

One of the most frustrating things is to remember to call super() on your classes beneath the inherited class.

``` !js
class Vehicle {
    constructor(){
        this.type = 'Car';
    }
    start(){
        return `Starting: ${this.type}`;
    }
}

class Car extends Vehicle{
    constructor() {
        super(); //Special function which refers back to the super class.
    }
    start(){
        return super.start() + ' now.';
    }
}

let car = new Car();
console.log(car.start()); //Prints "Starting: Car now."
```

## Modules

``` !js
export class Car{
    constructor(id){
        this.id = id;
    }
}
```

This is all a module is! However to use it you do need to ```import{Identifier} from './path/to/file.js'```

## setTimeout

A function which simply makes a function or the window wait.  
You can also cancel the timeout:

``` !js
let timeoutId = setTimeout(function(){
    console.log('1 second paused');
}, 1000);

//Here I cancel it:
clearTimeout(timeoutId);
```

## Selecting DOM Elements

There are three main options:

``` !js
document.getElementById('elementId');

document.getElementsByClassName('className'); //Returns an array!

document.getElementsByTagName('tagName'); //Again returns an array!
```

## Try Catch and Finally

Try and catch lets you attempt some code, then catch will run if an error is thrown:

``` !js

try{
    let car = newCar;
    //throw new Error('custom error'); //Could make an error which inherits from error to throw here.
}
catch(error){
    console.log('error: ', error);
}
finally {
    console.log('This always executes.');
}
```

## Promises

Asynchronous call basically. You promise to get a result some time in the future.

``` !js
let promise = new Promise(
    function(resolve, reject){
        setTimeout(resolve, 100, 'someValue');
        //Or some code which goes and scrapes data via HHTP requests etc.  
    }
);
promise.then(
    value => console.log('fulfilled: ' + value),
    error => console.log('rejected: ' + error)
);
//Prints fulfilled: someValue
```

This code would execute the function ```resolve``` after 100 miliseconds passing in the value ```'someValue'```.