/**
 * A function to generate icns files from svg
 * */

const fs = require('fs')
const path = require('path')
const icongen = require('icon-gen')

const iconDir = '../vectors'
const distDir = '../dist/icns'

/**
 * Generate an icns file from the specified icon name, and place it in ../dist/icns
 * @param name the base name of an svg icon located in ../vectors
 */
function generateIcon (name) {
  return new Promise(function (resolve, reject) {
    var options = {
      type: 'svg',
      report: true,
      modes: ['icns']
    }

    options.names = {
      icns: name
    }

    icongen(path.join(__dirname, iconDir, name + '.svg'), distDir, options)
      .then(resolve)
      .catch(reject)
  })
}

module.exports = generateIcon