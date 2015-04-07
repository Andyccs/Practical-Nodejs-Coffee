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

  describe 'homepage', ->
    before ->
      boot()

    it 'should respond to GET', (done) ->
      superagent
        .get "http://localhost:#{PORT}"
        .end (error, respond) ->
          expect error 
            .to.equal null
          expect respond.status
            .to.equal 200
          done()

    after ->
      shutdown()
