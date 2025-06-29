-- USERS
INSERT INTO my_database.users (id, username, email, password_hash, created_at) VALUES
  (UNHEX(REPLACE(UUID(), '-', '')), 'alice', 'alice@example.com', 'hashed_pwd_1', NOW() - INTERVAL 10 DAY),
  (UNHEX(REPLACE(UUID(), '-', '')), 'bob', 'bob@example.com', 'hashed_pwd_2', NOW() - INTERVAL 9 DAY),
  (UNHEX(REPLACE(UUID(), '-', '')), 'carol', 'carol@example.com', 'hashed_pwd_3', NOW() - INTERVAL 8 DAY);

-- POSTS
INSERT INTO my_database.posts (id, user_id, title, content, created_at)
SELECT 
  UNHEX(REPLACE(UUID(), '-', '')),
  u.id,
  CONCAT('Post by ', u.username),
  CONCAT('This is a post by ', u.username, '. Lorem ipsum dolor sit amet...'),
  NOW() - INTERVAL (ROW_NUMBER() OVER ()) DAY
FROM my_database.users u
LIMIT 3;

-- COMMENTS
INSERT INTO my_database.comments (id, post_id, user_id, comment, created_at)
SELECT
  UNHEX(REPLACE(UUID(), '-', '')),
  p.id,
  u.id,
  CONCAT('Nice post, ', p.title, '!'),
  NOW() - INTERVAL (ROW_NUMBER() OVER ()) HOUR
FROM my_database.posts p
JOIN my_database.users u ON p.user_id != u.id
LIMIT 5;


-- Table1

INSERT INTO my_database.table1 (id, column1) VALUES (1, 'hallo'), (2, 'bye');

-- Table2

INSERT INTO my_database.table2 (id, column1, column2) VALUES (1, 'hallo', 'biem1'), (2, 'bye', 'bomb2');
