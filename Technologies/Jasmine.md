# Jasmine

- [Jasmine](#jasmine)
  - [Setup and Teardown](#setup-and-teardown)
  - [Manually Failing](#manually-failing)
  - [Disabling a test suite](#disabling-a-test-suite)
  - [Spies](#spies)
    - [Stubbing](#stubbing)
    - [toHaveBeenCalled](#tohavebeencalled)
    - [Multiple Spy Object](#multiple-spy-object)
  - [Matching](#matching)
    - [Object/Array/String containing](#objectarraystring-containing)
  - [Jasmine Clock](#jasmine-clock)
    - [Mocking the date](#mocking-the-date)
  - [Asynchronous tests](#asynchronous-tests)
    - [Using Async keyword](#using-async-keyword)

## Setup and Teardown

Jasmine provides some globals:

```javascript
beforeEach(function(){});
afterEach(function(){});
//The below functions are not reset between specs. They run only once!
beforeAll(function(){});
afterAll(function(){});
```

## Manually Failing

You can fail a test job if you find a specific condition: `fail("This test failes here")`.

## Disabling a test suite

If you don't want to comment out a large amount of code, you can set the describe to `xdescribe`. It will show the test as pending.

You can do the same for a specific test through `xit`.

## Spies

A spy can stub any function (i.e. dummy a function and return a hard-coded response).
You can define what the spy will do when invoked with `and`.

### Stubbing

```javascript
//sypOn(object,functionCalledThatIsStubbed)
spyOn(someObj,'func').withArgs(40,2).and.returnValue(42);
someObj.func(40,2); // returns 42
```

### toHaveBeenCalled

Will track how many times a function is called.

```javascript
it("tracks that the spy was called", function() {
    expect(foo.setBar).toHaveBeenCalled();
  });

it("tracks if the spy/stub was called 2 times", function(){
    expect(foo.setBar).toHaveBeenCalledTimes(2);
});

it("tracks all the arguments of its calls", function() {
    expect(foo.setBar).toHaveBeenCalledWith(40,2);
  });
```

### Multiple Spy Object

You can create a spy object which can hold multiple spies.

```javascript
describe("Multiple spies", function(){
    var tape;

    beforeEach(function(){
        let tape = jasmine.createSpyObj('tape',['play','pause','stop']);

        tape.play();
        tape.pause();
        tape.rewind(0);
    });
});
```

## Matching

### Object/Array/String containing

Useful at times when you say call an API and you only want to check if a specific component of the object is defined or has some value.
You can do the same with `jasmine.arrayContaining`.

```javascript
describe("jasmine.objectContaining", () => {
    var foo;

    beforeEach(() => {
      foo = {
        a: 1,
        b: 2,
        bar: "baz"
      };
    });

    it("matches objects with the expect key/value pairs", () => ) {
      expect(foo).toEqual(jasmine.objectContaining({
        bar: "baz"
      }));
      expect(foo).not.toEqual(jasmine.objectContaining({
        c: 37
      }));
    });

    describe("when used with a spy", () => {
      it("is useful for comparing arguments", () => {
        var callback = jasmine.createSpy('callback');

        callback({
          bar: "baz"
        });

        expect(callback).toHaveBeenCalledWith(jasmine.objectContaining({
          bar: "baz"
        }));
      });
    });
  });
```

## Jasmine Clock

Jasmine clock is used for testing time dependent code and you're using .setTimeout for some reason.
REMEMBER TO UNINSTALL AFTER INSTALL.

You move time forward by calling the .tick(number) method.

### Mocking the date

Remember if you do not provide a base date it will use the current time.

```javascript
let baseTime = new Date(1999,9,23);
jasmine.clock().mockDate(baseTime);
```

## Asynchronous tests

### Using Async keyword

```javascript
it("as an async test",async() => {
    const apiCallResponse = fetch('http://example.com/example.json');
    const apiJSON = await apiCallResponse.json();
    console.log(JSON.stringify(apiJSON));
});
```
