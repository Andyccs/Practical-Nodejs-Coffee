app = require '../app'
expect = require 'expect.js'
superagent = require 'superagent'

describe 'server', ->

  describe 'homepage', ->
    it 'should respond to GET', (done) ->
      superagent
        .get 'http://localhost:3000'
        .end (error, respond) ->
          console.log error
          console.log respond
          expect error 
            .to.equal undefined
          expect respond.status
            .to.equal 200
          done()
