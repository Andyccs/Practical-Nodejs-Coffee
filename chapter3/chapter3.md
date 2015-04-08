Chapter 3: Automation with Grunt
================================

In previous chapter, we do test-driven development. We wrote tests, run the tests and failed, wrote codes, run the tests and passed, refactored codes, run the tests and passed (under the best case scenario). There are some problems:

1. We run the test using a very long command. If we pass the codes to another person, he/she might not know how to run in a proper way. 
2. We need to run the test everytime. Why not we write some scripts to make it run automatically? 

In this chapter, we are going to automate the test process. Having said that, grunt can do a lot of things! You can refer to Chapter 10 of [Practical Nodejs](https://github.com/azat-co/practicalnode) for more examples. At the end of this chapter, we are going to setup automate code coverage report too. 


## Getting Started

First of all, we need to install Grunt:

```Shell
npm install -g grunt-cli
npm install grunt --save-dev

grunt
# grunt-cli: The grunt command line interface. (v0.1.13)
# 
# Fatal error: Unable to find local grunt.
# 
# If you're seeing this message, either a Gruntfile wasn't found or grunt
# hasn't been installed locally to your project. For more information about
# installing and configuring grunt, please see the Getting Started guide:
#
# http://gruntjs.com/getting-started
```

Next, we open a file called `Gruntfile.coffee`. To get started with grunt, we configure a task called `coffeelint`, which will help you to lint your coffeescript.

```CoffeeScript
module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-coffeelint'

  grunt.initConfig
    coffeelint:
      all: ['./*.coffee']
      options:
        configFile: 'coffeelint.json'
```

We are using a npm package called `grunt-coffeelint`, so we need to install it:

```Shell
npm install grunt-coffeelint --save-dev
```

Great! So now, try to run the following commands to lint your coffeescript

```Shell
grunt coffeelint
# Running "coffeelint:all" (coffeelint) task
# >> 2 files lint free.
# 
# Done, without errors.
```

## Grunt Mocha Test for Coffeescript

We will configure our mocha test using grunt. Our `Gruntfile.coffee` should look like the following:

```CoffeeScript
module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-mocha-test'

  grunt.initConfig
    coffeelint:
      all: ['./*.coffee']
      options:
        configFile: 'coffeelint.json'

    mochaTest:
      test:
        options:
          reporter: 'spec'
          captureFile: 'gen/test_results.txt'
          require: 'coffee-script/register'
        src: ['tests/*.coffee']

  grunt.registerTask 'default', ['coffeelint', 'mochaTest']
```

We are loading a npm package called `grunt-mocha-test`, so we need to install it:

```Shell
npm install grunt-mocha-test --save-dev
```

Remember the long command `mocha --compilers coffee:coffee-script/register app.coffee` that we need to run in chapter 2? Now the command become:

```Shell
grunt mochaTest

# Running "mochaTest:test" (mochaTest) task
# Running app as a module
#
#
#   server
#     homepage
# Express server listening on port 3000
#       ✓ should respond to GET
#
#
#   1 passing (34ms)
#
#
# Done, without errors.
```

We probably will run these two commands often. Usually, we will lint all coffeescript first before run the tests. Since they are so commonly used, why not make it even simple? We register a default task for grunt in the last line of `Gruntfile.coffee`, so we can do the following:

```Shell
grunt
# Running "coffeelint:all" (coffeelint) task
# >> 2 files lint free.
# 
# Running "mochaTest:test" (mochaTest) task
# Running app as a module
# 
# 
#   server
#     homepage
# Express server listening on port 3000
#       ✓ should respond to GET
# 
# 
#   1 passing (34ms)
# 
# 
# Done, without errors.
````
## Grunt Watch for CoffeeScript

We want to watch all `.coffee` files now. When some changes are made to these files, we will run all the tests again. Imagine that we have two monitor, one is running Sublime Text3, and another is running a terminal with watch. After writing our code, we can know whether our codes are correct by watching the tests running in another monitors. =)

```CoffeeScript
module.exports = (grunt) ->
  ...
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.initConfig
    ...
    mochaTest:
      test:
        options:
          reporter: 'spec'
          clearRequireCache: true  # This line is important
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
  ...
```

Don't forget to install npm package for watch:

```Shell
npm install grunt-contrib-watch --save-dev
```

### Version

0.1 - April 7, 2015 - Initial description of chapter 3
