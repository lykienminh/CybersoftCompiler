const { exec } = require("child_process");

const executeJS = (filepath) => {
  return new Promise((resolve, reject) => {
    exec(
      `node ${filepath}`,
      (error, stdout, stderr) => {
        error && reject({ error, stderr });
        stderr && reject(stderr);
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