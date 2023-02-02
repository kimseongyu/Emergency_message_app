const db = require('mysql');
const conn = db.createConnection({
    host:'localhost',
    port: 3306,
    user: 'user',
    password: '1234',
    // database: 'message'
})
module.exports = conn;