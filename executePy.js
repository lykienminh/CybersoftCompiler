const { exec } = require("child_process");

const executePy = (filepath) => {
  return new Promise((resolve, reject) => {
    exec(
      `python ${filepath}`,
      (error, stdout, stderr) => {
        error && reject(stderr);
        stderr && reject(stderr);
        resolve(stdout);
      }
    );
  });
};

module.exports = {
  executePy,
};

/*
{
  "language": "py",
  "code": "print(\"Hello world!\")"
}
*/