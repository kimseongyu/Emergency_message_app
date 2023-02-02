var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.post('/list', function(req, res) {
  res.status(200).json({
    "2023-02-05":[
      {"num":192577, "division":"기타", "step":"안전안내", "title":"2023/02/02 20:04:12 [서울경찰청]"}
    ],
    "2023-02-04":[
      {"num":192576, "division":"전염병", "step":"안전안내", "title":"2023/02/02 20:04:12 [대전경찰청]"}
    ],
    "2023-02-03":[
      {"num":192575, "division":"한파", "step":"안전안내", "title":"2023/02/02 20:04:12 [대구경찰청]"}
    ],
    "2023-02-02":[
      {"num":192574, "division":"태풍", "step":"안전안내", "title":"2023/02/02 20:04:12 [부산경찰청]"}
    ]
  });
});

router.post('/contents', function(req, res) {
  res.status(200).json({
    192577:{"title":"2023/02/02 20:04:12 [서울경찰청]", "region":"서울 마포구", "date":"2023-02-02 20:04:30", "content":"정승원 실종"},
    192576:{"title":"2023/02/02 20:04:12 [대전경찰청]", "region":"대전 유성구", "date":"2023-02-02 20:04:30", "content":"코로나19 감염조심"},
    192575:{"title":"2023/02/02 20:04:12 [대구경찰청]", "region":"대구 달서구", "date":"2023-02-02 20:04:30", "content":"대구 한파조심"},
    192574:{"title":"2023/02/02 20:04:12 [부산경찰청]", "region":"부산 해운대구", "date":"2023-02-02 20:04:30", "content":"태풍조심"},
  });
});

module.exports = router;
