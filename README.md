### CybersoftCompiler ###

# Install environment #
> Python3 3.9.1  
> g++ (MinGW.org GCC Build-2) 9.2.0  
> java 17.0.1  
> nodeJS v14.17.0  
> npm 8.1.4  

# Execution #
- Run NodeJS by running the command `node index.js`.
- Make a *POST* api call to `https://localhost:3001/run`.
- Example.  
<!-- - npm config set strict-ssl=false -->
<!-- - set NODE_TLS_REJECT_UNAUTHORIZED=0  -->

1 - C++  
Input  
```json
{
  "language": "cpp",
  "code": "#include <iostream>\n#include <stdio.h>\n\nusing namespace std;\n\nint main() {\nint a = 5, b=2;\nfor (int i = 0; i<a; i++){\ncout << b;\n}\nreturn 0;\n}"
}
```
Output  
```json
{
    "output": "22222"
}
```

2 - Python  
Input  
```json
{
  "language": "py",
  "code": "def sum(a,b):\n\treturn a+b\nprint(sum(2,3))"
}
```
Output  
```json
{
    "output": "5\n"
}
```

3 - Java  
Input  
```json
{
  "language": "java",
  "code": "class HelloWorld {\n\tpublic static void main(String[] args) {\n\t\tSystem.out.println(\"Hello, World!\"); \n\t}\n}"
}
```
Output  
```json
{
    "output": "Hello, World!\n"
}
```
