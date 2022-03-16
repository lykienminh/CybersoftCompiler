const { exec } = require("child_process");

const executeJava = (filepath, tle = 10000) => {
  return new Promise((resolve, reject) => {
    exec(
      `java ${filepath}`, { timeout: tle },
      (error, stdout, stderr) => {
        error && reject({error, stderr});
        // stderr && reject({stdout}); maybe not need for us
        resolve(stdout);
      }
    );
  });
};

module.exports = {
  executeJava,
};

/*
{
  "language": "java",
  "code": "

// Your First Program

class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!"); 
    }
}
"
}
*/