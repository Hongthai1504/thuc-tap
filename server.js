const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json()); // To read JSON data

// 1. Connect to internship_project Database
const db = mysql.createConnection({
  host: "127.0.0.1",
  user: "root",
  password: "", // Default Xampp has no password
  database: "internship_project",
});

db.connect((err) => {
  if (err) {
    console.error("Database connection error: ", err);
    return;
  }
  console.log("Database connection successful!");
});

// 2. Write an API to display a list of products (GET /api/products)
app.get("/api/products", (reg, res) => {
  // Query to retrieve all products
  const sql = "SELECT * FROM Products";

  db.query(sql, (err, results) => {
    if (err) {
      return res.status(500).json({ error: "Server error!" });
    }
    // Returns a list of products in JSON format
    res.json(results);
  });
});

// 3. Start the server on port 3000
const PORT = 3000;
app.listen(PORT, () => {
  console.log(
    "The server backend is currently running at http://localhost:${PORT}",
  );
});
