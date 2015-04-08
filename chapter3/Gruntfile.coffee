module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.initConfig
    coffeelint:
      all: ['./*.coffee']
      options:
        configFile: 'coffeelint.json'

    mochaTest:
      test:
        options:
          reporter: 'spec'
          clearRequireCache: true
          captureFile: 'gen/test_results.txt'
          require: 'coffee-script/register'
        src: ['tests/*.coffee']

    watch:
      test:
        options:
          spawn: false
        files: '**/*.coffee'
        tasks: ['mochaTest']

  # On watch events, if the changed file is a test file then configure mochaTest
  # to only run the tests from that file. Otherwise run all the tests
  defaultTestSrc = grunt.config 'mochaTest.test.src'
  grunt.event.on 'watch', (action, filepath) ->
    grunt.config 'mochaTest.test.src', defaultTestSrc
    if filepath.match 'tests/'
      grunt.config 'mochaTest.test.src', filepath

  grunt.registerTask 'default', ['coffeelint', 'mochaTest']
