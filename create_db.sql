-- Create database
CREATE DATABASE typing_racer;

-- Connect to the database
\c typing_racer;

-- Create table
CREATE TABLE scores (
    id SERIAL PRIMARY KEY,
    wpm INT,
    accuracy FLOAT,
    time FLOAT,
    created_at TIMESTAMP DEFAULT NOW()
);
