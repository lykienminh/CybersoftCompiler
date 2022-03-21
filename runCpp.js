const { exec } = require("child_process");

const runCpp = (filepath, testCase, tle = 5000) => {
  console.log(filepath, testCase);
  return new Promise((resolve, reject) => {
    exec(
      `${filepath} ${testCase}`, { timeout: tle },  
        (error, stdout, stderr) => {
        error && reject({error, stderr});
        resolve(stdout);
      }
    );
  });
};

module.exports = {
  runCpp,
};