/**
 * A function to generate 1024x1024 px png files from svg
 */

const path = require('path')
const fs = require('fs')
const svg2png = require('svg2png')

const iconDir = '../vectors'
const distDir = '../dist/png'

/**
 * Generate a 1024x1024px png from the specified icon name, and place it in ../dist/png
 * @param name the base name of an svg icon located in ../vectors
 */
function generatePNG (name) {
  fs.readFile(path.join(__dirname, iconDir, name + '.svg'), function (err, sourceBuffer){
    if(err){
      console.error(err)
      return
    }

    svg2png(sourceBuffer, { width: 1080, height: 1080 })
      .then(function (buffer) {
        fs.writeFile(path.join(__dirname, distDir, name + '.png'), buffer, function(err){
          if (err)
            console.error(err)
        })
      })
  })
}

module.exports = generatePNG
