CREATE TABLE my_database.table1 (
  id INT,
  column1 VARCHAR(255)
  PRIMARY KEY (id)
);

CREATE TABLE my_database.users (
    id BINARY(16) PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP
);

CREATE TABLE my_database.posts (
    id BINARY(16) PRIMARY KEY,
    user_id BINARY(16) NOT NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP
);

CREATE TABLE my_database.comments (
    id BINARY(16) PRIMARY KEY,
    post_id BINARY(16) NOT NULL,
    user_id BINARY(16) NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP
);
