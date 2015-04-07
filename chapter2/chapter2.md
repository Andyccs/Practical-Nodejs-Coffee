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
    .end (error, respond) ->
      expect respond.status
        .to.equal 200
      done()
```

Run the test, and we should get:

```
1) server homepage should respond to GET:
   ReferenceError: superagent is not defined
```

This is an expected failure because we haven't install superagent. So to pass this test, we install superagent using npm:

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

This is an expected failure because we didn't start the server before running the test. We add a before() method and after method() to start the server and end the server. 

```CoffeeScript
...
boot = app.boot
shutdown = app.shutdown

describe 'server', ->

  describe 'homepage', ->
    before ->
      boot()

    it 'should respond to GET', (done) ->
      ...

    after ->
      shutdown()
```

We haven't add method for `boot()` and `shutdown()` yet, so the test will still fail. To pass the test, we will add two methods:

```CoffeeScript
express = require 'express'
http = require 'http'

PORT = 3000

app = express()
app.set 'port', PORT

server = http.createServer app

boot = ->
  server.listen PORT, ->
    console.info "Express server listening on port #{PORT}"

shutdown = ->
  server.close()

if require.main is module
  server.close()
else
  console.info 'Running app as a module'
  exports.boot = boot
  exports.shutdown = shutdown
```

Run the test, and we should get:

```
1) server homepage should respond to GET:
   Uncaught Error: expected [Error: Not Found] to equal undefined
```

We get a different error now, which is great! Now we know that we have started the server, and we can continue to write more code to pass the test. Next, we will handle incoming request. 

```CoffeeScript
app.all '*', (request, response) ->
  response.send('')
```

Run the test, and we should get:

```
  server
    homepage
Express server listening on port 3000
      ✓ should respond to GET 

  1 passing (39ms)
```

### Cycle 4

We are not done yet! Now we need to refactor our codes. If we look at our test, we would see the port number is hard coded now. To refactor this, we will start by export the `PORT` variable in `app.coffee` and then use it in its test. 

```CoffeeScript
if require.main is module
  boot()
else
  ...
  exports.PORT = PORT
```

And then in our test: 

```CoffeeScript
...
PORT = app.PORT
...
superagent
  .get "http://localhost:#{PORT}"
  .end (error, respond) ->
    ...
```

Run the test again, and we should pass the test. Finally, you should alphabetize your `require` statements and run the test again. 

### Version

0.1 - April 6, 2015 - Initial description of chapter 2