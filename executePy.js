const { exec } = require("child_process");

const executePy = (filepath, tle = 10000) => {
  return new Promise((resolve, reject) => {
    exec(
      `python ${filepath}`, { timeout: tle },
      (error, stdout, stderr) => {
        error && reject({error, stderr});
        // stderr && reject({stdout}); maybe not need for us
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