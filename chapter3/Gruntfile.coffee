module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-mocha-test'

  grunt.initConfig
    coffeelint:
      all: ['./*.coffee'],
      options:
        configFile: 'coffeelint.json'

    mochaTest:
      test:
        options:
          reporter: 'spec',
          captureFile: 'gen/test_results.txt',
          require: 'coffee-script/register'
        src: ['tests/*.coffee']

  grunt.registerTask 'default', ['coffeelint', 'mochaTest']
