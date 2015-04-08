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
