# Imports
express = require 'express'
http = require 'http'

# Constants
PORT = 3000

# Set up application
app = express()
app.set 'port', PORT

# Routing
app.all '*', (request, response) ->
  response.send('')

# Create and start the server
server = http.createServer app

boot = ->
  server.listen PORT, ->
    console.info "Express server listening on port #{PORT}"

shutdown = ->
  server.close()

if require.main is module
  boot()
else
  console.info 'Running app as a module'
  exports.boot = boot
  exports.shutdown = shutdown
  exports.PORT = PORT
