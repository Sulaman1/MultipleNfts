var fs = require("fs");
const lineReader = require('line-reader');
const readLine = require('readline');
const check = require("../../metadata/pug.json");
const val = require("../../uri/URIjson.json");
const path = require("path");

const uriTemplet = {
}

breedName = ['pug', 'brenard', 'k9']
image_to_upload = ['img1', 'img2', 'img3']

const sleep = (milliseconds) => {
   console.log("Sleeping...")
   return new Promise(resolve => setTimeout(resolve, milliseconds))
}

module.exports = (cb) => {

   function readText() {

      var file = './input.txt';
      var rl = readLine.createInterface({
         input: fs.createReadStream(file),
         output: process.stdout,
         terminal: false
      });
      rl.on('line', function (text) {
         console.log(text);
      });
   }
   // readText();

   function readJson() {
      uriMetadata = uriTemplet;
      for (var i = 0; i < 3; i++) {

         uriMetadata[breedName[i]] = image_to_upload[i];
         URIfilename = 'uri/' + 'URIjson'
         let URIdata = JSON.stringify(uriMetadata)
         fs.writeFileSync(URIfilename + '.json', URIdata)
      }
      v = val["pug"]
      console.log("PUG URI : ", v)
   }
   //readJson();

   var i = 0;
   async function fileTest() {
      var filePath = path.join(__dirname, '/input.txt');
      console.log(filePath)
      // // Asynchronous read
      // fs.readFile(filePath, function (err, data) {
      //    if (err) {
      //       return console.error(err);
      //    }
      //    console.log("Asynchronous read: " + data);
      // });

      // Synchronous read
      console.log('start')
      var data = fs.readFileSync(filePath, 'utf-8');
      var data2 = fs.createReadStream(filePath)
      console.log("Synchronous read: " + data2);

      const myInterface = readLine.createInterface({
         input: fs.createReadStream(filePath),
         output: process.stdout,
         terminal: false
      });

      var lineno = 0;
      myInterface.on('line', (line) => {
         lineno++;
         console.log('Line number ' + lineno + ': ' + line);
      });

      console.log("Program Ended");
   }

   //fileTest();

   function filetestRead() {
      var filePath = path.join(__dirname, '/input.txt');
      console.log(filePath)
      lineReader.eachLine(filePath, (line, last) => {
         console.log(line);
      });
   }
   //filetestRead()


   function readLines() {
      var filePath = path.join(__dirname, '/IPFS SportStars Punk.txt');
      var text = fs.readFileSync(filePath, 'utf-8');
      var textByLine = text.split('\n')

      console.log(textByLine.length)
   }
   readLines();

   cb();
}
