
DROP TABLE IF EXISTS booking_commercials;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS users;


CREATE TABLE users (
    user_id          VARCHAR(50)  PRIMARY KEY,
    name             VARCHAR(100) NOT NULL,
    phone_number     VARCHAR(20),
    mail_id          VARCHAR(100),
    billing_address  TEXT
);


CREATE TABLE items (
    item_id    VARCHAR(50)    PRIMARY KEY,
    item_name  VARCHAR(100)   NOT NULL,
    item_rate  DECIMAL(10, 2) NOT NULL
);





CREATE TABLE bookings (
    booking_id   VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME    NOT NULL,
    room_no      VARCHAR(50) NOT NULL,
    user_id      VARCHAR(50) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);



CREATE TABLE booking_commercials (
    id            VARCHAR(50)    PRIMARY KEY,
    booking_id    VARCHAR(50)    NOT NULL,
    bill_id       VARCHAR(50)    NOT NULL,
    bill_date     DATETIME       NOT NULL,
    item_id       VARCHAR(50)    NOT NULL,
    item_quantity  DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id)    REFERENCES items(item_id)
);




INSERT INTO users VALUES
('usr-001', 'John Doe',   '9700000001', 'john.doe@example.com',   '10, MG Road, Mumbai'),
('usr-002', 'Jane Smith', '9700000002', 'jane.smith@example.com', '22, Park Street, Kolkata'),
('usr-003', 'Raj Kumar',  '9700000003', 'raj.kumar@example.com',  '5, Anna Nagar, Chennai');

INSERT INTO items VALUES
('itm-a9e8-q8fu',  'Tawa Paratha', 18.00),
('itm-a07vh-aer8', 'Mix Veg',      89.00),
('itm-w978-23u4',  'Dal Tadka',    75.00),
('itm-b123-xyz1',  'Butter Naan',  35.00),
('itm-c456-xyz2',  'Lassi',        50.00);

INSERT INTO bookings VALUES
('bk-001', '2021-09-10 14:00:00', 'rm-101', 'usr-001'),
('bk-002', '2021-10-05 11:30:00', 'rm-202', 'usr-001'),
('bk-003', '2021-11-12 09:00:00', 'rm-303', 'usr-002'),
('bk-004', '2021-11-20 16:45:00', 'rm-101', 'usr-003'),
('bk-005', '2021-10-18 08:15:00', 'rm-204', 'usr-002');

INSERT INTO booking_commercials VALUES
('bc-001', 'bk-001', 'bl-001', '2021-09-10 14:30:00', 'itm-a9e8-q8fu',  3),
('bc-002', 'bk-001', 'bl-001', '2021-09-10 14:30:00', 'itm-a07vh-aer8', 1),
('bc-003', 'bk-002', 'bl-002', '2021-10-05 12:00:00', 'itm-w978-23u4',  2),
('bc-004', 'bk-002', 'bl-002', '2021-10-05 12:00:00', 'itm-b123-xyz1',  4),
('bc-005', 'bk-002', 'bl-002', '2021-10-05 12:00:00', 'itm-c456-xyz2',  2),
('bc-006', 'bk-003', 'bl-003', '2021-11-12 10:00:00', 'itm-a9e8-q8fu',  5),
('bc-007', 'bk-003', 'bl-003', '2021-11-12 10:00:00', 'itm-a07vh-aer8', 2),
('bc-008', 'bk-003', 'bl-003', '2021-11-12 10:00:00', 'itm-b123-xyz1',  3),
('bc-009', 'bk-004', 'bl-004', '2021-11-20 17:00:00', 'itm-w978-23u4',  1),
('bc-010', 'bk-004', 'bl-004', '2021-11-20 17:00:00', 'itm-c456-xyz2',  3),
('bc-011', 'bk-005', 'bl-005', '2021-10-18 09:00:00', 'itm-a07vh-aer8', 2),
('bc-012', 'bk-005', 'bl-005', '2021-10-18 09:00:00', 'itm-b123-xyz1',  1);
