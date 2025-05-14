const mysql = require('mysql2')

require('dotenv').config()

const connection = mysql.createConnection({

    host: process.env.DBHOST,
    user: process.env.DBUSER,
    password: process.env.DBPASSWORD,
    database: process.env.DBNAME,
    port: process.env.DBPORT,

});

connection.connect((err) => {
  if (err) {
      console.log(err);
      return;
  }
  console.log('Connection established');
});

module.exports = connection;