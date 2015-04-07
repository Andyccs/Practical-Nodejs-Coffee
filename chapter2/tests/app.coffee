app = require '../app'
expect = require 'expect.js'
superagent = require 'superagent'
boot = app.boot
shutdown = app.shutdown

describe 'server', ->

  describe 'homepage', ->
    before ->
      boot()

    it 'should respond to GET', (done) ->
      superagent
        .get 'http://localhost:3000'
        .end (error, respond) ->
          expect error 
            .to.equal null
          expect respond.status
            .to.equal 200
          done()

    after ->
      shutdown()
