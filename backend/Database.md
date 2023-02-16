# Database construction

1. MYSQL 서버 설치 및 환경 설정
- 참고 사이트 : https://itadventure.tistory.com/598

2. DATABASE 구축
```
# DB생성 (환경 설정 시 만들었으면 X)
create database emessage DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

# 테이블 생성
CREATE TABLE list (
    date        TINYTEXT,
    num         INT,
    division    TINYTEXT,
    step        TINYTEXT,
    title       TINYTEXT,
    PRIMARY KEY(num)
) ENGINE=MYISAM CHARSET=utf8;

CREATE TABLE contents (
    num         INT,
    title       TINYTEXT,
    region      TINYTEXT,
    area        TINYTEXT,
    date        TINYTEXT,
    content     LONGTEXT,
    PRIMARY KEY (num),
    FOREIGN KEY (num) REFERENCES list (num),
) ENGINE=MYISAM CHARSET=utf8;

# 데이터 삽입
(재난문자 사이트 참고 : https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/sfc/dis/disasterMsgList.jsp?menuSeq=679)
INSERT INTO table_name VALUES (data...);

# DB 및 TABLE 확인
SHOW databases;
SHOW tables;

# 테이블 구조 확인
DESC table_name;

# 데이터 확인
SELECT * FROM table_name;

```