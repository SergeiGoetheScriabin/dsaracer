const express = require('express');
const { Pool } = require('pg');
const app = express();
const port = 3000;

// Database configuration
const pool = new Pool({
    user: 'your_username',
    host: 'localhost',
    database: 'typing_racer',
    password: 'your_password',
    port: 5432
});

// Create database and table if they don't exist
async function setupDatabase() {
    const client = await pool.connect();
    try {
        // Create database if it doesn't exist
        await client.query(`CREATE DATABASE IF NOT EXISTS typing_racer`);
        
        // Connect to the database
        await client.query(`CONNECT TO typing_racer`);
        
        // Create table if it doesn't exist
        await client.query(`
            CREATE TABLE IF NOT EXISTS scores (
                id SERIAL PRIMARY KEY,
                wpm INT,
                accuracy FLOAT,
                time FLOAT,
                created_at TIMESTAMP DEFAULT NOW()
            )
        `);
    } finally {
        client.release();
    }
}

setupDatabase().catch(console.error);

// API endpoints
app.use(express.json());

// Submit score
app.post('/api/score', async (req, res) => {
    const { wpm, accuracy, time } = req.body;
    
    try {
        await pool.query(
            'INSERT INTO scores (wpm, accuracy, time) VALUES ($1, $2, $3)',
            [Math.round(wpm), accuracy, time]
        );
        res.status(201).send('Score submitted');
    } catch (err) {
        console.error(err);
        res.status(500).send('Error submitting score');
    }
});

// Get leaderboard
app.get('/api/leaderboard', async (req, res) => {
    try {
        const { rows } = await pool.query(`
            SELECT wpm, accuracy, time
            FROM scores
            ORDER BY wpm DESC, accuracy DESC
            LIMIT 10
        `);
        
        res.json(rows);
    } catch (err) {
        console.error(err);
        res.status(500).send('Error fetching leaderboard');
    }
});

// Start server
app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});
