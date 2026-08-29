CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  role TEXT NOT NULL
);

INSERT INTO users (id, name, role) VALUES
  (1, 'Ada', 'student'),
  (2, 'Grace', 'teacher');

SELECT id, name, role FROM users ORDER BY id;