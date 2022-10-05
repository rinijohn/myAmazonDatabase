CREATE TABLE SELLER(
    seller_id DECIMAL(10) PRIMARY KEY,
    seller_name VARCHAR(64) NOT NULL
);
INSERT INTO SELLER (seller_id, seller_name) VALUES (1, 'Seller_Rini_1');

CREATE TABLE AMAZON_CATEGORY(
    category_id DECIMAL(10) PRIMARY KEY,
    category_name VARCHAR(10) NOT NULL
);
INSERT INTO AMAZON_CATEGORY (category_id, category_name) VALUES (11, 'Computers');
INSERT INTO AMAZON_CATEGORY (category_id, category_name) VALUES (12, 'Electronics');
INSERT INTO AMAZON_CATEGORY (category_id, category_name) VALUES (13, 'Appliances');

CREATE TABLE AMAZON_PRODUCT(
    product_id DECIMAL(10) PRIMARY KEY,
    product_name VARCHAR(64) NOT NULL,
    product_description VARCHAR(64) NOT NULL,
    category_id DECIMAL(10),
    CONSTRAINT category_id_fk1 FOREIGN KEY (category_id) REFERENCES AMAZON_CATEGORY(category_id)
);

CREATE TABLE RECIEPT(
    reciept_id DECIMAL(10) PRIMARY KEY,
    product_id DECIMAL(10),
    seller_id DECIMAL(10),
    CONSTRAINT product_id_fk1 FOREIGN KEY (product_id) REFERENCES AMAZON_PRODUCT(product_id),
    CONSTRAINT seller_id_fk1 FOREIGN KEY (seller_id) REFERENCES SELLER(seller_id)
);

CREATE TABLE AMAZON_CUSTOMER(
    customer_id DECIMAL(10) PRIMARY KEY,
    customer_name VARCHAR(64) NOT NULL,
    customer_address VARCHAR(64) NOT NULL,
    customer_email VARCHAR(64) NOT NULL,
    customer_phone DECIMAL(64) NOT NULL,
    cutomer_last_name VARCHAR(64) NOT NULL
);

CREATE TABLE AMAZON_ORDER(
    order_id DECIMAL(10) PRIMARY KEY,
    customer_id DECIMAL(10),
    shipping_speed VARCHAR(64) NOT NULL,
    date_of_order DATE NOT NULL,
    quantity DECIMAL(10) NOT NULL,
    CONSTRAINT customer_id_fk1 FOREIGN KEY (customer_id) REFERENCES AMAZON_CUSTOMER(customer_id)
);

CREATE TABLE AMAZON_PACKAGE(
    package_id DECIMAL(10) PRIMARY KEY,
    tracking_id DECIMAL(10),
    order_id DECIMAL(10),
    customer_id DECIMAL(10),
    CONSTRAINT order_id_fk1 FOREIGN KEY (order_id) REFERENCES AMAZON_ORDER(order_id),
    CONSTRAINT customer_id_fk2 FOREIGN KEY (customer_id) REFERENCES AMAZON_CUSTOMER(customer_id),
);

CREATE TABLE SELLER_PRODUCT(
    product_id DECIMAL(10),
    seller_id DECIMAL(10),
    product_price DECIMAL(10,2) NOT NULL,
    product_units DECIMAL(10,2) NOT NULL,
    product_condition VARCHAR(64) NOT NULL,
    CONSTRAINT seller_id_fk2 FOREIGN KEY (seller_id) REFERENCES SELLER(seller_id),
    CONSTRAINT product_id_fk2 FOREIGN KEY (product_id) REFERENCES AMAZON_PRODUCT(product_id)
);

CREATE TABLE PRODUCT_ORDER(
    product_id DECIMAL(10),
    order_id DECIMAL(10),
    CONSTRAINT product_id_fk3 FOREIGN KEY (product_id) REFERENCES AMAZON_PRODUCT(product_id),
    CONSTRAINT order_id_fk2 FOREIGN KEY (order_id) REFERENCES AMAZON_ORDER(order_id)
);
create or replace PROCEDURE ADD_NEW_PRODUCT(
product_id_arg IN DECIMAL,
category_id_arg IN DECIMAL,
product_name_arg IN VARCHAR,
product_description_arg IN VARCHAR)
IS
BEGIN
INSERT INTO AMAZON_PRODUCT (product_id, category_id, product_name, product_description)
VALUES(product_id_arg, category_id_arg, product_name_arg, product_description_arg);
END;

BEGIN
ADD_NEW_PRODUCT(101, 12, 'Self-Driving Video Camera', 
    'Camera automatically follows a subject that is being recorded',
    253.64,1,'New');
END;
/
BEGIN
ADD_NEW_PRODUCT(102, 11, 'holographic Keyboard', 
    'Emits a 3D projection of the keyboard & recognises virtual key press',
    20.00,1,'New');
END;
/

select product_name, product_price, category_name from AMAZON_PRODUCT
inner join AMAZON_CATEGORY ON AMAZON_CATEGORY.category_id=AMAZON_PRODUCT.category_id
where AMAZON_PRODUCT.category_id = 11 or AMAZON_PRODUCT.category_id = 12 and AMAZON_PRODUCT.product_price < 30.00

create or replace PROCEDURE ADD_NEW_DELIVERY(
seller_id_arg IN DECIMAL,
product_id_arg IN DECIMAL,
product_price_arg IN DECIMAL,
product_units_arg IN DECIMAL,
product_condition_arg IN VARCHAR)
IS
BEGIN
INSERT INTO SELLER_PRODUCT (seller_id, product_id, product_price, product_units, product_condition)
VALUES(seller_id_arg, product_id_arg, product_price_arg, product_units_arg, product_condition_arg);
END;

BEGIN
ADD_NEW_DELIVERY(1, 101, 253.64, 4, 'New');
END;
/
BEGIN
ADD_NEW_DELIVERY(1, 102, 20.00, 4, 'New');
END;
/

SELECT seller.seller_name, amazon_product.product_name, seller_product.product_units
FROM SELLER
JOIN SELLER_PRODUCT ON seller_product.seller_id = seller.seller_id
JOIN AMAZON_PRODUCT ON amazon_product.product_id = seller_product.product_id
WHERE seller.seller_id = 1 AND seller_product.product_units <=11

create or replace PROCEDURE ADD_NEW_CUSTOMER(
customer_id_arg IN DECIMAL,
customer_name_arg IN VARCHAR,
cutomer_last_name_arg IN VARCHAR,
customer_address_arg IN VARCHAR,
customer_email_arg IN VARCHAR,
customer_phone_arg IN DECIMAL)
IS
BEGIN
INSERT INTO AMAZON_CUSTOMER (customer_id, customer_name, customer_last_name, customer_address, customer_email, customer_phone)
VALUES(customer_id_arg, customer_name_arg, cutomer_last_name_arg, customer_address_arg, customer_email_arg, customer_phone_arg);
END;

BEGIN
ADD_NEW_CUSTOMER(10, 'Rini', 'John', '13 Bollywood St Apt 2', 
    'riniabc@gmail.com',99990000);
END;
/
BEGIN
ADD_NEW_CUSTOMER(11, 'Smith', 'John', '29 Carnel St Apt 1', 
    'facilitatorabc@gmail.com',99991000);
END;
/

BEGIN
ADD_NEW_CUSTOMER(12, 'Mary', 'Allan', '9 Beaver St Apt 3', 
    'maryabc@gmail.com',99990100);
END;
/
BEGIN
ADD_NEW_CUSTOMER(13, 'Ravi', 'Kari', '96 Main St Apt 1', 
    'raviabc@gmail.com',99990010);
END;
/
BEGIN
ADD_NEW_CUSTOMER(14, 'Sam', 'Hoseay', '44 Chandler St Apt 5', 
    'samabc@gmail.com',99990001);
END;
/

select COUNT(customer_id) as last_name_count
from AMAZON_CUSTOMER
where customer_last_name IN ('John','Allan','Kari')

create or replace PROCEDURE ADD_NEW_PURCHASE(
order_id_arg IN DECIMAL,
product_id_arg IN DECIMAL,
customer_id_arg IN DECIMAL,
shipping_speed_arg IN VARCHAR,
date_of_order_arg IN DATE,
quantity_arg IN DECIMAL)
IS
BEGIN
INSERT INTO AMAZON_ORDER(order_id, customer_id, shipping_speed, date_of_order, quantity)
VALUES(order_id_arg, customer_id_arg, shipping_speed_arg, date_of_order_arg, quantity_arg);
INSERT INTO PRODUCT_ORDER(product_id, order_id)
VALUES(product_id_arg, order_id_arg);
END add_new_purchase;

BEGIN
ADD_NEW_PURCHASE(1000, 101, 10, 'one-day', CAST('19-APR-2022' AS DATE),1);
END;
/

BEGIN
ADD_NEW_PURCHASE(1001, 102, 11, 'two-day', CAST('16-MAR-2022' AS DATE),3);
END;
/

BEGIN
ADD_NEW_PURCHASE(1003, 102, 12, 'one-day', CAST('06-JAN-2022' AS DATE),2);
END;
/

BEGIN
ADD_NEW_PURCHASE(1004, 102, 13, 'super-saving-shipping', CAST('07-JAN-2022' AS DATE),1);
END;
/

BEGIN
ADD_NEW_PURCHASE(1005, 102, 14, 'standard-shipping', CAST('17-FEB-2022' AS DATE),1);
END;
/

SELECT AMAZON_CUSTOMER.customer_name, AMAZON_CUSTOMER.customer_address
FROM AMAZON CUSTOMER
WHERE AMAZON CUSTOMER.customer_id IN (
SELECT customer_id FROM AMAZON_ORDER WHERE amazon_order.order_id IN(
SELECT order_id FROM product_order WHERE product_id IN (
SELECT PRODUCT_ORDER.product_id
FROM PRODUCT_ORDER
JOIN AMAZON_ORDER ON product_order.order_id = amazon_order.order_id
GROUP BY PRODUCT_ORDER.product_id
HAVING COUNT (AMAZON_ORDER.customer_id) >= 3)));

create or replace PROCEDURE ADD_NEW_SHIPMENT(
package_id_arg IN DECIMAL,
tracking_id_arg IN DECIMAL,
order_id_arg IN DECIMAL,
customer_id_arg IN DECIMAL)
IS
BEGIN
INSERT INTO AMAZON_PACKAGE (package_id, tracking_id, order_id, customer_id)
VALUES(package_id_arg, tracking_id_arg, order_id_arg,  customer_id_arg);
END

BEGIN
ADD_NEW_SHIPMENT(1, 232450, 1000, 10);
END;
/

BEGIN
ADD_NEW_SHIPMENT(2, 121978, 1001, 11);
END;
/

SELECT customer_name, customer_address
FROM AMAZON CUSTOMER
WHERE amazon customer.customer_id IN (
SELECT customer_id
FROM AMAZON_ORDER
WHERE amazon_order.order_id NOT IN (
SELECT order_id FROM AMAZON PACKAGE)
AND amazon_order.date_of_order < CAST ('01-FEB-2022' AS DATE))