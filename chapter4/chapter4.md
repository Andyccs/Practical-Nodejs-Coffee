Chapter 4: Test-driven Development for Blog Project Part 2
==========================================================

We will continue to develop our blog projects using test-driven development approach. As a recap, each cycle consists of three steps:

1. Write test 
2. Write code to pass test, we can even cheat to pass the test
3. Refactor code

In this chapter, we will start develop API endpoints and also some webpage using jade. 

## Getting Started

Do you still remember that we setup a watch in previous chapter? It is time to use it.

```Shell
# Open a new terminal and run the following
grunt watch

# Open a new terminal again.
# The following command will open the code coverage report in our web browser.
# If you don't have the file right now, you can run the command later.
open gen/coverage.html
```

Everytime after writing some codes, we should check the terminal for test results and refresh our browser for code coverage results. 

## API Endpoints

We are going to develop Create, Read, Update, Delete (CRUD) API for blog articles. So at the end of this section, we should have the following method:

- GET /api/articles
- POST /api/articles
- PUT /api/articles/:id
- DEL /api/articles/:id

### Cycle 1

As usual, we start by writing test. We open a new file `tests/articleApi.coffee` and write our test there:

```CoffeeScript
# Imports
app = require '../app'
boot = app.boot
expect = require 'expect.js'
shutdown = app.shutdown
superagent = require 'superagent'

# Constants
PORT = app.PORT

# Test
describe 'server', ->

  describe 'article api', ->
    before ->
      boot()

    it 'should respond to GET without article', (done) ->
      superagent
        .get "http://localhost:#{PORT}/api/articles"
        .end (error, respond) ->
          expect respond.status
            .to.equal 200

          console.log respond.body
          expect respond.body.articles
            .to.not.equal undefined
          expect respond.body.articles.length
            .to.equal 0

          done()

    after ->
      shutdown()
```

We should see the test is failing now (look at your terminal that run grunt watch). Now, we can proceed to next step by writing codes in `app.coffee`:

```CoffeeScript
# Routing
app.get '/api/articles', (request, response) ->
  response.send
    articles:[]
```

We should pass all tests now, but we actually do some hack to pass the test. We return an empty array without fetching real data from persistant storage. We should write more test to achieve desired behaviour. 

### Cycle 2

If we already have some data in persistant storage, the we should get something when we call the GET aricle API. 

TODO: find a way to mock mongodb or have mongodb fake environment

## Rendering Webpage

We never test constant, getter and setter. If a request will always give the same response, we don't test it as well. At the same time, we don't know how can such request fails. In this kind of situation, smoke test is the best solution. 

TODO: descibe smoke test

We start by writing smoke test for `/login` in a new file `tests/userRendering.coffee`:

```CoffeeScript
# Imports
app = require '../app'
boot = app.boot
expect = require 'expect.js'
shutdown = app.shutdown
superagent = require 'superagent'

# Constants
PORT = app.PORT

# Test
describe 'server', ->

  describe 'user webpage', ->
    before ->
      boot()

    it 'should response to /login', (done) ->
      superagent
        .get "http://localhost:#{PORT}/login"
        .end (error, respond) ->
          expect error 
            .to.equal null
          expect respond.status
            .to.equal 200
          expect respond.text
            .to.not.equal ''
          done()

    after ->
      shutdown()
```

The test fails, and we continue by writing codes:

```CoffeeScript
app.get '/login', (request, response) ->
  response.send 'hello world'
```

The test passes now. The test said "I don't care what kind of constant you want to load when I send the request. As long as the response is not empty then I'm fine with that". Programmers have the freedom to load any constant they want to achieve desire results, without testing. If we really want to test which jade template or which html file the server is rendered, then we are testing constant, aren't we?

Now go ahead and copy the [layout.jade]((https://github.com/Andyccs/Practical-Nodejs-Coffee/blob/master/chapter4/views/layout.jade) and [login.jade]((https://github.com/Andyccs/Practical-Nodejs-Coffee/blob/master/chapter4/views/login.jade) to your `views` folder. Then, we will replace our previous router code to the following:

```CoffeeScript
app.get '/login', (request, response) ->
  response.render 'login'
```

You should get `Error: No default engine was specified and no extension was provided.` because we haven't configure jade in our `app.coffee`. So let's continue coding:

```CoffeeScript
# Set up application
app = express()
app.set 'port', PORT

VIEWS_PATH = path.join __dirname, 'views'
app.set 'views', VIEWS_PATH
app.set 'view engine', 'jade'
```

Test passes! 

### Version

0.1 - April 8, 2015 - Initial description of chapter 4
