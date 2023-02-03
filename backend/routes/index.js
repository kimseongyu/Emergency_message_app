var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', (req, res, next) => {
  res.render('index', { title: 'Express' });
});

router.post('/list', (req, res) => {
  const data = require("../database/list.json");

  // Add Time Difference between UTC and KST
  let current = new Date(req.body.start + " 9:00:00");
  let end = new Date(req.body.end + " 9:00:00");
  let result = {};

  while(current <= end){
    let date = current.toISOString().split("T")[0];  
    result[date] = data[date]
    current.setDate(current.getDate() + 1);
  }

  res.status(200).json(result);
});

router.post('/contents', (req, res) => {
  const data = require("../database/contents.json");

  res.status(200).json(data[req.body.num]);
});

module.exports = router;
