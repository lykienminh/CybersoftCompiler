### CybersoftCompiler ###

# 1. Install environment #
> Python3 3.9.1  
> g++ (MinGW.org GCC Build-2) 9.2.0  
> java 17.0.1  
> nodeJS v14.17.0  
> npm 8.1.4  

# 2. Execution #
> Run NodeJS by running the command `node index.js`.  
## 2.1. Run Test Case <ins>UPDATE 05/03/2022</ins> ##  
Make a *POST* api call to `https://localhost:3001/submit`.  
> Format
```json
{
  "question": [21, 22, 23, 24],
  "language": ["cpp", "java", "js" ,"py"],
  "code": ""
}
```

### 2.1.1. Python  ###   
a. Right answer
> Input  
```json
{
  "question": 21,
  "language": "py",
  "code": "def uniqueNumber(arr):\n\tfor x in arr:\n\t\tif arr.count(x) == 1:\n\t\t\treturn x\n"
}
```
> Output  
```json
[
    {
        "id": 1,
        "input": "[19, 17, 19, 68, 68]",
        "actualOutput": "17",
        "expectedOutput": "17",
        "message": "Right answer"
    },
    {
        "id": 2,
        "input": "[34, 76, 76]",
        "actualOutput": "34",
        "expectedOutput": "34",
        "message": "Right answer"
    },
    {
        "id": 3,
        "input": "[46, 46, 11, 11, 59, 59, 55, 55, 35]",
        "actualOutput": "35",
        "expectedOutput": "35",
        "message": "Right answer"
    },
    {
        "id": 4,
        "input": "[19, 1, 41, 41, 94, 1, 94, 80, 19]",
        "actualOutput": "80",
        "expectedOutput": "80",
        "message": "Right answer"
    },
    {
        "id": 5,
        "input": "[86, 51, 51, 72, 57, 57, 78, 78, 86]",
        "actualOutput": "72",
        "expectedOutput": "72",
        "message": "Right answer"
    },
    {
        "id": 6,
        "input": "[45, 90, 45, 90, 26, 38, 49, 26, 38]",
        "actualOutput": "49",
        "expectedOutput": "49",
        "message": "Right answer"
    }
]
```
b. Wrong answer  
c. Error  

## 2.2. Compiler ##
Make a *POST* api call to `https://localhost:3001/run`.
<!-- - npm config set strict-ssl=false -->
<!-- - set NODE_TLS_REJECT_UNAUTHORIZED=0  -->

2.2.1. C++  
> Input  
```json
{
  "language": "cpp",
  "code": "#include <iostream>\n#include <stdio.h>\n\nusing namespace std;\n\nint main() {\nint a = 5, b=2;\nfor (int i = 0; i<a; i++){\ncout << b;\n}\nreturn 0;\n}"
}
```
> Output  
```json
{
    "output": "22222"
}
```

2.2.2. Python  
> Input  
```json
{
  "language": "py",
  "code": "def sum(a,b):\n\treturn a+b\nprint(sum(2,3))"
}
```
> Output  
```json
{
    "output": "5\n"
}
```

2.2.3. Java  
> Input  
```json
{
  "language": "java",
  "code": "class HelloWorld {\n\tpublic static void main(String[] args) {\n\t\tSystem.out.println(\"Hello, World!\"); \n\t}\n}"
}
```
> Output  
```json
{
    "output": "Hello, World!\n"
}
```
## 2.3. Other API ##  
- Get question information  
`https://localhost:3001/:id`  
- Get all question ID  
`https://localhost:3001/getAllQuestionID`  
- Get all question information  
`https://localhost:3001/getAllQuestion`  
