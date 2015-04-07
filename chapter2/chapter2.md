Chapter 2: Test-driven Development for Blog Project
===================================================

I will develop exactly the same blog project in the book, but using a different approach and language. The book does provide a guideline on how to do test-driven development in Nodejs, but does not use this approach intensively. For example, we only have 3 tests at the end of chapter 5. 

This chapter is developed based on [Practical Nodejs](https://github.com/azat-co/practicalnode) Chapter 3 codes. 

## Getting Stated

First setup your project by:

```Shell
npm init

npm install express --save
npm install mocha --save-dev
npm install expect.js --save-dev
```

## Test-driven Development Time

First, open a new file `tests/app.coffee` and write the following codes to the file.

```CoffeeScript
app = require '../app'
expect = require 'expect.js'
```

Then we run the test by using the following commands (we will add it to our makefile eventually):

```Shell
mocha --compilers coffee:coffee-script/register app.coffee

# The result should be:
# 0 passing (2ms)
```

### Version

0.1 - April 6, 2015 - Initial description of chapter 2