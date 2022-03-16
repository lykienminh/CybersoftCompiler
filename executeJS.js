const { exec } = require("child_process");

const executeJS = (filepath, tle = 10000) => {
  return new Promise((resolve, reject) => {
    exec(
      `node ${filepath}`, { timeout: tle },
      (error, stdout, stderr) => {
        error && reject({error, stderr});
        // stderr && reject({stdout}); maybe not need for us
        resolve(stdout);
      }
    );
  });
};

module.exports = {
  executeJS,
};

// Test:
// 
// {
//   "language": "javascript",
//   "code": "function sub(a, b) {\nreturn a-b\n}\nconsole.log(sub(6, 2))"
// }
//   console.log('Hello World');
