const puppeteer = require("puppeteer");
const cheerio = require("cheerio");

const db = require("../../database/db_connect");

const getNum = new Promise((resolve, reject) =>
  db.query(`SELECT MAX(num) FROM list`, (err, rows, fields) => {
    if (!err) {
      resolve(rows[0]["MAX(num)"]);
    } else {
      throw err;
    }
  })
);

const setData = (table, data) => {
  new Promise((resolve, reject) =>
    db.query(`INSERT INTO ${table} VALUES ?`, [[data]], (err, rows, fileds) => {
      if (err) {
        throw err;
      }
    })
  );
};

const contentCrawling = async (num) => {
  const browser = await puppeteer.launch({ headless: true });
  const page = await browser.newPage();

  await page.goto(
    `
  https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/sfc/dis/disasterMsgView.jsp?menuSeq=679&md101_sn=${num}
  `,
    { waitUntil: "networkidle0" }
  );

  const content = await page.content();
  const $ = await cheerio.load(content);

  let data = [];
  let area = $("#bbsDetail_0_cdate").text().split(/ /);

  if (area.length > 2) {
    data = [
      num,
      $("#smsTitle").text(),
      "행정안전부",
      $("#bbsDetail_0_cdate").text(),
      $("#bbsDetail_1_cdate").text(),
      $("#msg_cn").text(),
    ];
  } else {
    data = [
      num,
      $("#smsTitle").text(),
      area[0],
      area[1],
      $("#bbsDetail_1_cdate").text(),
      $("#msg_cn").text(),
    ];
  }

  console.log(data);
  await setData("contents", data);

  await browser.close();
};

const listCrawling = async () => {
  const browser = await puppeteer.launch({ headless: true });
  const page = await browser.newPage();

  await page.goto(
    "https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/sfc/dis/disasterMsgList.jsp?menuSeq=679"
  );

  let content = await page.content();
  let $ = await cheerio.load(content);

  let prev = await getNum;
  const recent = Number($("#disasterSms_tr_0_MD101_SN").text());

  let i = 0;
  while (++prev <= recent) {
    let num = Number($(`#disasterSms_tr_${i}_MD101_SN`).text());
    let data = [
      $(`#disasterSms_tr_${i}_REGIST_DT`).text(),
      num,
      $(`#disasterSms_tr_${i}_DSSTR_SE_NM`).text(),
      $(`#disasterSms_tr_${i}_EMRGNCY_STEP_NM`).text(),
      $(`#disasterSms_tr_${i}_MSG_CN`).text(),
    ];

    await setData("list", data);
    await contentCrawling(num);

    if (++i > 9) {
      i = 0;
      break;

      // 다음 페이지 크롤링
      // await page.click("#apagenext", { waitUntil: "networkidle0" });
      // content = await page.content();
      // $ = await cheerio.load(content);
    }
  }
  await browser.close();
};

setInterval(listCrawling, 60000);
