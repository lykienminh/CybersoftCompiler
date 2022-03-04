const { exec } = require("child_process");

const executeJava = (filepath) => {
  return new Promise((resolve, reject) => {
    exec(
      `java ${filepath}`,
      (error, stdout, stderr) => {
        error && reject(stderr);
        stderr && reject(stderr);
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