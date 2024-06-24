
DROP DATABASE IF EXISTS restaurant;
CREATE DATABASE restaurant;
USE restaurant;

DROP TABLE IF EXISTS restaurant CASCADE; 
CREATE TABLE restaurant (
   restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
   address VARCHAR(100) NOT NULL,
   phone  VARCHAR(12) NOT NULL,
   email  VARCHAR(30) NOT NULL,
   website VARCHAR(30) NOT NULL
);

INSERT INTO restaurant (address, phone, email, website) 
    VALUES (
    '12-23 3rd ave', 
    '222-333-4444', 
    'bestrestaurant@food.org', 
    'bestrestaurant.org'
);

DROP TABLE IF EXISTS customer CASCADE;
CREATE TABLE customer (
   customer_id INT AUTO_INCREMENT PRIMARY KEY,
   fname VARCHAR(50) NOT NULL,
   lname VARCHAR(50) NOT NULL,
   phone VARCHAR(12) NOT NULL,
   email VARCHAR(30) NOT NULL,
   details VARCHAR(500) NOT NULL
   
);
insert into customer(
fname, lname, phone, email, details) values
('Asuka', 'Inoshita', '111-222-3333', 'asukainoshita@gmail.com', 'allergic to peanuts');
insert into customer(
fname, lname, phone, email, details) values
('Johnny', 'Depp', '123-234-3456', 'johnnydepp@gmail.com', 'allergic to milk');
insert into customer(
fname, lname, phone, email, details) values
('Arnold', 'Schwarzenegger', '124-235-3457','arnold@gmail.com', 'allergic to shrimp');
insert into customer(
fname, lname, phone, email, details) values
('Emma', 'Watson', '125-236-3458', 'emma@gmail.com', 'allergic to soy');


DROP TABLE IF EXISTS online_platform CASCADE;
CREATE TABLE online_platform  (
  platform_id INT AUTO_INCREMENT PRIMARY KEY,
  platform_name VARCHAR(20) NOT NULL,
  service_type VARCHAR(20) NOT NULL
  
);
insert into online_platform(
platform_name, service_type) values
('UberEats', 'Delivery');
insert into online_platform(
platform_name, service_type) values
('DoorDash', 'Delivery');
insert into online_platform(
platform_name, service_type) values
('OpenTable', 'Reservation');
-- select *from online_platform;

DROP TABLE IF EXISTS customer_order CASCADE;
CREATE TABLE customer_order  (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  order_type VARCHAR(10) NOT NULL, -- direct delivery, customer pickup, table order, platform order
  customer_comments_menu VARCHAR(100) NOT NULL,
  customer_comments_delivery VARCHAR(100) NOT NULL,
  platform_order_id VARCHAR(10), -- Order number generated by platform
  platform_id INT, -- DoorDash, UBEREats, etc.
  customer_id INT NOT NULL
);
insert into customer_order(
order_type, customer_comments_menu, customer_comments_delivery, platform_order_id, platform_id, customer_id) values
('online', 'No onions', 'meet at door', 'dd-00001', 1, 0);
insert into customer_order(
order_type, customer_comments_menu, customer_comments_delivery, platform_order_id, platform_id, customer_id) values
('manual', 'No ice', 'meet at door', NULL, NULL, 1 ); -- manual order, platform info
insert into customer_order(
order_type, customer_comments_menu, customer_comments_delivery, platform_order_id, platform_id, customer_id) values
('online', 'add extra cheese', 'call when get to the gate', 'ue-00001', 0, 2);

SELECT * FROM customer_order;

DROP TABLE IF EXISTS menu_items CASCADE;
CREATE TABLE menu_items (
  menu_item_id INT AUTO_INCREMENT PRIMARY KEY,
  menu_item_name VARCHAR(30) NOT NULL,
  menu_item_quantity INT NOT NULL,
  menu_item_details VARCHAR(500) NOT NULL
  -- menu_id INT
);
insert into menu_items(
menu_item_name, menu_item_quantity, menu_item_details) values
('Avocado Toast', 30, 'Avocado toast with two eggs');
insert into menu_items(
menu_item_name, menu_item_quantity, menu_item_details) values
('Pasta Tomato Sauce', 50, 'Thin Pasta with homemade tomato sause');
insert into menu_items(
menu_item_name, menu_item_quantity, menu_item_details) values
('Grilled Chicken', 30, 'Organic Chicken breast grilled with butter sauce');
insert into menu_items(
menu_item_name, menu_item_quantity, menu_item_details) values
('Cobb Salad', 30, 'Organic Arugula, smoked backon, tomatoes, avocados, and onion');
insert into menu_items(
menu_item_name, menu_item_quantity, menu_item_details) values
('Special Breakfast', 30, 'Two eggs with backon, ham and green salad with toast');
insert into menu_items(
menu_item_name, menu_item_quantity, menu_item_details) values
('Grilled Chicken', 30, 'Organic Chicken breast grilled with butter sauce');

-- select * from menu_items;

DROP TABLE IF EXISTS items_info CASCADE; -- Helper table for online_order
CREATE TABLE items_info  (
    quantity INT, -- will come from the customer's or
    price_each FLOAT, -- comes from menu_item but no need foreign key
    
    order_id INT, -- direct delivery order from cusomer
    FOREIGN KEY (order_id) REFERENCES customer_order (order_id),
    menu_item_id INT,
    FOREIGN KEY (menu_item_id) REFERENCES menu_items (menu_item_id),
    platform_order_id varchar(8)
    -- FOREIGN KEY (platform_order_id) REFERENCES customer_order (platform_order_id)  -- probably not needed as already present on customer order record
    
);
insert into items_info(quantity,
price_each, order_id, menu_item_id, platform_order_id) values
(1, 10.00, 1, 1, 'dd-00001'); -- line item for order 0

select * from items_info;

DROP TABLE IF EXISTS customer_table CASCADE;
CREATE TABLE customer_table  (
  table_id INT AUTO_INCREMENT PRIMARY KEY,
  table_details VARCHAR(500) NOT NULL
);
insert into customer_table(
table_details) values
('reservation only');
insert into customer_table(
table_details) values
('baby chair available');
insert into customer_table(
table_details) values
('four people maximum');
insert into customer_table(
table_details) values
('two people maximum');
insert into customer_table(
table_details) values
('--');
insert into customer_table(
table_details) values
('--');
insert into customer_table(
table_details) values
('--');

select * from customer_table;

DROP TABLE IF EXISTS reservation CASCADE;
CREATE TABLE reservation  (
  reserv_id INT AUTO_INCREMENT PRIMARY KEY,
  reserv_date_time datetime NOT NULL,
  number_of_party INT NOT NULL,
  reservation_type VARCHAR(15) NOT NULL,
  customer_id  INT,
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
  table_id INT,
  FOREIGN KEY (table_id) REFERENCES customer_table(table_id)
);
insert into reservation(
reserv_date_time, number_of_party, reservation_type, customer_id, table_id) values
('2022-01-02 17:30:00', 2, 'online',1,1);
insert into reservation(
reserv_date_time, number_of_party, reservation_type, customer_id, table_id) values
('2022-01-02 18:30:00', 4, 'online',2,2);
insert into reservation(
reserv_date_time, number_of_party, reservation_type, customer_id, table_id) values
('2022-01-02 19:30:00', 2, 'phone',3,3);



-- DROP TABLE IF EXISTS deliverer CASCADE;
-- CREATE TABLE deliverer (
  -- delilverer_id INT AUTO_INCREMENT PRIMARY KEY,
  -- fname VARCHAR(30) NOT NULL,
  -- lname VARCHAR(30) NOT NULL,
  -- phone VARCHAR(30) NOT NULL,
  -- license VARCHAR(20) NOT NULL
-- );

DROP TABLE IF EXISTS pickup CASCADE;
CREATE TABLE pickup  (
  pickup_id INT AUTO_INCREMENT PRIMARY KEY,
  pickup_date_time datetime NOT NULL,
  pickup_type VARCHAR(30) NOT NULL, -- customer or uber/doordash deliverer
  order_id INT,
  FOREIGN KEY (order_id) REFERENCES customer_order(order_id),
  deliverer_id INT,
  -- FOREIGN KEY (deliverer_id) REFERENCES deliverer(deliverer_id)
  customer_id INT
);
insert into pickup(
pickup_date_time, pickup_type, customer_id, deliverer_id) values
('2022-01-05 11:30:00', 'customer', 1,1 );
insert into pickup(
pickup_date_time, pickup_type, customer_id, deliverer_id) values
('2022-01-05 12:30:00', 'uber', 2,2);
insert into pickup(
pickup_date_time, pickup_type, customer_id, deliverer_id) values
('2022-01-05 12:30:00', 'doordash', 3,3);

-- select * from pickup;


DROP TABLE IF EXISTS employee_role CASCADE;
CREATE TABLE employee_role (
  emp_role_id INT AUTO_INCREMENT PRIMARY KEY,
  emp_role_details VARCHAR(500) NOT NULL
);
insert employee_role(
emp_role_details) values
('server');
insert employee_role(
emp_role_details) values
('kitchen stuff');
insert employee_role(
emp_role_details) values
('manager');
insert employee_role(
emp_role_details) values
('owner');
insert employee_role(
emp_role_details) values
('deliverer');

-- select * from employee_role;


DROP TABLE IF EXISTS employee CASCADE;
CREATE TABLE employee (
  emp_id INT AUTO_INCREMENT PRIMARY KEY,
  emp_fname VARCHAR(50) NOT NULL,
  emp_lname VARCHAR(50) NOT NULL,
  emp_role_id INT,
  FOREIGN KEY (emp_role_id) REFERENCES employee_role(emp_role_id)
);
insert employee(
emp_fname, emp_lname, emp_role_id) values
('Chris', 'Evans', 5);
insert employee(
emp_fname, emp_lname, emp_role_id) values
('Tom', 'Cruise', 1);
insert employee(
emp_fname, emp_lname, emp_role_id) values
('Brad', 'Pitt', 2);
insert employee(
emp_fname, emp_lname, emp_role_id) values
('Morgan', 'Freeman', 3);
insert employee(
emp_fname, emp_lname, emp_role_id) values
('Tom', 'Hanks', 4);

-- select * from employee;

DROP TABLE IF EXISTS direct_delivery CASCADE;
CREATE TABLE direct_delivery  (
  delivery_id INT AUTO_INCREMENT PRIMARY KEY,
  delivery_details VARCHAR(500) NOT NULL,
  emp_id INT,
  FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
);
insert direct_delivery(
delivery_details, emp_id) values
('Call at the door', 5);
insert direct_delivery(
delivery_details, emp_id) values
('Meet at the door', 5);
insert direct_delivery(
delivery_details, emp_id) values
('Pay with two credit cards', 5);

-- select * from direct_delivery;

-- DROP TABLE IF EXISTS menu CASCADE;
-- CREATE TABLE menu (
--  menu_id INT AUTO_INCREMENT PRIMARY KEY,
--  qr_code BLOB
-- );

DROP TABLE IF EXISTS menu_ingredients_type CASCADE;
CREATE TABLE menu_ingredients_type (
  ingredients_type_id INT AUTO_INCREMENT PRIMARY KEY,
  indgredients_type_details VARCHAR(500) NOT NULL
); 
insert menu_ingredients_type(
indgredients_type_details) values
('Vege');
insert menu_ingredients_type(
indgredients_type_details) values
('Dairy');
insert menu_ingredients_type(
indgredients_type_details) values
('Meats');
insert menu_ingredients_type(
indgredients_type_details) values
('Condiments');
insert menu_ingredients_type(
indgredients_type_details) values
('Fruits');
insert menu_ingredients_type(
indgredients_type_details) values
('Nuts');
insert menu_ingredients_type(
indgredients_type_details) values
('Flour Products');
insert menu_ingredients_type(
indgredients_type_details) values
('Grains');

-- select * from menu_ingredients_type;

DROP TABLE IF EXISTS menu_items_ingredients CASCADE;
CREATE TABLE menu_items_ingredients (
  ingredients_id INT AUTO_INCREMENT PRIMARY KEY,
  ingredients_name VARCHAR(50) NOT NULL,
  ingredients_quantity VARCHAR(50) NOT NULL,
  ingredients_details VARCHAR(500) NOT NULL,
  ingredients_type_id INT
  -- FOREIGN KEY (ingredients_type_id) REFERENCES menu_ingredients_type(ingredients_type_id)
);
insert menu_items_ingredients(
ingredients_name,ingredients_quantity,ingredients_details,ingredients_type_id) values
('Onion', '1/4', 'made in Ohio', 1);
insert menu_items_ingredients(
ingredients_name,ingredients_quantity,ingredients_details,ingredients_type_id) values
('Greek Yogult', '50g', 'imported', 2);
insert menu_items_ingredients(
ingredients_name,ingredients_quantity,ingredients_details,ingredients_type_id) values
('Lamb Chop', '200g', 'made in Australia', 3);
insert menu_items_ingredients(
ingredients_name,ingredients_quantity,ingredients_details,ingredients_type_id) values
('Red Vineger', '10g', 'Organic', 4);
insert menu_items_ingredients(
ingredients_name,ingredients_quantity,ingredients_details,ingredients_type_id) values
('Fuji Apple', '50g', 'made in Ohio', 5);
insert menu_items_ingredients(
ingredients_name,ingredients_quantity,ingredients_details,ingredients_type_id) values
('Almond', '10g', 'made in Ohio', 6);
insert menu_items_ingredients(
ingredients_name,ingredients_quantity,ingredients_details,ingredients_type_id) values
('Thin Pasta', '120g', 'made in Palma', 7);
insert menu_items_ingredients(
ingredients_name,ingredients_quantity,ingredients_details,ingredients_type_id) values
('Rice', '200g', 'made in Japan', 8);

-- select * from menu_items_ingredients;

-- select * from employee;

-- describe customer;
-- DROP TABLE IF EXISTS menu_order CASCADE;
-- CREATE TABLE menu_order  (
  -- order_id INT AUTO_INCREMENT PRIMARY KEY,
  -- order_date_time VARCHAR(50) NOT NULL, -- data type??
  -- order_type VARCHAR(20) NOT NULL,
  -- menu_item_id INT,
  -- FOREIGN KEY (menu_item_id) REFERENCES menu_items(menu_item_id)
-- );

