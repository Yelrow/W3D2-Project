PRAGMA foreign_keys = ON;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL  
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY, 
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY, 
  user_id INTEGER NOT NULL,
  question_id INTEGER,
  
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY, 
  answer TEXT NOT NULL, 
  question_id INTEGER NOT NULL, 
  user_id INTEGER NOT NULL, 
  parents_id INTEGER,
  
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parents_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY, 
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Chris', 'Worley'),
  ('Kyle', 'McVeigh'),
  ('Ryan', 'O''Reardon'),
  ("Ned", "Ruggeri"), 
  ("Kush", "Patel"), 
  ("Earl", "Cat");
  
INSERT INTO
  questions(title, body, user_id)
VALUES
  ('Job Search', 'When will I move out of my parent''s basement?', (SELECT id FROM users WHERE fname = 'Kyle' AND lname = 'McVeigh')),
  ('Hair Cuts', 'What is my barber''s name?', (SELECT id FROM users WHERE fname = 'Chris' AND lname = 'Worley')),
  ('Science Teacher', 'How to be a more rigorous high school Science teacher?', (SELECT id FROM users WHERE fname = 'Ryan' AND lname = 'O''Reardon'));

INSERT INTO 
  replies(answer, question_id, user_id, parents_id)
VALUES 
  ('Hopefully soon', (SELECT id FROM questions WHERE title = 'Job Search'), (SELECT id FROM users WHERE fname = 'Chris' AND lname = 'Worley'), NULL),
  ('Lee',(SELECT id FROM questions WHERE title = 'Hair Cuts'), (SELECT id FROM users WHERE fname = 'Kyle' AND lname = 'McVeigh'), NULL),
  ('Not Soon enough',(SELECT id FROM questions WHERE title = 'Job Search'), (SELECT id FROM users WHERE fname = 'Kyle' AND lname = 'McVeigh'), (SELECT id from replies WHERE answer = 'Hopefully soon'));

  -- SOLUTION DATA ADDED BELOW 
  
INSERT INTO
question_follows (user_id, question_id)
VALUES
((SELECT id FROM users WHERE fname = "Ned" AND lname = "Ruggeri"),
(SELECT id FROM questions WHERE title = "Earl Question")),

((SELECT id FROM users WHERE fname = "Kush" AND lname = "Patel"),
(SELECT id FROM questions WHERE title = "Earl Question")
);

INSERT INTO
  questions (title, body, user_id)
SELECT
  "Ned Question", "NED NED NED", 1
FROM
  users
WHERE
  users.fname = "Ned" AND users.lname = "Ruggeri";

INSERT INTO
  questions (title, body, user_id)
SELECT
  "Kush Question", "KUSH KUSH KUSH", users.id
FROM
  users
WHERE
  users.fname = "Kush" AND users.lname = "Patel";

INSERT INTO
  questions (title, body, user_id)
SELECT
  "Earl Question", "MEOW MEOW MEOW", users.id
FROM
  users
WHERE
  users.fname = "Earl" AND users.lname = "Cat";
  
INSERT INTO
  question_likes (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = "Kush" AND lname = "Patel"),
  (SELECT id FROM questions WHERE title = "Earl Question"));

  
  
  
  
  
  
  
  
  
  
  
  