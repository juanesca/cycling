import {createConnection} from 'mysql';

const MySqlConnection = createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    port: Number.parseInt(process.env.DB_PORT ?? '3306'),

});

MySqlConnection.connect((err) => {
    if (err) {
        console.error(err);
        return;
    } else {
        console.log('[DATABASE] Connected');
    }
})

export default MySqlConnection;