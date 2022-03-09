const express = require("express");

const { generateFile } = require("./generateFile"); 
const { executeCpp } = require("./executeCpp");
const { executePy } = require("./executePy");
const { executeJava } = require("./executeJava");
const { executeJS } = require("./executeJS");

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

app.use(express.urlencoded( {extended: true} ));
app.use(express.json());
app.use(function (req, res, next) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,DELETE,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Access-Control-Allow-Headers');
  next();
});

app.get('/', (req, res) =>{
    return res.json({"Message": "CyberSoft Compiler Hello!", "API": ["/getAllQuestionID", "/getAllQuestion", "/:id"]});
})

async function getQuestionID (id) {
  try {
    const question_id = await pool.query('SELECT * FROM problem WHERE question_id = $1', [id]);
    const test_case = await pool.query('SELECT testcase_id, _input, _output FROM testcase WHERE question_id = $1', [id]);
    const init_code = await pool.query('SELECT _language, _function, base_code, _answer FROM init_code WHERE question_id = $1', [id]);
    let result = { ...question_id.rows[0], "test_case": test_case.rows, "init_code": init_code.rows };
    return result;
  } catch(error) {
    throw error;
  }
}

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

// var http = require('http');
app.get("/getAllQuestion", async (req, res) => {
  try {
    let questionID = await pool.query('SELECT question_id FROM problem');
    let result = [];
    questionID.rows.forEach(element => {
      result.push(element.question_id)
    });

    questionID = result;
    result = [];
    /* comment by github@lykienminh
    questionID.forEach(element => {
      let temp = getQuestionID(element)
      result.push(temp)
    });*/
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

async function runCode (props) {
  const { language = "cpp", code } = props;

  console.log(language, "length:", code.length);

  if (code === undefined || code === "") {
    return [false, "Empty code body!"];
  }
  // let result by github@lykienminh
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

app.post('/run', async (req, res) => {
  const result = await runCode(req.body);
  if (!result[0]) return res.status(400).json({success: false, error: result[1]});
  return res.status(200).json({success: true, output: result[1]});
})

/* comment by github@lykienminh
async function getTestCase (id) {
  try {
    const test_case = await pool.query('SELECT testcase_id, _input, _output FROM testcase WHERE question_id = $1', [id]);
    return test_case;
  } catch (error) {
    throw error;
  }
}*/

function generateCode (base_code, user_submit, test_case) {
  let result = base_code.replace("__function__", user_submit);
  if (test_case[0] === '[' && test_case.slice(-1) === ']') {
    result = result.replace("__test_case__", test_case.slice(1, -1));
  }
  else result = result.replace("__test_case__", test_case);

  return result;
}

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

    // console.log(testCase.rowCount);

    for (let i = 0; i < testCase.rowCount; i++) {
      let tempOutput = "", actualMessage = "";
      let codeNewData = generateCode(baseCode["base_code"], code, testCase.rows[i]["_input"]);

      // call api compiler
      let actualOutput = await runCode({language, code: codeNewData});

      // error
      if (!actualOutput[0]) {
        tempOutput = await JSON.stringify({ 
          "id":  testCase.rows[i]["testcase_id"],
          "input": testCase.rows[i]["_input"],
          "actualOutput": "",
          "expectedOutput": testCase.rows[i]["_output"],
          "message": actualOutput[1],
        });
      }
      
      else {
        if(actualOutput[1].slice(-1) === '\n' || actualOutput[1].slice(-1) === '\r') actualOutput[1] = actualOutput[1].slice(0, -1);
        if(actualOutput[1].slice(-1) === '\r') actualOutput[1] = actualOutput[1].slice(0, -1);


        if (actualOutput[1] === testCase.rows[i]["_output"]) actualMessage = "Right answer"
        if (actualOutput[1] === testCase.rows[i]["_output"].split('\\n').join('\n')) actualMessage = "Right answer"  
        if (actualMessage === "") actualMessage = "Wrong answer"
        tempOutput = await JSON.stringify({ 
          "id":  testCase.rows[i]["testcase_id"],
          "input": testCase.rows[i]["_input"],
          "actualOutput": actualOutput[1],
          "expectedOutput": testCase.rows[i]["_output"],
          "message": actualMessage,
        });
      }

      tempOutput = JSON.parse(tempOutput)
      final.push(tempOutput);
    }
    return res.status(200).send(final);
  } catch (err) {
    console.log(err);
  }
})
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

const PORT = process.env.PORT || 3001;
process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = 0;
app.listen(PORT, () => {
  console.warn(`App listening on http://localhost:${PORT}`);
});  