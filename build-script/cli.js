#!/usr/bin/env node

/**
 * This file is executable, and is the command line interface,
 * for generating new icon files.
 */

const fs = require('fs')
const path = require('path')
const mkdirp = require('mkdirp')
const async = require('async')
const cli = require('cli')
const generatePng = require('./generate-png')
const generateIcns = require('./generate-icns')

const iconDir = '../vectors'

var options = cli.parse({
  all: ['a', 'Generate files for all icons', 'boolean', false],
  name: ['n', 'Name of icon to generate, if --all is not set', 'string', ''],
  icns: ['i', 'Generate only icns files', 'boolean', false],
  png: ['p', 'Generate only png files', 'boolean', false]
})

var jobsCompleted = 0
var totalJobs = 0

if (!options.icns && !options.png) {
  options.icns = true
  options.png = true
  cli.info('Either --icns nor --png are set, enabling both')
}

if (options.icns) {
  mkdirp(path.join(__dirname, '../icns'), function (err) {
    if (err)
      cli.fatal('Could not create directory for icns: ' + path.join(__dirname, '../dist/icns\n' + err))
  })
}

if (options.png) {
  mkdirp(path.join(__dirname, '../pngs'), function (err) {
    if (err)
      cli.fatal('Could not create directory for png: ' + path.join(__dirname, '../dist/png\n' + err))
  })
}

console.time('Generated files')

if (!options.all) {
  if (options.name === '') {
    cli.fatal('Either --all or --name must be set. See --help for more information.')
    return
  }

  if (options.icns) totalJobs += 1
  if (options.png) totalJobs += 1

  updateProgress()

  generateFiles(options.name)
} else {
  cli.info('Generating files for all icons')

  fs.readdir(path.join(__dirname, iconDir), function (err, files) {
    if (err) {
      cli.fatal('An error occured when trying to read directory "vectors"\n'+err)
    }

    totalJobs += files.length
    updateProgress()

    var genFuncs = []

    for (var i = 0; i < files.length; i++) {
      var file = files[i]
      if(path.extname(file) !== '.svg') continue

      function genFunc (callback) {
        generateFiles(path.basename(this.file, '.svg'))
          .then(function (result) {
            callback(null, result)
          })
          .catch(function (err) {
            callback(err)
          })
      }

      genFunc = genFunc.bind({ file: file })

      genFuncs.push(genFunc)
    }

    async.series(genFuncs, function (err, results) {
      if (err) {
        cli.error(err)
      }

      console.timeEnd('Generated files')
      cli.info('All done')
    })
  })
}

function generateFiles(name) {
  return new Promise (function (resolve, reject) {
    cli.info('Generating files for ' + name)

    async.parallel({
      icns: function (callback) {
        if (options.icns) {
          generateIcns(name)
            .then(function () {
              callback()
            })
            .catch(callback)
        } else {
          callback()
        }
      },
      png: function (callback) {
        if (options.png) {
          generatePng(name)
            .then(function () {
              callback()
            })
            .catch(function (err) {
              callback(err)
            })
        } else {
          callback()
        }
      }
    }, function (err) {
      if (err) reject(err)

      jobsCompleted++
      updateProgress()

      resolve(name)
    })
  })
}

function updateProgress() {
  if (totalJobs > 0){
    cli.progress(jobsCompleted / totalJobs)
    console.log()
  }
}
