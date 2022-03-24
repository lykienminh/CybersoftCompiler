const express = require("express");
const { generateFile } = require("./generateFile"); 
const { executeCpp } = require("./executeCpp");
const { executePy } = require("./executePy");
const { executeJava } = require("./executeJava");
const { executeJS } = require("./executeJS");
const { compileCpp } = require("./compileCpp");
const { runCpp } = require("./runCpp");

/* 
 * =========================================================================================
 * Description : Connect database
 * =========================================================================================
 */

const {Client} = require('pg');
const pool = new Client({
    user: 'rskcxehdjtxnnh',         
    host: 'ec2-3-89-214-80.compute-1.amazonaws.com',
    database: 'd22obclk3e86pt',
    password: '3d3e378cf781a612ecb857dc75eec6c1f569df987e6b1d2088a0c1fdaee7943a',    
    port: 5432,
    ssl: true,
});
pool.connect();

const app = express();

/* 
 * =========================================================================================
 * Description : Config request
 * =========================================================================================
 */

app.use(express.urlencoded( {extended: true} ));
app.use(express.json());
app.use(function (req, res, next) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,DELETE,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Access-Control-Allow-Headers');
  next();
});

/* 
 * =========================================================================================
 * Description : API
 * =========================================================================================
 */

app.get('/', (req, res) =>{
    return res.json({"Message": "CyberSoft Compiler Hello!", "API": ["/getAllQuestionID", "/getAllQuestion", "/:id"]});
})

app.get("/getAllQuestionID", async (req, res) => {
  try {
    const questionID = await pool.query('SELECT question_id FROM problem');
    let result = [];
    questionID.rows.forEach(element => {
      result.push(element.question_id)
    });
    res.status(200).json(result);
  } catch(error) {
    res.status(500).send(error);
  }
})

app.get("/getAllQuestion", async (req, res) => {
  try {
    let questionID = await pool.query('SELECT question_id FROM problem');
    let result = [];
    questionID.rows.forEach(element => {
      result.push(element.question_id)
    });

    questionID = result;
    result = [];
    
    for (const element in questionID) {
      let temp = await getQuestionID(questionID[element]);
      result.push(temp);
    }

    res.status(200).json(result);
  } catch(error) {
      res.status(500).send(error);
  }
})

app.get("/:id", async (req, res) => {
  try {
    const id = parseInt(req.params.id)
    let result = await getQuestionID(id)
    res.status(200).json(result);
  } catch(error) {
    res.status(500).send(error);
  }
})

app.post('/run', async (req, res) => {
  const result = await runCode(req.body);
  if (!result[0]) return res.status(400).json({success: false, error: result[1]});
  return res.status(200).json({success: true, output: result[1]});
})

app.post('/submit', async (req, res) => {
  try {
    const { question, language, code } = req.body;
    if (question === undefined || question === "") 
      return res.status(400).json({success: false, message: "Don't have question ID"});
    if (language === undefined || language === "") 
      return res.status(400).json({success: false, message: "Don't have language"});
    const testCase = await pool.query('SELECT testcase_id, _input, _output FROM testcase WHERE question_id = $1', [question]);
    let baseCode = await pool.query('SELECT base_code FROM init_code WHERE question_id = $1 AND _language = $2', [question, language]);
    baseCode = baseCode.rows[0];
    
    let final = [];
    // handleCppSubmit
    let compileStatus;
    if (language === 'cpp') {
      let codeNewData = generateCode(baseCode["base_code"], code, "argv[1]");
      compileStatus = await handleCompileCpp(codeNewData);
      console.log(language, "length:", codeNewData.length, "compile");
    }
    // loop all testCase
    for (let i = 0; i < testCase.rowCount; i++) {
      let actualOutput = [];

      if (language !== 'cpp') {
        // Java, JS, Python
        let codeNewData = generateCode(baseCode["base_code"], code, testCase.rows[i]["_input"]);
        // call function compiler
        console.log(language, "length:", codeNewData.length);
        actualOutput = await runCode({language, code: codeNewData});
      }
      else {
        if (compileStatus[0]) actualOutput = await handleRunCpp(compileStatus[1], testCase.rows[i]["_input"]);
        else actualOutput = compileStatus;
      }

      // Format Output = [isSuccess, Output] => JSON
      final.push(formatOutput(actualOutput, testCase, i));
    }

    return res.status(200).send(final);
  } catch (err) {
    console.log(err);
  }
})

const PORT = process.env.PORT || 3001;
process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = 0;
app.listen(PORT, () => {
  console.warn(`App listening on http://localhost:${PORT}`);
});  

/* 
 * =========================================================================================
 * Description : Helping function
 * =========================================================================================
 */

async function getQuestionID (id) {
  try {
    const problem = await pool.query('SELECT * FROM problem WHERE question_id = $1', [id]);
    const test_case = await pool.query('SELECT testcase_id, _input, _output FROM testcase WHERE question_id = $1', [id]);
    const init_code = await pool.query('SELECT _language, tle, _function, base_code, _answer FROM init_code WHERE question_id = $1', [id]);
    const problem_detail = await pool.query('SELECT locale, question_title, problem, explanation, constraint_input, constraint_output, constraint_time FROM problem_detail WHERE question_id = $1', [id]);
    
    let result = { ...problem.rows[0] };

    problem_detail.rows.forEach(element => {
      const _locale = element["locale"]
      delete element.locale
      result[_locale] = element
    });

    result = { ...result, "test_case": test_case.rows, "init_code": init_code.rows };
    return result;
  } catch(error) {
    throw error;
  }
}

async function runCode (props) {
  const { language = "cpp", code } = props;

  // console.log(language, "length:", code.length);

  if (code === undefined || code === "") {
    return [false, "Empty code body!"];
  }
  // let result by github@lykienminh
  try {
    // need to generate a file with content from the request
    const filepath = await generateFile(language, code);
    // we need to run the file and send the response
    let output;
    if (language === "cpp") {
      output = await executeCpp(filepath);
    } else if (language === "py") {
      output = await executePy(filepath);
    }
    else if (language === "java") {
      output = await executeJava(filepath);
    }
    else if (language === "js") {
      output = await executeJS(filepath);
    }
    else {
      return [false, "Don't know this language"];
    }
    return [true, output];
    // comment return res.status(200).send(output);
  } catch (err) {
    if (err["error"]["killed"] && err["error"]["signal"] === 'SIGTERM') return [false, 'Time limit exceeded'];
    return [false, err["stderr"]];
  }
}

function generateCode (base_code, user_submit, test_case) {
  let result = base_code.replace("__function__", user_submit);
  if (test_case[0] === '[' && test_case.slice(-1) === ']') {
    result = result.replace("__test_case__", test_case.slice(1, -1));
  }
  else result = result.replace("__test_case__", test_case);

  return result;
}

function formatOutput (actualOutput, testCase, i) {
  let tempOutputFormatResult = "", actualMessage = "";

  // error
  if (!actualOutput[0]) {
    tempOutputFormatResult = JSON.stringify({ 
      "id":  testCase.rows[i]["testcase_id"],
      "input": testCase.rows[i]["_input"],
      "actualOutput": "",
      "expectedOutput": testCase.rows[i]["_output"],
      "message": actualOutput[1],
    });
  }
  // success
  else {
    if(actualOutput[1].slice(-1) === '\n' || actualOutput[1].slice(-1) === '\r') actualOutput[1] = actualOutput[1].slice(0, -1);
    if(actualOutput[1].slice(-1) === '\r') actualOutput[1] = actualOutput[1].slice(0, -1);

    if (actualOutput[1][0] === '{' && actualOutput[1].slice(-1) === '}') {
      if (object_equals(testCase.rows[i]["_output"], actualOutput[1])) actualMessage = "Right answer"
    }
    else {
      if (actualOutput[1] === testCase.rows[i]["_output"]) actualMessage = "Right answer"
      if (actualOutput[1] === testCase.rows[i]["_output"].split('\\n').join('\n')) actualMessage = "Right answer"  
    }
    if (actualMessage === "") actualMessage = "Wrong answer"

    tempOutputFormatResult = JSON.stringify({ 
      "id":  testCase.rows[i]["testcase_id"],
      "input": testCase.rows[i]["_input"],
      "actualOutput": actualOutput[1],
      "expectedOutput": testCase.rows[i]["_output"],
      "message": actualMessage,
    });
  }

  tempOutputFormatResult = JSON.parse(tempOutputFormatResult)

  return tempOutputFormatResult
}

async function handleCompileCpp (code) {
  try {
    // need to generate a c++ file with content from the request
    const filepath = await generateFile('cpp', code);
    let outPath = await compileCpp(filepath);

    return [true, outPath];
  } catch (err) {
    if (err["error"]["killed"] && err["error"]["signal"] === 'SIGTERM') return [false, 'Time limit exceeded'];
    return [false, err["stderr"]];
  }
}

async function handleRunCpp (filepath, testCase) {
  if (testCase[0] === '[' && testCase.slice(-1) === ']') {
    testCase = "\"" + testCase.slice(1, -1) + "\"";
  }
  else testCase = "\"" + testCase + "\"";
  try {
    let output = await runCpp (filepath, testCase);
    return [true, output];
  } catch (err) {
    if (err["error"]["killed"] && err["error"]["signal"] === 'SIGTERM') return [false, 'Time limit exceeded'];
    return [false, err["stderr"]];
  }
}

function object_equals(expectedOutput, actualOutput) {
  const x = JSON.parse(expectedOutput)
  const y = JSON.parse(actualOutput)

  if (x === y) return true;
  // if both x and y are null or undefined and exactly the same

  if ( !(x instanceof Object) || !(y instanceof Object) ) return false;
  // if they are not strictly equal, they both need to be Objects

  if (x.constructor !== y.constructor) return false;
  // they must have the exact same prototype chain, the closest we can do is
  // test there constructor.

  for (var p in x) {
      if ( !x.hasOwnProperty(p) ) continue;
      // other properties were tested using x.constructor === y.constructor
  
      if ( !y.hasOwnProperty(p) ) return false;
      // allows to compare x[ p ] and y[ p ] when set to undefined
  
      if ( x[p] === y[p] ) continue;
      // if they have the same strict value or identity then they are equal
  
      if ( typeof(x[p]) !== "object" ) return false;
      // Numbers, Strings, Functions, Booleans must be strictly equal
  
      if ( !object_equals(x[p],  y[p]) ) return false;
      // Objects and Arrays must be tested recursively
  }

  for (p in y)
      if ( y.hasOwnProperty(p) && !x.hasOwnProperty(p) )
          return false;
          // allows x[ p ] to be set to undefined
          
  return true;
}

/* Created by github@lykienminh on 2019-02-07.
 * =========================================================================================
 * Description : There's nothing here :v
 * =========================================================================================
 */

/* comment by github@lykienminh
app.post('/run', async (req, res) =>{
  const { language = "cpp", code } = req.body;

  console.log(language, "Length:", code.length);

  if (code === undefined) {
    return res.status(400).json({ success: false, error: "Empty code body!" });
  }

  try {
    // need to generate a c++ file with content from the request
    const filepath = await generateFile(language, code);
    // we need to run the file and send the response
    let output;
    if (language === "cpp") {
      output = await executeCpp(filepath);
    } else if (language === "py") {
      output = await executePy(filepath);
    }
    else if (language === "java") {
      output = await executeJava(filepath);
    }
    else if (language === "javascript") {
      output = await executeJS(filepath);
    }

    return res.json({ output });
    //return res.status(200).send(output);
  } catch (err) {
    res.status(500).json({ err });
  }
})*/