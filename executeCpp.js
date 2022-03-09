const { exec } = require("child_process");
const fs = require("fs");
const path = require("path");

const outputPath = path.join(__dirname, "outputs");

if (!fs.existsSync(outputPath)) {
  fs.mkdirSync(outputPath, { recursive: true });
}

const executeCpp = (filepath) => {
  // basename: <name>.cpp
  const jobId = path.basename(filepath).split(".")[0];
  const outPath = path.join(outputPath, `${jobId}.exe`);

  return new Promise((resolve, reject) => {
    exec(
      `g++ ${filepath} -o ${outPath} && cd ${outputPath} && ${jobId}.exe`, { timeout: 1500 }, (error, stdout, stderr) => {
        error && reject({error, stderr});
        // stderr && reject({stdout}); maybe not need for us
        resolve(stdout);
      }
    );
  });
};

module.exports = {
  executeCpp,
};
/*
{
  "code": "#include <iostream>\n#include <stdio.h>\nint main() {printf(\"Hello world!\");return 0;}"
}
int uniqueNumber(vector<int> arr) {
    sort(arr.begin(), arr.end());
    int result = arr[0];
    for (int i = 0; i < arr.size() - 1; i++) {
        if (arr[i] == arr[i+1]) {
            i++;
        }
        else {
            result = arr[i];
            break;
        };
    }
    return result;
}
int uniqueNumber(vector<int> arr) {
    sort(arr.begin(), arr.end());
    for (int i = 0; i < arr.size() - 1; i++) {
        if (arr[i] == arr[i+1]) {
            i++;
        }
        else return arr[i];
    }
}
*/