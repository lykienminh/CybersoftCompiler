const { exec } = require("child_process");
const fs = require("fs");
const path = require("path");

const outputPath = path.join(__dirname, "outputs");

if (!fs.existsSync(outputPath)) {
  fs.mkdirSync(outputPath, { recursive: true });
}

const compileCpp = (filepath, tle = 10000) => {
  // basename: <name>.cpp
  const jobId = path.basename(filepath).split(".")[0];
  const outPath = path.join(outputPath, `${jobId}.exe`);
  return new Promise((resolve, reject) => {
    exec(
      `g++ ${filepath} -o ${outPath}`, { timeout: tle }, 
        (error, stdout, stderr) => {
        error && reject({error, stderr});
        // stderr && reject({stdout}); maybe not need for us
        resolve(outPath);
      }
    );
  });
};

module.exports = {
  compileCpp,
};