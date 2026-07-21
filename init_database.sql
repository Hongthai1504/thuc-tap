-- create database
CREATE DATABASE IF NOT EXISTS internship_project;
USE internship_project;

-- 1. Users table
CREATE TABLE USERS (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    role ENUM('customer', 'admin') DEFAULT 'customer'
);

-- 2. Categories table
CREATE TABLE Categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 3. Products table
CREATE TABLE Products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    image_url VARCHAR(255),
    Foreign Key (category_id) REFERENCES Categories(id)
);

-- 4. Orders table
CREATE TABLE Orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    total_amount DECIMAL(10,2) NOT NULL,
    shipping_address TEXT NOT NULL,
    status ENUM('pending', 'shipping', 'completed') DEFAULT 'pending',
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Foreign Key (user_id) REFERENCES Users(id)
);

-- 5. Order_Details table
CREATE TABLE Order_Details (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    price_at_purchase DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, product_id),
    Foreign Key (order_id) REFERENCES Orders(id),
    Foreign Key (product_id) REFERENCES Products(id)
);;

