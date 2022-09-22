Create table customer (
    customerid int PRIMARY KEY,
    name text,
    age int,
    phonenumber int,
    gender text
);

Insert into customer values
     (01, 'Peter Schmeichel', 34, 158694532, 'Male'),
     (02, 'Gary  Nevile', 23, 132515155, 'Male'),
     (03, 'Denis Irwin', 32, 546987521, 'Male'),
     (04, 'Phil Neville', 21, 856321456, 'Male'),
     (05, 'Roy Keane', 27, 568794123, 'Male'),
     (06, 'Dwight Yorke', 27, 564235489, 'Male'),
     (07, 'David Beckham', 23, 895641236, 'Male'),
     (08, 'Nicky Butt', 34, 564789523, 'Male'),
     (09, 'Andy Cole', 27, 456879321, 'Male'),
     (10, 'Paul Scholes', 24, 254621456, 'Male'),
     (11, ' Ole Gunnar Solskjær', 25, 456987523, 'Male');

CREATE TABLE menu (
  menuid int PRIMARY KEY,
  customerid int,
  name TEXT,
  Price int,
  FOREIGN KEY (customerid) REFERENCES customer(customerid)
);

Insert into menu values
    (1, 01, 'Brisket with mashed potatoes', 100),
    (2, 01, 'Cheese with dressed lobster mac', 50),
    (3, 02, 'Shrimp and grits', 150),
    (4, 04, 'Grilled chicken with sweet summer vegetables', 50),
    (5, 06, 'Seed-Crusted Arctic Char', 100),
    (6, 08, 'Pulled pork sandwiches', 150),
    (7, 10, 'Abstract Vegan', 200),
    (8, 11, 'Chocolate Truffle Mousse', 50),
    (9, 02, 'NAVRATTAN CURRY', 100),
    (10, 03, 'Sweet tea', 100),
    (11, 07, 'Basil Gimlets', 50),
    (12, 06, 'Cold sodas', 150),
    (13, 01, 'Strawberry shortcake', 200),
    (14, 07, 'Snow cone cart', 100),
    (15, 08, 'Frozen slices of watermelon', 50);



CREATE TABLE orders (
  orderid INT PRIMARY KEY,
  customerid INT ,
  menuid INT,
  quantity INT, 
  FOREIGN KEY (customerid) REFERENCES customer(customerid),
  FOREIGN KEY (menuid) REFERENCES menu(menuid)
);

Insert into orders values
    (1, 01, 1, 2),
    (2, 01, 2, 1),
    (3, 02, 8, 3),
    (4, 04, 5, 1),
    (5, 06, 5, 2),
    (6, 08, 7, 3),
    (7, 10, 7, 4),
    (8, 11, 8, 1),
    (9, 02, 9, 2),
    (10, 03, 10, 2),
    (11, 07, 11, 1),
    (12, 06, 11, 3),
    (13, 03, 13, 4),
    (14, 05, 10, 2),
    (15, 09, 15, 1);


CREATE TABLE invoice(
    invoiceid INT primary key,
    customerid INT,
    orderid INT,
    invoicedate TEXT,
    FOREIGN KEY (customerid) REFERENCES customer(customerid),
    FOREIGN KEY (orderid) REFERENCES orders(orderid)
);

Insert into invoice values
    (1, 05, 16, '06/01/2022'),
    (2, 06, 17, '06/01/2022'),
    (3, 04, 18, '06/01/2022'),
    (4, 03, 19, '06/02/2022'),
    (5, 02, 20, '06/02/2022'),
    (6, 01, 1, '06/02/2022'),
    (7, 01, 2, '06/03/2022'),
    (8, 02, 3, '06/03/2022'),
    (9, 04, 4, '06/03/2022'),
    (10, 06, 5, '06/04/2022'),
    (11, 08, 6, '06/04/2022'),
    (12, 10, 7, '06/05/2022'),
    (13, 03, 13, '06/05/2022'),
    (14, 05, 14, '06/06/2022'),
    (15, 09, 15, '06/06/2022');


CREATE TABLE satisfaction_survey (
  survey_num int PRIMARY KEY,
  orderid int,
  satisfaction TEXT,
  FOREIGN KEY (orderid) REFERENCES orders(orderid)
);

Insert into satisfaction_survey values
    (1, 1, 'execellent'),
    (2, 2, 'execellent'),
    (3, 3, 'execellent'),
    (4, 5, 'good'),
    (5, 7, 'poor'),
    (6, 9, 'execellent'),
    (7, 11, 'execellent'),
    (8, 13, 'good'),
    (9, 15, 'good'),
    (10, 4, 'fair'),
    (11, 6, 'fair'),
    (12, 8, 'poor'),
    (13, 10, 'execellent'),
    (14, 12, 'good'),
    (15, 14, 'execellent');

Select 
    customer.customerid,
    customer.name,
    menu.name,
    satisfaction_survey.satisfaction
From customer
Join orders on customer.customerid = orders.customerid
JOIN menu ON menu.menuid = orders.menuid
JOIN satisfaction_survey ON satisfaction_survey.orderid = orders.orderid
WHERE satisfaction_survey.satisfaction = 'good';
