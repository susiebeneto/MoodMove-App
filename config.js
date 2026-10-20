// Settings for MoodMove. No passwords are stored in this file, so it is safe for GitHub.
//
// On your computer: settings come from db-config.js (not uploaded to GitHub).
// On the hosting service: settings come from environment variables (DB_HOST, DB_USER, ...).

let local = {};
try
{
  local = require("./db-config");   // optional, only exists on your computer
}
catch(e) {}

const db = local.database || {
  host: "localhost", user: "root", password: "", database: "moodmove", port: 3306
};

// Hosted databases (like Aiven) require an encrypted connection
let ssl;
if(process.env.DB_CA)
  ssl = {ca: process.env.DB_CA};
else if(process.env.DB_SSL === "true")
  ssl = {rejectUnauthorized: false};

module.exports = {
  database: {
    host: process.env.DB_HOST || db.host,
    user: process.env.DB_USER || db.user,
    password: process.env.DB_PASSWORD !== undefined ? process.env.DB_PASSWORD : db.password,
    database: process.env.DB_NAME || db.database,
    port: Number(process.env.DB_PORT) || db.port,
    ssl: ssl,
    waitForConnections: true,
    connectionLimit: 5,
    enableKeepAlive: true
  },
  sessionSecret: process.env.SESSION_SECRET || local.sessionSecret || "dev-only-secret",
  port: Number(process.env.PORT) || 3000
};
