CREATE DATABASE IF NOT EXISTS db_course_week01;
USE db_course_week01;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INT PRIMARY KEY,
  name VARCHAR(32) NOT NULL,
  role VARCHAR(32) NOT NULL
);

INSERT INTO users (id, name, role) VALUES
  (1, 'Ada', 'student'),
  (2, 'Grace', 'teacher');

SELECT id, name, role FROM users ORDER BY id;