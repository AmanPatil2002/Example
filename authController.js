const db = require("../config/db");
const jwt = require("jsonwebtoken");
require('dotenv').config();

const SECRET_KEY = process.env.SECRET_KEY;

const getAuth = (req, res) => {
  db.query("SELECT * FROM login", (err, result) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ message: err.message });
    }
    res.json(result);
  });
};

const postAuth = (req, res) => {
  const { username,email, password, role } = req.body;
  db.query("SELECT * FROM login WHERE UserEmail =?",[email], (err, result)=>{
    if(err){
      return res.status(500).json({ message: err.message });
    }
    if (result.length > 0) {
      return res.status(400).json({message: "Username already exists",});
    }
    const normalizedRole = (role || "User").toLowerCase();
    db.query("INSERT INTO login (username, UserEmail, UserPassword, Role) VALUES (?, ?, ?, ?)",[username, email, password, normalizedRole], (err, result) => {
      if (err) {
        return res.status(500).json({ message: err.message });
      }
      const token = jwt.sign({ id: result.insertId, email, role: normalizedRole },
        SECRET_KEY,
        { expiresIn: "1h" }
      );
      res.json({
        message: "Registration Successful",
        token,
        id: result.insertId,username,email,role: normalizedRole,
      });
    });
  })
};

const checkLogin = (req, res) => {
  const { email, password } = req.body;
  db.query("SELECT * FROM login WHERE UserEmail = ?", [email], (err, result) => {
    if (err) {
      return res.status(500).json({ message: err.message });
    }
    if (result.length === 0) {
      return res.status(401).json({ message: "Wrong Username" });
    }
    const user = result[0];
    if (password !== user.UserPassword) {
      return res.status(401).json({ message: "Wrong Password" });
    }
    const token = jwt.sign({ id: user.id, email: user.UserEmail, role: user.Role },
      SECRET_KEY,
      { expiresIn: "1h" }
    );
    res.json({
      message: "Login Successful",
      token,
      id: user.id,email: user.UserEmail,role: user.Role,
    });
  });
};

module.exports = { getAuth, postAuth, checkLogin };
