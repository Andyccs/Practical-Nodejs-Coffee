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

          expect respond.body.articles
            .to.not.equal undefined
          expect respond.body.articles.length
            .to.equal 0

          done()

    it 'should respond to GET with fake article', (done) ->
      # TODO: Inject fake data
      superagent
        .get "http://localhost:#{PORT}/api/articles"
        .end (error, respond) ->
          expect respond.status
            .to.equal 200

          expect respond.body.articles
            .to.not.equal undefined
          expect respond.body.articles.length
            .to.equal 1
          # TODO: expect the respond object is desired object

          # TODO: Tear down fake data
          
          done()

    after ->
      shutdown()
