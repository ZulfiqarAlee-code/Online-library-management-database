CREATE DATABASE online_library_management;
USE online_library_management;
  
DROP DATABASE online_library_managemenet;
  
-- Categories first
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL
);

-- Authors
CREATE TABLE authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(50) NOT NULL
);

-- Users
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL,
    phone_num VARCHAR(15),
    membership_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Books
CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    book_name VARCHAR(100) NOT NULL,
    author_id INT,
    category_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Borrow Records
CREATE TABLE borrow_records (
    borrow_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    book_id INT,
    borrow_date DATE,
    due_date DATE,
    return_date DATE,
    fine_amount DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);


INSERT INTO categories (category_name) VALUES
('Computer Science'),
('Fiction'),
('Mathematics'),
('History');


INSERT INTO authors (author_name) VALUES
('James Clear'),
('J.K. Rowling'),
('Thomas H. Cormen'),
('Yuval Noah Harari');

INSERT INTO users (user_name, email, password, phone_num) VALUES
('Ali Khan', 'ali@gmail.com', '1234', '03001234567'),
('Sara Ahmed', 'sara@gmail.com', '1234', '03111234567'),
('Usman Tariq', 'usman@gmail.com', '1234', '03221234567');

INSERT INTO books (book_name, author_id, category_id) VALUES
('Atomic Habits', 1, 1),
('Harry Potter', 2, 2),
('Introduction to Algorithms', 3, 1),
('Sapiens', 4, 4);

INSERT INTO borrow_records (user_id, book_id, borrow_date, due_date, return_date, fine_amount) VALUES
(1, 1, '2026-03-01', '2026-03-10', '2026-03-09', 0),
(2, 2, '2026-03-05', '2026-03-15', NULL, 0),
(3, 3, '2026-03-07', '2026-03-17', '2026-03-20', 50);




SELECT u.user_name, b.book_name, br.borrow_date
FROM borrow_records br
INNER JOIN users u ON br.user_id = u.user_id
INNER JOIN books b ON br.book_id = b.book_id;

-- Show books with their authors

SELECT b.book_name, a.author_name
FROM books b
INNER JOIN authors a ON b.author_id = a.author_id;


-- how books with categories
SELECT b.book_name, c.category_name
FROM books b
INNER JOIN categories c ON b.category_id = c.category_id;


 --  Show full details (User + Book + Author + Category)
 
SELECT 
    u.user_name,
    b.book_name,
    a.author_name,
    c.category_name,
    br.borrow_date,
    br.return_date
FROM borrow_records br
JOIN users u ON br.user_id = u.user_id
JOIN books b ON br.book_id = b.book_id
JOIN authors a ON b.author_id = a.author_id
JOIN categories c ON b.category_id = c.category_id;




SELECT u.user_name, b.book_name, br.due_date, br.return_date
FROM borrow_records br
JOIN users u ON br.user_id = u.user_id
JOIN books b ON br.book_id = b.book_id
WHERE br.return_date > br.due_date;

