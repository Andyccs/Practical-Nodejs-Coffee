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
