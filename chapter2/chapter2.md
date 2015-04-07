Chapter 2: Test-driven Development for Blog Project
===================================================

I will develop exactly the same blog project in the book, but using a different approach and language. The book does provide a guideline on how to do test-driven development in Nodejs, but does not use this approach intensively. For example, we only have 3 tests at the end of chapter 5. 

This chapter is developed based on [Practical Nodejs](https://github.com/azat-co/practicalnode) Chapter 3 codes. 

## Getting Stated

First setup your project by:

```Shell
npm init

npm install express --save
npm install mocha --save-dev
npm install expect.js --save-dev
```

## Test-driven Development Time

### Cycle 1

First, open a new file `tests/app.coffee` and write the following codes to the file.

```CoffeeScript
app = require '../app'
expect = require 'expect.js'
```

Then we run the test by using the following commands (we will add it to our makefile eventually):

```Shell
mocha --compilers coffee:coffee-script/register app.coffee

# The result should be:
# 0 passing (2ms)
```

### Cycle 2

We continue to write the test by adding the following codes:

```CoffeeScript
describe 'server', ->
  
  describe 'homepage', ->
    it 'should respond to GET', (done) ->
      # Do something here
```

Run the test again, and we should get:

```
server
  homepage
    ✓ should respond to GET 

1 passing (9ms)
```

### Cycle 3

In cycle, we make GET request to http://localhost:port. Start coding:

```CoffeeScript
it 'should respond to GET', (done) ->
  superagent
    .get 'http://localhost:3000'
    .end (respond) ->
      expect respond.status
        .to.equal 200
      done()
```

Run the test, and we should get:

```
1) server homepage should respond to GET:
   ReferenceError: superagent is not defined
```

This is an expected failure, because we haven't install superagent. So to pass this test, we install superagent using npm:

```Shell
npm install superagent --save
```

If we run the test again, then we will get the same failure message again because we haven't import superagent, so add the following at the top of the file:

```CoffeeScript
superagent = require 'superagent'
```

Run the test, and we should get:

```
1) server homepage should respond to GET:
   Uncaught Error: expected [Error: connect ECONNREFUSED] to equal undefined
```



### Version

0.1 - April 6, 2015 - Initial description of chapter 2