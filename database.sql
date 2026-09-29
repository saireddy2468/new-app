-- 1. Dining Tables Table Create Cheyyadam
CREATE TABLE IF NOT EXISTS dining_tables (
    table_id INT PRIMARY KEY AUTO_INCREMENT,
    table_number INT NOT NULL UNIQUE,
    seating_capacity INT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

-- 2. Customers Table Create Cheyyadam
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15) NOT NULL
);

-- 3. Reservations Table Create Cheyyadam
CREATE TABLE IF NOT EXISTS reservations (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    table_id INT NOT NULL,
    customer_id INT NOT NULL,
    reservation_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    status ENUM('Confirmed', 'Cancelled', 'Completed') DEFAULT 'Confirmed',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (table_id) REFERENCES dining_tables(table_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 4. Testing Kosam Konni Sample Tables Add Cheyyadam
INSERT IGNORE INTO dining_tables (table_number, seating_capacity) VALUES
(1, 2), (2, 2), (3, 4), (4, 4), (5, 6);

-- 5. Real-Time Booking Stored Procedure (Double Booking Apadaniki)
DELIMITER //

CREATE PROCEDURE BookTableRealTime(
    IN p_table_id INT,
    IN p_customer_id INT,
    IN p_res_date DATE,
    IN p_start TIME,
    IN p_end TIME,
    OUT p_result VARCHAR(50)
)
BEGIN
    DECLARE overlap_count INT;

    -- Transaction Start (Locking kosam)
    START TRANSACTION;

    -- Table ni lock cheyyadam (vere vallu same time ki try cheyyakunda)
    SELECT table_id INTO @locked_table 
    FROM dining_tables 
    WHERE table_id = p_table_id 
    FOR UPDATE;

    -- Time overlap avuthundemo check cheyyadam
    SELECT COUNT(*) INTO overlap_count 
    FROM reservations 
    WHERE table_id = p_table_id 
      AND reservation_date = p_res_date
      AND status = 'Confirmed'
      AND (start_time < p_end AND end_time > p_start);

    -- Overlap lekapothe booking confirm cheyyadam
    IF overlap_count = 0 THEN
        INSERT INTO reservations (table_id, customer_id, reservation_date, start_time, end_time) 
        VALUES (p_table_id, p_customer_id, p_res_date, p_start, p_end);
        
        SET p_result = 'Success';
        COMMIT;
    ELSE
        -- Overlap ayithe booking cancel cheyyadam
        SET p_result = 'Table already booked for this time';
        ROLLBACK;
    END IF;

END //

DELIMITER ;
