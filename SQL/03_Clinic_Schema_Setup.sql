
DROP TABLE IF EXISTS clinic_sales;
DROP TABLE IF EXISTS expenses;
DROP TABLE IF EXISTS clinics;
DROP TABLE IF EXISTS customer;


CREATE TABLE clinics (
    cid          VARCHAR(50)  PRIMARY KEY,
    clinic_name  VARCHAR(100) NOT NULL,
    city         VARCHAR(100),
    state        VARCHAR(100),
    country      VARCHAR(100)
);


CREATE TABLE customer (
    uid     VARCHAR(50)  PRIMARY KEY,
    name    VARCHAR(100) NOT NULL,
    mobile  VARCHAR(20)
);



CREATE TABLE clinic_sales (
    oid           VARCHAR(50)    PRIMARY KEY,
    uid           VARCHAR(50)    NOT NULL,
    cid           VARCHAR(50)    NOT NULL,
    amount        DECIMAL(12, 2) NOT NULL,
    datetime      DATETIME       NOT NULL,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);



CREATE TABLE expenses (
    eid          VARCHAR(50)    PRIMARY KEY,
    cid          VARCHAR(50)    NOT NULL,
    description  VARCHAR(200),
    amount       DECIMAL(12, 2) NOT NULL,
    datetime     DATETIME       NOT NULL,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);






INSERT INTO clinics VALUES
('cnc-001', 'HealthFirst Clinic',  'Hyderabad', 'Telangana',      'India'),
('cnc-002', 'CureWell Clinic',     'Hyderabad', 'Telangana',      'India'),
('cnc-003', 'MediCare Clinic',     'Chennai',   'Tamil Nadu',     'India'),
('cnc-004', 'WellBeing Clinic',    'Chennai',   'Tamil Nadu',     'India'),
('cnc-005', 'CityHealth Clinic',   'Bangalore', 'Karnataka',      'India');

INSERT INTO customer VALUES
('cust-001', 'Anita Sharma',  '9800000001'),
('cust-002', 'Rahul Verma',   '9800000002'),
('cust-003', 'Priya Nair',    '9800000003'),
('cust-004', 'Arun Patel',    '9800000004'),
('cust-005', 'Deepa Menon',   '9800000005');

INSERT INTO clinic_sales VALUES
('ord-001', 'cust-001', 'cnc-001', 24999, '2021-09-10 10:00:00', 'online'),
('ord-002', 'cust-002', 'cnc-001', 12000, '2021-09-15 11:00:00', 'offline'),
('ord-003', 'cust-003', 'cnc-002', 18500, '2021-10-01 09:30:00', 'online'),
('ord-004', 'cust-001', 'cnc-002',  9000, '2021-10-12 14:00:00', 'referral'),
('ord-005', 'cust-004', 'cnc-003', 32000, '2021-11-05 08:00:00', 'offline'),
('ord-006', 'cust-005', 'cnc-003', 15000, '2021-11-18 16:00:00', 'online'),
('ord-007', 'cust-002', 'cnc-004', 22000, '2021-11-22 10:30:00', 'referral'),
('ord-008', 'cust-003', 'cnc-005', 11000, '2021-12-03 13:00:00', 'online'),
('ord-009', 'cust-004', 'cnc-001', 45000, '2021-10-25 09:00:00', 'offline'),
('ord-010', 'cust-005', 'cnc-003',  8000, '2021-09-28 15:00:00', 'online');

INSERT INTO expenses VALUES
('exp-001', 'cnc-001', 'Staff Salaries',        50000, '2021-09-30 00:00:00'),
('exp-002', 'cnc-001', 'First-aid Supplies',      557, '2021-10-05 07:00:00'),
('exp-003', 'cnc-002', 'Equipment Maintenance',  3000, '2021-10-10 08:00:00'),
('exp-004', 'cnc-003', 'Rent',                  20000, '2021-11-01 00:00:00'),
('exp-005', 'cnc-003', 'Utilities',              5000, '2021-11-15 00:00:00'),
('exp-006', 'cnc-004', 'Staff Salaries',        30000, '2021-11-30 00:00:00'),
('exp-007', 'cnc-005', 'Consumables',            2500, '2021-12-01 00:00:00'),
('exp-008', 'cnc-001', 'Marketing',              8000, '2021-10-20 00:00:00');
