const { exec } = require("child_process");

const executePy = (filepath) => {
  return new Promise((resolve, reject) => {
    exec(
      `python ${filepath}`,
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