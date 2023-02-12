var express = require("express");
var router = express.Router();

const db = require("../database/db_connect");

/* GET home page. */
router.get("/", (req, res, next) => {
  res.render("index", { title: "Express" });
});

router.post("/list", (req, res) => {
  db.query(
    `SELECT * FROM list WHERE date BETWEEN ${req.body.start} AND ${req.body.end}`,
    (err, rows, fields) => {
      if (!err) {
        let current = new Date(req.body.start + " 9:00:00");
        let end = new Date(req.body.end + " 9:00:00");
        let result = {};

        while (current <= end) {
          let date = current.toISOString().split("T")[0];
          result[date] = [];
          current.setDate(current.getDate() + 1);
        }

        for (let key of rows) {
          let d = key.date;
          delete key.date;
          result[d].push(key);
        }

        res.status(200).json(result);
      } else {
        res.send(err);
      }
    }
  );
});

router.post("/contents", (req, res) => {
  db.query(
    `SELECT * FROM contents WHERE num = ${req.body.num}`,
    (err, rows, fields) => {
      if (!err) {
        res.status(200).json(rows[0]);
      } else {
        res.send(err);
      }
    }
  );
});

module.exports = router;
