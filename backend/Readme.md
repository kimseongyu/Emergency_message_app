# Emergency Message App BackEnd

## Install
1. nodejs
2. express
3. maria db

참고 사이트 : https://www.youdad.kr/making-simple-node-api-server

## Execute
```
$ npm start
```
# API
## Message List
날짜별 재난문자 리스트를 가져온다.


### Request
```
POST /list
```
```
{
    "start":string,
    "end":string,
}
```
example
```
{
    "start":"2023-02-03",
    "end":"2023-02-05",
}
```

### Response
```
{
    "inputDate":[
      {"num":string, "division":string, "step":string, "title":string}
    ]
}
```
example
```
{
    "2023-02-05":[
      {"num":"192577", "division":"기타", "step":"안전안내", "title":"2023/02/02 20:04:12 [서울경찰청]"}
    ],
    "2023-02-04":[
      {"num":"192576", "division":"전염병", "step":"안전안내", "title":"2023/02/02 20:04:12 [대전경찰청]"}
    ],
    "2023-02-03":[
      {"num":"192575", "division":"한파", "step":"안전안내", "title":"2023/02/02 20:04:12 [대구경찰청]"}
    ]
}
```

## Contents
글 별로 가지고 있는 내용들을 가져온다.

### Request
```
POST /contents
```
```
{
    "num": string
}
```
example
```
{
    "num":"192577",
}
```

### Response
```
{"title":string, "region":string, "area":string "date":string, "content":string}
```
example
```
{"title":"2023/02/02 20:04:12 [서울경찰청]", "region":"서울특별시", "area":"마포구" "date":"2023-02-02 20:04:30", "content":"정승원 실종"}
```
