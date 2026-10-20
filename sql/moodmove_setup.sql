-- MoodMove database: 5 tables + official workouts.
-- Run with:  /usr/local/mysql/bin/mysql -u root -p < sql/moodmove_setup.sql
-- WARNING: this DROPS the moodmove database first (it deletes all users).

DROP DATABASE IF EXISTS moodmove;
CREATE DATABASE moodmove;
USE moodmove;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  email VARCHAR(100) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE workout_types (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE workouts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  description TEXT,
  type_id INT NOT NULL,
  duration_min INT,
  intensity TINYINT NOT NULL,
  created_by INT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (type_id) REFERENCES workout_types(id),
  FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
  CHECK (intensity BETWEEN 1 AND 5)
);

CREATE TABLE swipes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  workout_id INT NOT NULL,
  action ENUM('like','skip') NOT NULL,
  swiped_on DATE NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (workout_id) REFERENCES workouts(id) ON DELETE CASCADE,
  UNIQUE (user_id, workout_id, swiped_on)
);

CREATE TABLE workout_logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  workout_id INT NULL,
  title VARCHAR(100) NOT NULL,
  type_id INT NOT NULL,
  log_date DATE NOT NULL,
  duration_min INT,
  intensity TINYINT NOT NULL,
  feeling TINYINT NOT NULL,
  notes TEXT,
  next_time TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (workout_id) REFERENCES workouts(id) ON DELETE SET NULL,
  FOREIGN KEY (type_id) REFERENCES workout_types(id),
  CHECK (intensity BETWEEN 1 AND 5),
  CHECK (feeling BETWEEN 1 AND 5)
);

INSERT INTO workout_types (name) VALUES
  ('Strength'), ('Running'), ('Hyrox'), ('Swimming'),
  ('Cycling'), ('HIIT'), ('Yoga'), ('Other');

INSERT INTO workouts (title, description, type_id, duration_min, intensity) VALUES
  ('Heavy Lower Body', 'Squats, deadlifts, lunges', 1, 60, 5),
  ('Easy Treadmill Run', 'Steady pace, conversational effort', 2, 35, 2),
  ('Hyrox Simulation', 'Sled pull, wall balls, rowing and runs', 3, 75, 5),
  ('Endurance Swim', 'Continuous freestyle with short rests', 4, 45, 3),
  ('Mobility Flow', 'Gentle yoga and stretching', 7, 30, 1);
