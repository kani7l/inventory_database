CREATE TABLE Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL UNIQUE,
    address VARCHAR(255),
    contact_number VARCHAR(20)
);

CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    category_description TEXT
);

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    batch_number VARCHAR(50),
    product_description TEXT,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    quantity INT NOT NULL CHECK (quantity >= 0),
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    location VARCHAR(100),
    quantity INT NOT NULL CHECK (quantity >= 0),
    last_updated DATE NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Supplier_Product (
    supplier_id INT NOT NULL,
    product_id INT NOT NULL,
    PRIMARY KEY (supplier_id, product_id),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    contact_info VARCHAR(100),
    payment_method VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    status VARCHAR(50) NOT NULL DEFAULT 'Pending',
    shipping_address VARCHAR(255),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Order_Items (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity_ordered INT NOT NULL CHECK (quantity_ordered > 0),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role_id INT ,
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);
DELETE FROM Roles WHERE role_id in(1,2,3);

INSERT INTO Roles (role_name) VALUES
('Admin'),
('Manager'),
('Staff');

SELECT*FROM Roles;

INSERT INTO Users (username, password, role_id) VALUES
('alice_admin', 'securepass1', 7),
('bob_manager', 'securepass2', 8),
('carla_staff', 'securepass3', 9);

SELECT*FROM Users;


