const express = require("express");

const { generateFile } = require("./generateFile"); 
const { executeCpp } = require("./executeCpp");
const { executePy } = require("./executePy");
const { executeJava } = require("./executeJava");

const {Client} = require('pg');
const pool = new Client({
    user: 'jqwimixjeodukb',         
    host: 'ec2-52-44-80-40.compute-1.amazonaws.com',
    database: 'dcrj71ad8ke06o',
    password: '1d7d0dc399de2542ed3bfa3d4107ca21b3bd8965a1c554e353b15f446023d71d',    
    port: 5432,
    ssl: true,
});
pool.connect();

const app = express();

app.use(express.urlencoded( {extended: true} ));
app.use(express.json());

app.get('/', (req, res) =>{
    return res.json({Message: "CyberSoft Compiler Hello!"});
})

app.get("/:id", async (req, res) => {
  try {
      const id = parseInt(req.params.id)
      const question_id = await pool.query('SELECT * FROM problem WHERE question_id = $1', [id]);
      res.status(200).json(question_id.rows);
  } catch(error) {
      res.status(500).send(error);
  }
})

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

    return res.json({ output });
    //return res.status(200).send(output);
  } catch (err) {
    res.status(500).json({ err });
  }
})

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
  console.warn(`App listening on http://localhost:${PORT}`);
});  