CREATE DATABASE IF NOT EXISTS sai_restaurant;
USE sai_restaurant;

CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  email VARCHAR(120),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE menu_items (
  item_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  category VARCHAR(50) NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL,
  image VARCHAR(255),
  available BOOLEAN DEFAULT TRUE
);

CREATE TABLE reservations (
  reservation_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  reservation_date DATE NOT NULL,
  reservation_time TIME NOT NULL,
  guests INT NOT NULL,
  status ENUM('pending','confirmed','cancelled') DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT,
  total_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
  order_status ENUM('pending','confirmed','preparing','completed','cancelled') DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
  order_item_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  item_id INT NOT NULL,
  quantity INT NOT NULL DEFAULT 1,
  price DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (item_id) REFERENCES menu_items(item_id)
);

INSERT INTO menu_items (name,category,description,price) VALUES
('Paneer Tikka','starters','Char-grilled cottage cheese, peppers & aromatic spices.',280),
('Chicken 65','starters','Crispy southern-style chicken with curry leaves.',320),
('Butter Chicken','mains','Silky tomato gravy, cream, butter & tandoori chicken.',390),
('Paneer Butter Masala','mains','Soft paneer in a rich makhani sauce.',340),
('Hyderabadi Chicken Biryani','biryani','Fragrant basmati rice, tender chicken and royal spices.',420),
('Mughlai Biryani','biryani','Fragrant basmati rice, tender chicken and royal spices and extra taste.',499),
('Mutton Dum Biryani','biryani','Slow-cooked mutton layered with aromatic basmati rice.',480),
('Gulab Jamun','desserts','Warm milk dumplings finished with saffron syrup.',160),
('Mango Lassi','drinks','Fresh Alphonso mango blended with chilled yoghurt.',140);
