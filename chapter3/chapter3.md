Chapter 3: Automation with Grunt
================================

In previous chapter, we do test-driven development. We wrote tests, run the tests and failed, wrote codes, run the tests and passed, refactored codes, run the tests and passed (under the best case scenario). There are some problems:

1. We run the test using a very long command. If we pass the codes to another person, he/she might not know how to run in a proper way. 
2. We need to run the test everytime. Why not we write some scripts to make it run automatically? 

In this chapter, we are going to automate the test process. Having said that, grunt can do a lot of things! You can refer to Chapter 10 of [Practical Nodejs](https://github.com/azat-co/practicalnode) for more examples. At the end of this chapter, We are going to setup automate code coverage report too. 


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
      all: ['./*.coffee'],
      options:
        configFile: 'coffeelint.json'
```

We are loading a npm package called `grunt-coffeelint`, so we need to install it:

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

### Version

0.1 - April 7, 2015 - Initial description of chapter 3
