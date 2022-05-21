CREATE TABLE users (id SERIAL PRIMARY KEY, username VARCHAR(60) UNIQUE, password VARCHAR(60), email VARCHAR(70) UNIQUE, phone_number BIGINT);
CREATE TABLE teams (id SERIAL PRIMARY KEY, user_id INTEGER REFERENCES users(id), name VARCHAR(60), age VARCHAR(2), email VARCHAR(70), phone BIGINT);
CREATE TABLE players (id SERIAL PRIMARY KEY, user_id INTEGER REFERENCES users(id), teams_id INTEGER REFERENCES teams(id), week_1 VARCHAR(60), week_2 VARCHAR(60), week_3 VARCHAR(60), week_4 VARCHAR(60), week_5 VARCHAR(60), week_6 VARCHAR(60), week_7 VARCHAR(60), week_8 VARCHAR(60), week_9 VARCHAR(60), week_10 VARCHAR(60), progression INTEGER;

This is for both player_progress_tracker and player_progress_tracker_test databases.