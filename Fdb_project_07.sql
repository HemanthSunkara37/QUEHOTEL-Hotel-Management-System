CREATE TABLE HotelFacilities (
    hid NUMBER(20, 0) PRIMARY KEY,
    hname VARCHAR2(40) NOT NULL,
    hstate VARCHAR2(40),
    hcity VARCHAR2(40),
    hcountry VARCHAR2(40),
    hzipcode VARCHAR2(10),
    hotel_rating NUMBER(2, 0),
    hotel_capacity NUMBER(10, 0),
    rooms_per_facility NUMBER(10, 0),
    htype VARCHAR2(20),
    CONSTRAINT ht1 CHECK (htype IN ('Resort', 'Lodging Facility') AND hotel_rating BETWEEN 1 AND 10)
);

CREATE TABLE Rooms (
    room_id VARCHAR2(20) PRIMARY KEY,
    room_no NUMBER(10,0),
    room_status VARCHAR2(40) CHECK(room_status in ('Maintenance', 'Occupied','Available')),
    room_type VARCHAR2(40),
    bed_type VARCHAR2(40),
    bed_count NUMBER(10,0),
    internet NUMBER(1,0) not null CHECK(internet in (0,1)),
    heating_type VARCHAR2(30),
    cooling_type VARCHAR2(30),
    square_footage NUMBER(30,5),
    hot_id NUMBER(20,0),
    FOREIGN KEY (hot_id) REFERENCES HotelFacilities(hid),
    CONSTRAINT ht2 CHECK (heating_type IN ('Electric', 'Solar', 'Geothermal') AND cooling_type IN ('Window', 'Split', 'Central'))
);

CREATE TABLE Amenities (
    aid VARCHAR2(10) PRIMARY KEY,
    steam_room NUMBER(10,0) CHECK( steam_room  IN (0,1)),
    child_day_care NUMBER(10,0)CHECK( child_day_care  IN (0,1)),
    swimming_pool NUMBER(10,0)CHECK( swimming_pool  IN (0,1)),
    gym NUMBER(10,0)CHECK( gym  IN (0,1)),
    medical_facility NUMBER(10,0),
    hot_id NUMBER(20,0),
    FOREIGN KEY (hot_id) REFERENCES HotelFacilities(hid),
    CONSTRAINT ht3 CHECK (medical_facility IN (0,1))
);


CREATE TABLE Guests (
    guest_id VARCHAR2(10) PRIMARY KEY,
    check_in_date DATE NOT NULL,
    mail_id VARCHAR2(100),
    identity_proof VARCHAR2(30) NOT NULL,
    first_name VARCHAR2(50)NOT NULL,
    last_name VARCHAR2(50),
    checkout_date DATE,
    contact VARCHAR2(15),
    reward_points NUMBER(10)
);


CREATE TABLE Employees (
    emp_id VARCHAR2(7) PRIMARY KEY,
    sid VARCHAR2(7),
    dependents VARCHAR2(200),
    salary NUMBER(10, 2),
    status VARCHAR2(255) CHECK (status IN ('Active', 'Inactive')),
    role VARCHAR2(255)not null,
    date_of_birth DATE,
    start_date DATE,
    education VARCHAR2(255),
    criminal_record VARCHAR2(255),
    certification VARCHAR2(255),
    hours NUMBER(2,0),
    first_name VARCHAR2(255),
    last_name VARCHAR2(255),
    hot_id NUMBER(20,0),
    FOREIGN KEY (hot_id) REFERENCES HotelFacilities(hid),
    FOREIGN KEY (sid) REFERENCES Employees(emp_id),
    CONSTRAINT ht4 CHECK (hours >5  AND hours <41)
);


CREATE TABLE Maintenance (
    mid VARCHAR2(10) PRIMARY KEY,
    mdate DATE,
    mtype VARCHAR2(255),
    mexpense NUMBER(10, 2) NOT NULL,
    mstatus VARCHAR2(255),
    hot_id NUMBER(20,0),
    FOREIGN KEY (hot_id) REFERENCES HotelFacilities(hid),
    CONSTRAINT ht5 CHECK (mstatus in ('Complete','InProgress','Pending'))
);

CREATE TABLE Upgrades (
    upid VARCHAR2(10) PRIMARY KEY,
    upgrade_name VARCHAR2(255),
    udate DATE,
    upgrade_cost NUMBER(10, 2) NOT NULL,
    ustatus VARCHAR2(200) CHECK(ustatus IN ('Complete','InProgress','Pending')),
    hot_id NUMBER(20,0),
    CONSTRAINT fk1 FOREIGN KEY (hot_id) REFERENCES HotelFacilities(hid)
);

CREATE TABLE Reservations (
    reservation_id VARCHAR2(10) PRIMARY KEY,
    fare NUMBER(10, 2) NOT NULL,
    reserved_date DATE,
    room_count NUMBER(2,0) NOT NULL
    CONSTRAINT ht6 CHECK (room_count <= 50)
);

CREATE TABLE HealthInsurance (
    bid VARCHAR2(10) PRIMARY KEY,
    premium_cost DECIMAL(10, 2) NOT NULL,
    insurance_amount DECIMAL(10, 2),
    eid VARCHAR2(7),
    FOREIGN KEY (eid) REFERENCES Employees(emp_id)
);


CREATE TABLE Restaurants (
    id VARCHAR2(10) PRIMARY KEY,
    restaurant_name VARCHAR(255) NOT NULL,
    cuisine VARCHAR(255),
    cuisine_price DECIMAL(10, 2),
    CONSTRAINT ht7 CHECK (cuisine_price < 1000),
    CONSTRAINT uq UNIQUE (restaurant_name,cuisine)
);


CREATE TABLE Eats (
    id varchar2(10),
    guest_id varchar2(10),
    FOREIGN KEY (id) REFERENCES Restaurants(id),
    FOREIGN KEY (guest_id) REFERENCES Guests(guest_id),
    PRIMARY KEY (id, guest_id)
);



CREATE TABLE Books (
    reservation_id varchar2(10),
    room_id varchar2(20),
    guest_id varchar2(10),
    FOREIGN KEY (reservation_id) REFERENCES Reservations(reservation_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id),
    FOREIGN KEY (guest_id) REFERENCES Guests(guest_id),
    PRIMARY KEY (reservation_id, room_id, guest_id)
);


CREATE TABLE Assists (
    emp_id varchar2(7),
    guest_id varchar2(10),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id),
    FOREIGN KEY (guest_id) REFERENCES Guests(guest_id),
    PRIMARY KEY (emp_id, guest_id)
);








INSERT INTO HotelFacilities (hid, hname, hstate, hcity, hcountry, hzipcode, hotel_rating, hotel_capacity, rooms_per_facility, htype)
VALUES (117, 'Vacation Resort', 'California', 'Los Angeles', 'USA', '90001', 9, 300, 50, 'Resort');
INSERT INTO HotelFacilities (hid, hname, hstate, hcity, hcountry, hzipcode, hotel_rating, hotel_capacity, rooms_per_facility, htype)
VALUES (118, 'Legendary Resort', 'Texas', 'Austin', 'USA', '90701', 8, 200, 20, 'Resort');
INSERT INTO HotelFacilities (hid, hname, hstate, hcity, hcountry, hzipcode, hotel_rating, hotel_capacity, rooms_per_facility, htype)
VALUES (119, 'Beach Resort', 'Florida', 'Orlando', 'USA', '80121', 10, 350, 25, 'Resort');
INSERT INTO HotelFacilities (hid, hname, hstate, hcity, hcountry, hzipcode, hotel_rating, hotel_capacity, rooms_per_facility, htype)
VALUES (121, 'Riverbridge Hotel', 'New Jersey', 'Sun City', 'USA', '52121', 7, 325, 30, 'Lodging Facility');
INSERT INTO HotelFacilities (hid, hname, hstate, hcity, hcountry, hzipcode, hotel_rating, hotel_capacity, rooms_per_facility, htype)
VALUES (122, 'Lakeview Hotel', 'Cordoba', 'Torrecampo', 'Argentina', '52721', 8, 200, 20, 'Lodging Facility');
INSERT INTO HotelFacilities (hid, hname, hstate, hcity, hcountry, hzipcode, hotel_rating, hotel_capacity, rooms_per_facility, htype)
VALUES (124, 'Beach Inn', 'Tasmania', 'Hobart', 'Australia', '16587', 9, 400, 60, 'Resort');
INSERT INTO HotelFacilities (hid, hname, hstate, hcity, hcountry, hzipcode, hotel_rating, hotel_capacity, rooms_per_facility, htype)
VALUES (127, 'Red Triangle Resort','Bayangol','Ulaanbaatar', 'Mongolia', '52181', 9, 100, 25, 'Lodging Facility');
INSERT INTO HotelFacilities (hid, hname, hstate, hcity, hcountry, hzipcode, hotel_rating, hotel_capacity, rooms_per_facility, htype)
VALUES (129, 'Wild Safari Resort','Orange Free State','Bloemfontein', 'South Africa', '47896', 10, 300, 50, 'Resort');
INSERT INTO HotelFacilities (hid, hname, hstate, hcity, hcountry, hzipcode, hotel_rating, hotel_capacity, rooms_per_facility, htype)
VALUES (137, 'Spanish Heritage Resort','Vizcaya provincia','Bilbao', 'Spain', '17874', 7, 200, 30, 'Resort');
INSERT INTO HotelFacilities (hid, hname, hstate, hcity, hcountry, hzipcode, hotel_rating, hotel_capacity, rooms_per_facility, htype)
VALUES (147, 'Vintage Düsseldorf','North Rhine-Westphalia','Düsseldorf', 'Germany', '41898', 6, 250, 40, 'Lodging Facility');
INSERT INTO HotelFacilities (hid, hname, hstate, hcity, hcountry, hzipcode, hotel_rating, hotel_capacity, rooms_per_facility, htype)
VALUES (149, 'Unicorn Rainbow Resort','North Carolina','New Bern', 'USA', '75231', 9, 200, 45, 'Resort');
INSERT INTO HotelFacilities (hid, hname, hstate, hcity, hcountry, hzipcode, hotel_rating, hotel_capacity, rooms_per_facility, htype)
VALUES (152, 'Golden Hill Resort','Texas','Dallas', 'USA', '75052', 10, 500, 70, 'Resort');
INSERT INTO HotelFacilities (hid, hname, hstate, hcity, hcountry, hzipcode, hotel_rating, hotel_capacity, rooms_per_facility, htype)
VALUES (157, 'The Grand Canyon','Arizona','Flagstaff', 'USA', '75088', 10, 500, 70, 'Resort');





INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro101', 101, 'Available', 'Standard', 'Queen', 1, 1, 'Electric', 'Central', 300, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro111', 111, 'Occupied','Deluxe', 'King', 2, 1, 'Solar', 'Window', 400, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro113', 113, 'Maintenance', 'Suite', 'Twin', 2, 0, 'Geothermal', 'Central', 500, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro201', 201, 'Occupied', 'Standard', 'King', 1, 1, 'Electric', 'Split', 300, 118);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro204', 204, 'Available', 'Suite', 'Twin', 2, 1, 'Solar', 'Window', 500, 119);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro304', 304, 'Maintenance', 'Standard', 'King', 2, 1, 'Geothermal', 'Split', 450, 119);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro316', 316, 'Occupied', 'Deluxe', 'Twin XL', 1, 0, 'Solar', 'Central', 320, 121);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro416', 416, 'Occupied', 'Deluxe', 'Twin XL', 1, 0, 'Solar', 'Central', 320, 121);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro426', 426, 'Available', 'Deluxe', 'Twin', 2, 1, 'Geothermal', 'Window', 300, 122);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro512', 512, 'Occupied', 'Standard', 'Twin', 1, 0, 'Electric', 'Split', 300, 124);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro510', 510, 'Available', 'Suite', 'Twin', 4, 1, 'Electric', 'Central', 700, 127);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro619', 619, 'Occupied', 'Standard', 'King', 2, 1, 'Solar', 'Central', 500, 129);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro611', 611, 'Available', 'Standard', 'Queen', 1, 1, 'Solar', 'Split', 400, 137);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro700', 700, 'Available', 'Standard', 'Queen', 4, 1, 'Geothermal', 'Window', 600, 137);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro701', 701, 'Occupied', 'Standard', 'Queen', 4, 1, 'Geothermal', 'Window', 600, 137);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro704', 704, 'Available', 'Deluxe', 'King', 4, 1, 'Geothermal', 'Window', 600, 147);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro812', 812, 'Available', 'Standard', 'Twin', 2, 0, 'Solar', 'Split', 400, 147);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro814', 814, 'Occupied', 'Standard', 'King', 1, 0, 'Solar', 'Split', 400, 149);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro914', 914, 'Occupied', 'Deluxe', 'Twin', 2, 1, 'Electric', 'Central', 500, 152);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro917', 917, 'Available', 'Standard', 'Twin', 1, 0, 'Solar', 'Window', 400, 157);



INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id)
VALUES ('E101', NULL, 'John, Wilson', 50000.00, 'Active', 'Manager', TO_DATE('1980-05-15', 'YYYY-MM-DD'), TO_DATE('2020-01-01', 'YYYY-MM-DD'), 'Bachelors Degree', 'None', 'Management Certification', 40, 'Alice', 'Smith', 117);
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id)
VALUES ('E102', 'E101', 'Henry, Amanda', 30000.00, 'Active', 'Staff', TO_DATE('1987-08-15', 'YYYY-MM-DD'), TO_DATE('2015-07-01', 'YYYY-MM-DD'), 'Bachelors Degree', 'None', 'Management Certification', 30, 'Jane', 'Parker', 117);
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id)
VALUES ('E103', NULL, 'Scott', 45000.00, 'Active', 'Staff', TO_DATE('1984-08-22', 'YYYY-MM-DD'), TO_DATE('2021-04-15', 'YYYY-MM-DD'), 'Masters Degree', 'Child Abuse', 'Leadership Certification', 35, 'Bob', 'Johansson', 119);
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id)
VALUES ('E104', NULL, 'Alex, Ethan, Eli', 60000.00, 'Active', 'Supervisor', TO_DATE('1992-11-10', 'YYYY-MM-DD'), TO_DATE('2019-07-01', 'YYYY-MM-DD'), 'Bachelors Degree', 'None', 'None', 38, 'Ross', 'DeSand', 118);
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id)
VALUES ('E105', NULL, 'Olivia', 55000.00, 'Active', 'Analyst', TO_DATE('1988-04-30', 'YYYY-MM-DD'), TO_DATE('2018-02-10', 'YYYY-MM-DD'), 'Bachelors Degree', 'None', 'Analytical Certification', 30, 'Chris', 'Renaux', 121);
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id)
VALUES ('E106', NULL, 'Grace, Sophie', 48000.00, 'Inactive', 'Clerk', TO_DATE('1995-09-18', 'YYYY-MM-DD'), TO_DATE('2022-05-05', 'YYYY-MM-DD'), 'Associate Degree', 'Domestic Violence', 'None', 25, 'Sophia', 'Clark', 122);
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id)
VALUES ('E107', NULL, 'Oscar,Amelia', 58000.00, 'Active', 'Supervisor', TO_DATE('1983-12-12', 'YYYY-MM-DD'), TO_DATE('2017-11-20', 'YYYY-MM-DD'), 'Masters Degree', 'None', 'Leadership Certification', 40, 'Bandlie', 'Ayanda', 124);
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id)
VALUES ('E108', 'E107', 'Kholwa,Kamau', 48000.00, 'Active', 'Staff', TO_DATE('1983-12-12', 'YYYY-MM-DD'), TO_DATE('2017-11-20', 'YYYY-MM-DD'), 'Masters Degree', 'Gun Crime', 'None', 34, 'Francois', 'Bavuma', 124);
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id)
VALUES ('E109', NULL, 'Baker', 42000.00, 'Active', 'Staff', TO_DATE('1990-07-25', 'YYYY-MM-DD'), TO_DATE('2016-06-10', 'YYYY-MM-DD'), 'Bachelors Degree', 'None', 'None', 28, 'Warren', 'Nottingam', 127);
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id)
VALUES ('E110', NULL, 'Zoe, Zach', 49000.00, 'Inactive', 'Staff', TO_DATE('1993-03-14', 'YYYY-MM-DD'), TO_DATE('2023-01-15', 'YYYY-MM-DD'), 'Associate Degree', 'Theft', 'None', 32, 'Harry', 'Jones', 129);
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id)
VALUES ('E111', NULL, 'Diego, Isabella', 43000.00, 'Active', 'Analyst', TO_DATE('1981-09-08', 'YYYY-MM-DD'), TO_DATE('2019-12-01', 'YYYY-MM-DD'), 'Masters Degree', 'None', 'Analytical Certification', 36, 'Manuel', 'Alvarez', 137);
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id)
VALUES ('E112', NULL, NULL, 56000.00, 'Active', 'Staff', TO_DATE('1986-11-20', 'YYYY-MM-DD'), TO_DATE('2015-08-05', 'YYYY-MM-DD'), 'Bachelors Degree', 'Gang Offender', 'Leadership Certification', 34, 'Adolf', 'Günter', 147);
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id)
VALUES ('E113', NULL, 'Atlan,Batu', 46000.00, 'Active', 'Staff', TO_DATE('1986-11-20', 'YYYY-MM-DD'), TO_DATE('2015-08-05', 'YYYY-MM-DD'), 'Bachelors Degree', 'None', 'Management Certification', 34, 'Arban', 'Temullen', 149);
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id)
VALUES ('E114', NULL, 'Eun,Park,Hun', 54000.00, 'Active', 'Analyst', TO_DATE('1994-06-28', 'YYYY-MM-DD'), TO_DATE('2016-12-10', 'YYYY-MM-DD'), 'Bachelors Degree', 'None', 'Analytical Certification', 40, 'Beom', 'Seok', 152);
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id)
VALUES ('E115', NULL, NULL, 51000.00, 'Active', 'Coordinator', TO_DATE('1989-04-12', 'YYYY-MM-DD'), TO_DATE('2020-05-20', 'YYYY-MM-DD'), 'Associate Degree', 'Property Crime', 'None', 15, 'Diachi', 'Yamamoto', 157);





INSERT INTO HealthInsurance (bid, premium_cost, insurance_amount, eid)
VALUES ('Bi101', 510.00, 100000.00, 'E101');
INSERT INTO HealthInsurance (bid, premium_cost, insurance_amount, eid)
VALUES ('Bi102', 605.00, 120000.00, 'E102');
INSERT INTO HealthInsurance (bid, premium_cost, insurance_amount, eid)
VALUES ('Bi103', 550.00, 110000.00, 'E103');
INSERT INTO HealthInsurance (bid, premium_cost, insurance_amount, eid)
VALUES ('Bi104', 510.00, 105000.00, 'E104');
INSERT INTO HealthInsurance (bid, premium_cost, insurance_amount, eid)
VALUES ('Bi105', 540.00, 125000.00, 'E105');
INSERT INTO HealthInsurance (bid, premium_cost, insurance_amount, eid)
VALUES ('Bi106', 540.00, 108000.00, 'E106');
INSERT INTO HealthInsurance (bid, premium_cost, insurance_amount, eid)
VALUES ('Bi107', 590.00, 115000.00, 'E107');
INSERT INTO HealthInsurance (bid, premium_cost, insurance_amount, eid)
VALUES ('Bi108', 540.00, 100000.00, 'E108');
INSERT INTO HealthInsurance (bid, premium_cost, insurance_amount, eid)
VALUES ('Bi109', 570.00, 118000.00, 'E109');
INSERT INTO HealthInsurance (bid, premium_cost, insurance_amount, eid)
VALUES ('Bi110', 520.00, 114000.00, 'E110');
INSERT INTO HealthInsurance (bid, premium_cost, insurance_amount, eid)
VALUES ('Bi111', 535.00, 109000.00, 'E111');
INSERT INTO HealthInsurance (bid, premium_cost, insurance_amount, eid)
VALUES ('Bi112', 620.00, 130000.00, 'E112');
INSERT INTO HealthInsurance (bid, premium_cost, insurance_amount, eid)
VALUES ('Bi113', 550.00, 114000.00, 'E113');
INSERT INTO HealthInsurance (bid, premium_cost, insurance_amount, eid)
VALUES ('Bi114', 580.00, 117000.00, 'E114');
INSERT INTO HealthInsurance (bid, premium_cost, insurance_amount, eid)
VALUES ('Bi115', 560.00, 113000.00, 'E115');


INSERT INTO Guests (guest_id, check_in_date, mail_id, identity_proof, first_name, last_name, checkout_date, contact, reward_points)
VALUES ('G101', TO_DATE('2024-02-25', 'YYYY-MM-DD'), 'John123@gmail.com', 'Passport', 'John', 'Doe', TO_DATE('2024-03-05', 'YYYY-MM-DD'), '+1-555-1234567', 50);
INSERT INTO Guests (guest_id, check_in_date, mail_id, identity_proof, first_name, last_name, checkout_date, contact, reward_points)
VALUES ('G102', TO_DATE('2024-02-21', 'YYYY-MM-DD'), 'alice@gmail.com', 'Driver License', 'Alice', 'Diaz', TO_DATE('2024-03-1', 'YYYY-MM-DD'), '+1-545-2375678', 30);
INSERT INTO Guests (guest_id, check_in_date, mail_id, identity_proof, first_name, last_name, checkout_date, contact, reward_points)
VALUES ('G103', TO_DATE('2024-02-29', 'YYYY-MM-DD'), 'isito@gmail.com', 'National ID', 'Isito', 'Oheme', TO_DATE('2024-03-08', 'YYYY-MM-DD'), '+1-455-3457789', 40);
INSERT INTO Guests (guest_id, check_in_date, mail_id, identity_proof, first_name, last_name, checkout_date, contact, reward_points)
VALUES ('G104', TO_DATE('2024-02-28', 'YYYY-MM-DD'), 'Steve@hotmail.com', 'Passport', 'Steve', 'Rogers', TO_DATE('2024-03-12', 'YYYY-MM-DD'), '+1-940-4567890', 65);
INSERT INTO Guests (guest_id, check_in_date, mail_id, identity_proof, first_name, last_name, checkout_date, contact, reward_points)
VALUES ('G105', TO_DATE('2024-02-29', 'YYYY-MM-DD'), 'lief@gmail.com', 'Driver License', 'Lief', 'Ragnarsson', TO_DATE('2024-03-06', 'YYYY-MM-DD'), '+47 12 34 56 89', 60);
INSERT INTO Guests (guest_id, check_in_date, mail_id, identity_proof, first_name, last_name, checkout_date, contact, reward_points)
VALUES ('G106', TO_DATE('2024-02-27', 'YYYY-MM-DD'), 'hong@gmail.com', 'Passport', 'Hong', 'Fei', TO_DATE('2024-03-04', 'YYYY-MM-DD'), '+86 139 1099', 20);
INSERT INTO Guests (guest_id, check_in_date, mail_id, identity_proof, first_name, last_name, checkout_date, contact, reward_points)
VALUES ('G107', TO_DATE('2024-02-26', 'YYYY-MM-DD'), 'bastest@gmail.com', 'Passport', 'Bastest', 'Cleo', TO_DATE('2024-03-01', 'YYYY-MM-DD'), '+20 125 874 658', 20);
INSERT INTO Guests (guest_id, check_in_date, mail_id, identity_proof, first_name, last_name, checkout_date, contact, reward_points)
VALUES ('G108', TO_DATE('2024-03-03', 'YYYY-MM-DD'), 'adalbert@gmail.com', 'Driver License', 'Adalbert', 'Hugo', TO_DATE('2024-03-20', 'YYYY-MM-DD'), '+49 69 1234 56', 35);
INSERT INTO Guests (guest_id, check_in_date, mail_id, identity_proof, first_name, last_name, checkout_date, contact, reward_points)
VALUES ('G109', TO_DATE('2024-03-01', 'YYYY-MM-DD'), 'akernel@gmail.com', 'Driver License', 'Alexander', 'Kernel', TO_DATE('2024-03-5', 'YYYY-MM-DD'), '(02) 9876 5432', 45);
INSERT INTO Guests (guest_id, check_in_date, mail_id, identity_proof, first_name, last_name, checkout_date, contact, reward_points)
VALUES ('G110', TO_DATE('2024-03-04', 'YYYY-MM-DD'), 'ebima@gmail.com', 'Passport', 'Eka', 'Bima', TO_DATE('2024-03-9', 'YYYY-MM-DD'), '+62-812-3456-78', 35);
INSERT INTO Guests (guest_id, check_in_date, mail_id, identity_proof, first_name, last_name, checkout_date, contact, reward_points)
VALUES ('G111', TO_DATE('2024-03-05', 'YYYY-MM-DD'), 'prasputin@gmail.com', 'Passport', 'Piotr', 'Rasputin', TO_DATE('2024-03-4', 'YYYY-MM-DD'), '+7 125 879 545', 55);



INSERT INTO Assists (emp_id, guest_id)
VALUES ('E101', 'G101');
INSERT INTO Assists (emp_id, guest_id)
VALUES ('E102', 'G101');
INSERT INTO Assists (emp_id, guest_id)
VALUES ('E102', 'G103');
INSERT INTO Assists (emp_id, guest_id)
VALUES ('E103', 'G104');
INSERT INTO Assists (emp_id, guest_id)
VALUES ('E103', 'G105');
INSERT INTO Assists (emp_id, guest_id)
VALUES ('E104', 'G105');
INSERT INTO Assists (emp_id, guest_id)
VALUES ('E105', 'G106');
INSERT INTO Assists (emp_id, guest_id)
VALUES ('E106', 'G106');
INSERT INTO Assists (emp_id, guest_id)
VALUES ('E106', 'G107');
INSERT INTO Assists (emp_id, guest_id)
VALUES ('E107', 'G108');
INSERT INTO Assists (emp_id, guest_id)
VALUES ('E108', 'G108');
INSERT INTO Assists (emp_id, guest_id)
VALUES ('E108', 'G109');
INSERT INTO Assists (emp_id, guest_id)
VALUES ('E109', 'G110');
INSERT INTO Assists (emp_id, guest_id)
VALUES ('E110', 'G110');
INSERT INTO Assists (emp_id, guest_id)
VALUES ('E111', 'G111');
INSERT INTO Assists (emp_id, guest_id)
VALUES ('E112', 'G104');
INSERT INTO Assists (emp_id, guest_id)
VALUES ('E113', 'G107');
INSERT INTO Assists (emp_id, guest_id)
VALUES ('E107', 'G102');


INSERT INTO Upgrades (upid, upgrade_name, udate, upgrade_cost, ustatus, hot_id) 
VALUES ('U001', 'Room Renovation', TO_DATE('2024-02-25', 'YYYY-MM-DD'), 2000.00, 'Complete', 117);
INSERT INTO Upgrades (upid, upgrade_name, udate, upgrade_cost, ustatus, hot_id) 
VALUES ('U000', 'Pool Expansion', TO_DATE('2024-02-2', 'YYYY-MM-DD'), 5000.00, 'Complete', 118);
INSERT INTO Upgrades (upid, upgrade_name, udate, upgrade_cost, ustatus, hot_id) 
VALUES ('U002', 'Reception Upgrade', TO_DATE('2024-03-29', 'YYYY-MM-DD'), 1000.00, 'Pending', 119);
INSERT INTO Upgrades (upid, upgrade_name, udate, upgrade_cost, ustatus, hot_id) 
VALUES ('U003', 'Lobby Redesign', TO_DATE('2024-02-26', 'YYYY-MM-DD'), 2000.00, 'InProgress', 121);
INSERT INTO Upgrades (upid, upgrade_name, udate, upgrade_cost, ustatus, hot_id) 
VALUES ('U004', 'Technology Innovation', TO_DATE('2024-03-26', 'YYYY-MM-DD'), 2000.00, 'Pending', 124);
INSERT INTO Upgrades (upid, upgrade_name, udate, upgrade_cost, ustatus, hot_id) 
VALUES ('U005', 'Gym Upgrade', TO_DATE('2024-03-29', 'YYYY-MM-DD'), 1500.00, 'Pending', 122);
INSERT INTO Upgrades (upid, upgrade_name, udate, upgrade_cost, ustatus, hot_id) 
VALUES ('U006', 'Medical Facility Upgrade', TO_DATE('2024-04-2', 'YYYY-MM-DD'), 5500.00, 'Pending', 127);
INSERT INTO Upgrades (upid, upgrade_name, udate, upgrade_cost, ustatus, hot_id) 
VALUES ('U007', 'Conference Room Remodeling', TO_DATE('2024-01-22', 'YYYY-MM-DD'), 1500.00, 'Complete', 129);
INSERT INTO Upgrades (upid, upgrade_name, udate, upgrade_cost, ustatus, hot_id) 
VALUES ('U008', 'Garden Innovation', TO_DATE('2024-05-29', 'YYYY-MM-DD'), 1900.00, 'Pending', 137);
INSERT INTO Upgrades (upid, upgrade_name, udate, upgrade_cost, ustatus, hot_id) 
VALUES ('U009', 'Park Upgrade', TO_DATE('2024-04-15', 'YYYY-MM-DD'), 2700.00, 'Pending', 147);
INSERT INTO Upgrades (upid, upgrade_name, udate, upgrade_cost, ustatus, hot_id) 
VALUES ('U010', 'Security Upgrades', TO_DATE('2024-02-07', 'YYYY-MM-DD'), 4700.00, 'Complete', 152);
INSERT INTO Upgrades (upid, upgrade_name, udate, upgrade_cost, ustatus, hot_id) 
VALUES ('U011', 'Guest Room Upgrades', TO_DATE('2024-02-08', 'YYYY-MM-DD'), 1700.00, 'Complete', 157);




INSERT INTO Books (reservation_id, room_id, guest_id)
VALUES ('R101', 'Ro111', 'G101');
INSERT INTO Books (reservation_id, room_id, guest_id)
VALUES ('R102', 'Ro101', 'G102');
INSERT INTO Books (reservation_id, room_id, guest_id)
VALUES ('R102', 'Ro111', 'G102');
INSERT INTO Books (reservation_id, room_id, guest_id)
VALUES ('R103', 'Ro113', 'G103');
INSERT INTO Books (reservation_id, room_id, guest_id)
VALUES ('R104', 'Ro201', 'G105');
INSERT INTO Books (reservation_id, room_id, guest_id)
VALUES ('R105', 'Ro204', 'G105');
INSERT INTO Books (reservation_id, room_id, guest_id)
VALUES ('R107', 'Ro316', 'G107');
INSERT INTO Books (reservation_id, room_id, guest_id)
VALUES ('R108', 'Ro426', 'G108');
INSERT INTO Books (reservation_id, room_id, guest_id)
VALUES ('R109', 'Ro510', 'G108');
INSERT INTO Books (reservation_id, room_id, guest_id)
VALUES ('R111', 'Ro611', 'G110');
INSERT INTO Books (reservation_id, room_id, guest_id)
VALUES ('R102', 'Ro619', 'G111');
INSERT INTO Books (reservation_id, room_id, guest_id)
VALUES ('R112', 'Ro914', 'G110');



INSERT INTO Eats (id, guest_id)
VALUES ('Re101', 'G101');
INSERT INTO Eats (id, guest_id)
VALUES ('Re101', 'G102');
INSERT INTO Eats (id, guest_id)
VALUES ('Re102', 'G103');
INSERT INTO Eats (id, guest_id)
VALUES ('Re104', 'G105');
INSERT INTO Eats (id, guest_id)
VALUES ('Re103', 'G105');
INSERT INTO Eats (id, guest_id)
VALUES ('Re106', 'G107');
INSERT INTO Eats (id, guest_id)
VALUES ('Re108', 'G108');
INSERT INTO Eats (id, guest_id)
VALUES ('Re109', 'G108');
INSERT INTO Eats (id, guest_id)
VALUES ('Re109', 'G109');
INSERT INTO Eats (id, guest_id)
VALUES ('Re110', 'G111');
INSERT INTO Eats (id, guest_id)
VALUES ('Re111', 'G110');
INSERT INTO Eats (id, guest_id)
VALUES ('Re111', 'G101');
INSERT INTO Eats (id, guest_id)
VALUES ('Re113', 'G102');






INSERT INTO Amenities (aid, steam_room, child_day_care, swimming_pool, gym, medical_facility, hot_id)
VALUES ('A101', 1, 0, 1, 1, 1, 157);
INSERT INTO Amenities (aid, steam_room, child_day_care, swimming_pool, gym, medical_facility, hot_id)
VALUES ('A102', 0, 1, 1, 0, 1, 117);
INSERT INTO Amenities (aid, steam_room, child_day_care, swimming_pool, gym, medical_facility, hot_id)
VALUES ('A103', 0, 0, 0, 0, 1, 118);
INSERT INTO Amenities (aid, steam_room, child_day_care, swimming_pool, gym, medical_facility, hot_id)
VALUES ('A104', 1, 1, 0, 0, 0, 119);
INSERT INTO Amenities (aid, steam_room, child_day_care, swimming_pool, gym, medical_facility, hot_id)
VALUES ('A105', 1, 0, 1, 0, 1, 121);
INSERT INTO Amenities (aid, steam_room, child_day_care, swimming_pool, gym, medical_facility, hot_id)
VALUES ('A106', 1, 0, 1, 1, 1, 122);
INSERT INTO Amenities (aid, steam_room, child_day_care, swimming_pool, gym, medical_facility, hot_id)
VALUES ('A107', 1, 0, 1, 0, 0, 124);
INSERT INTO Amenities (aid, steam_room, child_day_care, swimming_pool, gym, medical_facility, hot_id)
VALUES ('A108', 0, 0, 1, 0, 1, 127);
INSERT INTO Amenities (aid, steam_room, child_day_care, swimming_pool, gym, medical_facility, hot_id)
VALUES ('A109', 1, 1, 1, 1, 1, 129);
INSERT INTO Amenities (aid, steam_room, child_day_care, swimming_pool, gym, medical_facility, hot_id)
VALUES ('A110', 1, 0, 0, 0, 1, 137);
INSERT INTO Amenities (aid, steam_room, child_day_care, swimming_pool, gym, medical_facility, hot_id)
VALUES ('A111', 0, 0, 0, 0, 1, 147);
INSERT INTO Amenities (aid, steam_room, child_day_care, swimming_pool, gym, medical_facility, hot_id)
VALUES ('A112', 1, 1, 1, 0, 1, 149);
INSERT INTO Amenities (aid, steam_room, child_day_care, swimming_pool, gym, medical_facility, hot_id)
VALUES ('A113', 0, 1, 1, 0, 1, 152);



INSERT INTO MAINTENANCE (mid, mdate, mtype, mexpense, mstatus, hot_id) 
VALUES ('M101', TO_DATE('2024-01-02', 'YYYY-MM-DD'), 'Emergency', '100', 'Complete', 127 );
INSERT INTO MAINTENANCE (mid, mdate, mtype, mexpense, mstatus, hot_id) 
VALUES ('M102', TO_DATE('2024-02-26', 'YYYY-MM-DD'), 'Routine', '101', 'InProgress', 117 );
INSERT INTO MAINTENANCE (mid, mdate, mtype, mexpense, mstatus, hot_id) 
VALUES ('M103', TO_DATE('2024-05-02', 'YYYY-MM-DD'), 'Pool', '102', 'Pending', 118 );
INSERT INTO MAINTENANCE (mid, mdate, mtype, mexpense, mstatus, hot_id) 
VALUES ('M104', TO_DATE('2024-02-24', 'YYYY-MM-DD'), 'room', '103', 'Complete', 119 );
INSERT INTO MAINTENANCE (mid, mdate, mtype, mexpense, mstatus, hot_id) 
VALUES ('M105', TO_DATE('2024-02-25', 'YYYY-MM-DD'), 'Conditionbased', '104', 'Complete', 121 );
INSERT INTO MAINTENANCE (mid, mdate, mtype, mexpense, mstatus, hot_id) 
VALUES ('M106', TO_DATE('2024-02-28', 'YYYY-MM-DD'), 'Garden', '105', 'Pending', 122 );
INSERT INTO MAINTENANCE (mid, mdate, mtype, mexpense, mstatus, hot_id) 
VALUES ('M107', TO_DATE('2024-02-26', 'YYYY-MM-DD'), 'Shutdown', '106', 'InProgress', 124 );
INSERT INTO MAINTENANCE (mid, mdate, mtype, mexpense, mstatus, hot_id) 
VALUES ('M108', TO_DATE('2024-03-04', 'YYYY-MM-DD'), 'Corrective', '107', 'Pending', 137 );
INSERT INTO MAINTENANCE (mid, mdate, mtype, mexpense, mstatus, hot_id) 
VALUES ('M109', TO_DATE('2024-02-15', 'YYYY-MM-DD'), 'Computer', '108', 'Complete', 137 );
INSERT INTO MAINTENANCE (mid, mdate, mtype, mexpense, mstatus, hot_id) 
VALUES ('M110', TO_DATE('2024-03-10', 'YYYY-MM-DD'), 'Compliance', '103', 'Pending', 149 );




INSERT INTO Reservations (reservation_id, fare, reserved_date, room_count)
VALUES ('R101', 250.00, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 3);
INSERT INTO Reservations (reservation_id, fare, reserved_date, room_count)
VALUES ('R102', 1000.00, TO_DATE('2024-02-14', 'YYYY-MM-DD'), 4);
INSERT INTO Reservations (reservation_id, fare, reserved_date, room_count)
VALUES ('R103', 280.00, TO_DATE('2023-11-22', 'YYYY-MM-DD'), 1);
INSERT INTO Reservations (reservation_id, fare, reserved_date, room_count)
VALUES ('R104', 890, TO_DATE('2024-01-29', 'YYYY-MM-DD'), 5);
INSERT INTO Reservations (reservation_id, fare, reserved_date, room_count)
VALUES ('R105', 950, TO_DATE('2024-01-14', 'YYYY-MM-DD'), 4);
INSERT INTO Reservations (reservation_id, fare, reserved_date, room_count)
VALUES ('R106', 1250, TO_DATE('2023-05-23', 'YYYY-MM-DD'), 5);
INSERT INTO Reservations (reservation_id, fare, reserved_date, room_count)
VALUES ('R107', 750, TO_DATE('2024-01-25', 'YYYY-MM-DD'), 3);
INSERT INTO Reservations (reservation_id, fare, reserved_date, room_count)
VALUES ('R108', 400, TO_DATE('2024-01-12', 'YYYY-MM-DD'), 2);
INSERT INTO Reservations (reservation_id, fare, reserved_date, room_count)
VALUES ('R109', 500, TO_DATE('2024-01-30', 'YYYY-MM-DD'), 1);
INSERT INTO Reservations (reservation_id, fare, reserved_date, room_count)
VALUES ('R110', 1500, TO_DATE('2023-03-08', 'YYYY-MM-DD'), 4);
INSERT INTO Reservations (reservation_id, fare, reserved_date, room_count)
VALUES ('R111', 340, TO_DATE('2024-01-01', 'YYYY-MM-DD'), 1);
INSERT INTO Reservations (reservation_id, fare, reserved_date, room_count)
VALUES ('R112', 290, TO_DATE('2024-01-06', 'YYYY-MM-DD'), 1);
INSERT INTO Reservations (reservation_id, fare, reserved_date, room_count)
VALUES ('R113', 900, TO_DATE('2023-02-28', 'YYYY-MM-DD'), 4);
INSERT INTO Reservations (reservation_id, fare, reserved_date, room_count)
VALUES ('R114', 600, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 2);
INSERT INTO Reservations (reservation_id, fare, reserved_date, room_count)
VALUES ('R115', 700, TO_DATE('2023-12-04', 'YYYY-MM-DD'), 4);


INSERT INTO Restaurants (id, restaurant_name, cuisine, cuisine_price)
VALUES ('Re101', 'Taste of Texas', 'Italian', 150.00);
INSERT INTO Restaurants (id, restaurant_name, cuisine, cuisine_price)
VALUES ('Re102', 'Fuzzys', 'American', 126.75);
INSERT INTO Restaurants (id, restaurant_name, cuisine, cuisine_price)
VALUES ('Re103', 'Realora', 'Mexican', 100.00);
INSERT INTO Restaurants (id, restaurant_name, cuisine, cuisine_price)
VALUES ('Re104', 'Lovefood', 'American', 250.00);
INSERT INTO Restaurants (id, restaurant_name, cuisine, cuisine_price)
VALUES ('Re105', 'Desiadda', 'Indian', 175.00);
INSERT INTO Restaurants (id, restaurant_name, cuisine, cuisine_price)
VALUES ('Re106', 'Malaipure', 'Persian', 280.20);
INSERT INTO Restaurants (id, restaurant_name, cuisine, cuisine_price)
VALUES ('Re107', 'Chaiwala', 'Indian', 50.00);
INSERT INTO Restaurants (id, restaurant_name, cuisine, cuisine_price)
VALUES ('Re108', 'Michiganwoodfires', 'American', 127.50);
INSERT INTO Restaurants (id, restaurant_name, cuisine, cuisine_price)
VALUES ('Re109', 'Hyderabadi', 'Indian', 150.00);
INSERT INTO Restaurants (id, restaurant_name, cuisine, cuisine_price)
VALUES ('Re110', 'shin woo', 'Chineese', 122.00);
INSERT INTO Restaurants (id, restaurant_name, cuisine, cuisine_price)
VALUES ('Re111', 'momolo', 'Korean', 85.00);
INSERT INTO Restaurants (id, restaurant_name, cuisine, cuisine_price)
VALUES ('Re112', 'NamastheDenton', 'Indian', 140.00);
INSERT INTO Restaurants (id, restaurant_name, cuisine, cuisine_price)
VALUES ('Re113', 'shushiworld', 'Japaneese', 79.99);
INSERT INTO Restaurants (id, restaurant_name, cuisine, cuisine_price)
VALUES ('Re114', 'Zindagibiriyani', 'Indian', 199.99);



INSERT INTO Amenities (aid, steam_room, child_day_care, swimming_pool, gym, medical_facility, hot_id)
VALUES ('A115', 0, 1, 0, 0, 1, 117);

INSERT INTO Amenities (aid, steam_room, child_day_care, swimming_pool, gym, medical_facility, hot_id)
VALUES ('A116', 1, 0, 0, 0, 1, 167);

INSERT INTO Amenities (aid, steam_room, child_day_care, swimming_pool, gym, medical_facility, hot_id)
VALUES ('A118', 1, 0, 0, 1, 1, 187);


INSERT INTO HotelFacilities (hid, hname, hstate, hcity, hcountry, hzipcode, hotel_rating, hotel_capacity, rooms_per_facility, htype)
VALUES (167, 'War Resort', 'California', 'Fresno', 'USA', '90007', 8, 300, 50, 'Resort');

INSERT INTO HotelFacilities (hid, hname, hstate, hcity, hcountry, hzipcode, hotel_rating, hotel_capacity, rooms_per_facility, htype)
VALUES (187, 'Vintage Resort', 'California', 'San Jose', 'USA', '90807', 8, 300, 40, 'Resort');


INSERT INTO Reservations (reservation_id, fare, reserved_date, room_count)
VALUES ('R119', 500, TO_DATE('2023-11-23', 'YYYY-MM-DD'), 1);
INSERT INTO Reservations (reservation_id, fare, reserved_date, room_count)
VALUES ('R120', 400, TO_DATE('2023-11-23', 'YYYY-MM-DD'), 1);
INSERT INTO Reservations (reservation_id, fare, reserved_date, room_count)
VALUES ('R121', 400, TO_DATE('2023-11-23', 'YYYY-MM-DD'), 2);


INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro918', 917, 'Available', 'Standard', 'Twin', 1, 0, 'Solar', 'Window', 400, 157);

INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro919', 920, 'Available', 'Standard', 'Twin', 1, 1, 'Electric', 'Window', 400, 157);

INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro929', 929, 'Available', 'Standard', 'Twin', 1, 1, 'Electric', 'Window', 400, 157);

INSERT INTO Books (reservation_id, room_id, guest_id)
VALUES ('R119', 'Ro918', 'G103');
INSERT INTO Books (reservation_id, room_id, guest_id)
VALUES ('R120', 'Ro919', 'G104');

INSERT INTO Books (reservation_id, room_id, guest_id)
VALUES ('R121', 'Ro929', 'G105');

UPDATE Reservations
SET reserved_date = TO_DATE('2023-11-23', 'YYYY-MM-DD')
WHERE reservation_id = 'R103';


INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro1917', 1917, 'Available', 'Standard', 'Twin', 1, 0, 'Solar', 'Window', 400, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro1918', 1918, 'Available', 'Standard', 'Twin', 1, 0, 'Solar', 'Window', 500, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro1919', 1919, 'Available', 'Standard', 'Twin XL', 0, 0, 'Solar', 'Window', 500, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro1920', 1920, 'Available', 'Standard', 'Twin XL', 0, 0, 'Solar', 'Window', 500, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro1921', 1921, 'Available', 'Standard', 'Twin XL', 0, 0, 'Solar', 'Window', 500, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro1922', 1922, 'Available', 'Standard', 'Twin XL', 0, 0, 'Solar', 'Window', 500, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro1923', 1923, 'Available', 'Standard', 'Twin XL', 0, 0, 'Solar', 'Window', 500, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro1924', 1925, 'Available', 'Standard', 'Twin XL', 0, 0, 'Solar', 'Window', 500, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro1925', 1925, 'Available', 'Standard', 'Twin XL', 0, 0, 'Solar', 'Window', 500, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro1926', 1926, 'Available', 'Standard', 'Twin XL', 0, 0, 'Solar', 'Window', 700, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro1927', 1927, 'Available', 'Standard', 'Twin XL', 0, 0, 'Solar', 'Window', 500, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro1928', 1928, 'Available', 'Standard', 'Twin XL', 0, 0, 'Solar', 'Window', 500, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro1929', 1929, 'Available', 'Standard', 'Twin XL', 0, 0, 'Solar', 'Window', 500, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro1930', 1930, 'Available', 'Standard', 'Twin XL', 0, 0, 'Solar', 'Split', 500, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro1931', 1931, 'Available', 'Standard', 'Twin XL', 0, 0, 'Solar', 'Split', 500, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro1932', 1932, 'Available', 'Standard', 'Twin XL', 0, 0, 'Solar', 'Split', 500, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro1933', 1933, 'Available', 'Standard', 'Twin XL', 0, 0, 'Solar', 'Split', 500, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro1934', 1934, 'Available', 'Standard', 'Twin XL', 0, 0, 'Solar', 'Split', 500, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro1935', 1935, 'Available', 'Standard', 'Twin XL', 0, 0, 'Solar', 'Split', 500, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro1936', 1936, 'Available', 'Standard', 'Twin XL', 0, 0, 'Electric', 'Split', 500, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro1937', 1937, 'Available', 'Standard', 'Twin XL', 0, 0, 'Solar', 'Split', 500, 117);
INSERT INTO Rooms (room_id, room_no, room_status, room_type, bed_type, bed_count, internet, heating_type, cooling_type, square_footage, hot_id)
VALUES ('Ro1938', 1938, 'Available', 'Standard', 'Twin XL', 0, 0, 'Solar', 'Split', 500, 117);










SELECT  COUNT(h.hid) AS hotels_without_pool
FROM HotelFacilities h
WHERE h.hstate = 'California' AND h.hid NOT IN (SELECT a.hot_id FROM Amenities a WHERE a.swimming_pool = 1) group by h.hstate;








ALTER TABLE Employees
ADD workdate DATE DEFAULT TO_DATE('2023-03-07', 'YYYY-MM-DD');











SELECT e.salary,e.emp_id 
FROM employees e 
WHERE e.hours > 5 AND e.WorkDate BETWEEN TO_DATE('2023-03-04', 'YYYY-MM-DD') AND TO_DATE('2023-03-10', 'YYYY-MM-DD');






UPDATE Employees e
SET e.salary = e.salary * 1.23
WHERE e.hours > 5 AND e.WorkDate BETWEEN TO_DATE('2023-03-04', 'YYYY-MM-DD') AND TO_DATE('2023-03-10', 'YYYY-MM-DD');











DELETE FROM Employees
WHERE education <> 'Graduate Degree'
  AND hot_id IN (
    SELECT hid
    FROM HotelFacilities
    WHERE hcountry <> 'United States'
  );








SELECT e.first_name || ' ' || e.last_name AS Employee_Name
FROM Employees e
WHERE e.hot_id IN( 
 SELECT h.hid
 FROM Hotelfacilities h
 WHERE h.hcity = 'Dallas') AND
 e.workdate = TO_DATE('2023-11-03', 'YYYY-MM-DD') AND
 e.hours = (
    SELECT MAX(em.hours)
    FROM Employees em
    WHERE em.workdate = TO_DATE('2023-11-03', 'YYYY-MM-DD')
      AND em.hot_id IN (SELECT hf.hid FROM HotelFacilities hf WHERE hf.hcity = 'Dallas')
  );



SELECT h.hid,h.hname,h.hcity, h.hstate,h.hcountry
FROM HotelFacilities h
WHERE h.hid IN (
    SELECT r.hot_id
    FROM Rooms r
    GROUP BY r.hot_id
    HAVING COUNT(r.room_id) >= 20
    INTERSECT
    SELECT e.hot_id
    FROM Employees e
    GROUP BY e.hot_id
    HAVING COUNT(e.emp_id) < 10
);


SELECT hf.hcity,hf.hstate, hf.hcountry,hf.hzipcode 
FROM HotelFacilities hf, Rooms ro, Books b, Reservations r
WHERE 
    hf.hid = ro.hot_id
    AND ro.room_id = b.room_id
    AND b.reservation_id = r.reservation_id
    AND r.reserved_date = TO_DATE('2023-11-23', 'YYYY-MM-DD')
GROUP BY 
    hf.hid, hf.hcity, hf.hstate, hf.hcountry, hf.hzipcode
ORDER BY 
    COUNT(r.reservation_id) ASC
FETCH FIRST 1 ROW ONLY;








SELECT hf.hname,r.room_type
FROM HotelFacilities hf,Rooms r
WHERE hf.hid = r.hot_id
    AND hf.htype = 'Resort'
    AND NOT hf.hname LIKE 'V%';





SELECT e1.first_name AS employee_name, e2.first_name AS supervisor_name
FROM Employees e1
JOIN Employees e2 ON e1.sid = e2.emp_id
WHERE e1.status = 'Active';





SELECT r.room_id,r.room_no 
FROM Rooms r 
WHERE r.hot_id in 
  ( SELECT h.hid
    FROM Hotelfacilities h
    WHERE h.hcountry = 'Germany');



SELECT e.first_name, e.last_name, e.role
FROM Employees e
WHERE e.emp_id IN (
    SELECT eid
    FROM HealthInsurance
) AND e.role = 'Staff';


SELECT DISTINCT
    g.first_name || ' ' || g.last_name AS guest_name,
    g.identity_proof
FROM Guests g, Eats e, Restaurants r
WHERE g.guest_id = e.guest_id
    AND e.id = r.id
    AND r.cuisine = 'Indian'
    AND g.contact LIKE '+49%'
    AND g.check_in_date <= TO_DATE('2024-11-06', 'YYYY-MM-DD');


SELECT hf.hname
FROM HotelFacilities hf
WHERE hf.hid IN (
    SELECT m.hot_id
    FROM Maintenance m
    WHERE m.mstatus = 'Pending'
)
INTERSECT
SELECT hf.hname
FROM HotelFacilities hf
WHERE hf.hid IN (
    SELECT u.hot_id
    FROM Upgrades u
    WHERE u.ustatus = 'Pending'
);


SELECT r.room_type,res.fare,res.reserved_date
FROM Rooms r,Books b,Reservations res
WHERE 
    r.room_id = b.room_id
    AND b.reservation_id = res.reservation_id
    AND res.fare > 600
    AND r.cooling_type <> 'Split';


SELECT g.identity_proof, MAX(g.reward_points) AS max_reward_points
FROM Guests g
GROUP BY g.identity_proof;


SELECT last_name
FROM Employees
WHERE last_name LIKE 'S%' OR last_name LIKE 'P%';




CREATE OR REPLACE FUNCTION total_employees_in_hotel(hid IN Employees.hot_id%TYPE)
RETURN NUMBER
IS
    total_emps NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO total_emps
    FROM Employees e
    WHERE e.hot_id = hid;
    
    RETURN total_emps;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE || '--' || SQLERRM);          
END;
/






SELECT total_employees_in_hotel(117) FROM dual;









CREATE OR REPLACE FUNCTION employee_count_by_certifications(cert_name IN Employees.certification%TYPE)
RETURN NUMBER
IS
    emp_count NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO emp_count
    FROM Employees e
    WHERE e.certification = cert_name;
    RETURN emp_count;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE(SQLCODE || '--' || SQLERRM);
        
END;
/


SELECT employee_count_by_certifications('Leadership Certification') FROM DUAL;











CREATE OR REPLACE FUNCTION get_maintenance_cost(
    m_year IN NUMBER,
    m_maintenance_type IN Maintenance.mtype%TYPE)
RETURN NUMBER
IS
    v_total_cost NUMBER := 0;
BEGIN
    SELECT SUM(m.mexpense) INTO v_total_cost
    FROM Maintenance m
    WHERE EXTRACT(YEAR FROM m.mdate) = m_year
      AND m.mtype = m_maintenance_type;
    RETURN v_total_cost;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE || '--' || SQLERRM);  
END;
/

SELECT get_maintenance_cost(2024,'Corrective') FROM DUAL;
















CREATE OR REPLACE FUNCTION count_guests_checked_in(
    p_start_date IN DATE,
    p_end_date IN DATE
)
RETURN NUMBER
IS
    v_guest_count NUMBER := 0;
    invalid_date EXCEPTION;
BEGIN
    IF p_end_date < p_start_date THEN
        RAISE invalid_date;
    END IF;
    SELECT COUNT(*) INTO v_guest_count
    FROM Guests g
    WHERE g.check_in_date >= p_start_date
    AND g.check_in_date <= p_end_date;
    RETURN v_guest_count;
EXCEPTION
    WHEN invalid_date THEN
        DBMS_OUTPUT.PUT_LINE('Error: End date cannot be earlier than start date.');     
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE || '--' || SQLERRM);   
END;
/



SELECT count_guests_checked_in(TO_DATE('2024-01-20', 'YYYY-MM-DD'),TO_DATE('2024-03-03', 'YYYY-MM-DD')) FROM DUAL;














CREATE OR REPLACE FUNCTION average_cuisine_price(cuisine_name IN RESTAURANTS.cuisine%TYPE)
RETURN NUMBER
IS
    avg_price NUMBER := 0;
BEGIN
    SELECT AVG(r.cuisine_price) INTO avg_price
    FROM Restaurants r
    WHERE r.cuisine = cuisine_name
    GROUP BY r.cuisine;
    RETURN avg_price;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE || '--' || SQLERRM);
END;
/










SELECT average_cuisine_price('Indian') FROM DUAL;








CREATE OR REPLACE PROCEDURE get_hotels_by_zip(zipcode HotelFacilities.hzipcode%TYPE)
IS
    hotel_name HotelFacilities.hname%TYPE;
    hotel_city HotelFacilities.hcity%TYPE;
BEGIN
    SELECT h.hname,h.hcity
    INTO hotel_name, hotel_city
    FROM HotelFacilities h
    WHERE h.hzipcode = zipcode;
    DBMS_OUTPUT.PUT_LINE('Hotel Name: ' || hotel_name || ', City: ' || hotel_city);
EXCEPTION
    
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No hotels found under the zipcode ' || zipcode);
END;
/







EXECUTE get_hotels_by_zip(52181);



CREATE OR REPLACE PROCEDURE total_expensive_upgrades
IS
    costly_upgrade_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO costly_upgrade_count
    FROM Upgrades u
    WHERE u.upgrade_cost > 3000;
    
    DBMS_OUTPUT.PUT_LINE('Total number of upgrades costing more than 3000 are ' || costly_upgrade_count);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        costly_upgrade_count := 0;
        DBMS_OUTPUT.PUT_LINE('Total number of upgrades costing more than 3000: ' || costly_upgrade_count);   
END;
/

EXECUTE total_expensive_upgrades;



CREATE OR REPLACE PROCEDURE employee_highest_premium
IS
    h_employee_name employees.first_name%TYPE;
    h_employee_id employees.emp_id%TYPE;
    h_max_premium NUMBER;
BEGIN
   SELECT MAX(h.premium_cost)
    INTO h_max_premium
    FROM HealthInsurance h;

    SELECT e.first_name || ' ' || e.last_name, e.emp_id
    INTO h_employee_name, h_employee_id
    FROM employees e
    WHERE e.emp_id = (
        SELECT h.eid
        FROM HealthInsurance h
        WHERE h.premium_cost = h_max_premium
    );

    DBMS_OUTPUT.PUT_LINE('Employee with the highest premium is ' || h_employee_name || ' with Employee ID: ' || h_employee_id);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found.');
    
END;
/

EXECUTE employee_highest_premium;



CREATE OR REPLACE PROCEDURE get_average_salary(e_hours Employees.hours%TYPE)
IS
    avg_salary NUMBER;
   
BEGIN
    SELECT AVG(e.salary)
    INTO avg_salary
    FROM Employees e
    WHERE e.hours = e_hours;
    DBMS_OUTPUT.PUT_LINE('The Average Salary of employees working for ' || e_hours || ' hours is ' || avg_salary);
EXCEPTION
    
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No Employees working for hours' || e_hours);
END;
/

EXECUTE get_average_salary(30);














CREATE OR REPLACE PROCEDURE fetch_reservation_details(
    res_id IN Reservations.reservation_id%TYPE
)
IS
    reservation_details Reservations%ROWTYPE;
BEGIN
    SELECT *
    INTO reservation_details
    FROM Reservations r
    WHERE r.reservation_id = res_id;
    
    DBMS_OUTPUT.PUT_LINE('The Reservation Details are');
    DBMS_OUTPUT.PUT_LINE('Reservation ID: ' || reservation_details.reservation_id);
    DBMS_OUTPUT.PUT_LINE('Fare: ' || reservation_details.fare);
    DBMS_OUTPUT.PUT_LINE('Reserved Date: ' || reservation_details.reserved_date);
    DBMS_OUTPUT.PUT_LINE('Room Count: ' || reservation_details.room_count);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No reservation found with ID ' || res_id);
    
END;
/


EXECUTE fetch_reservation_details('R107');


----- Triggers










SELECT AVG(h.rooms_per_facility) FROM HotelFacilities h WHERE h.hotel_rating = 10 AND h.hcountry = 'South Africa';

CREATE OR REPLACE TRIGGER AverageHotelRating
AFTER INSERT ON HotelFacilities
DECLARE
    v_average_rooms_per_facility NUMBER;
BEGIN
        SELECT AVG(h.rooms_per_facility)
        INTO v_average_rooms_per_facility
        FROM HotelFacilities h
        WHERE h.hotel_rating = 10 AND h.hcountry = 'South Africa';
    

        DBMS_OUTPUT.PUT_LINE('Average Rooms per facility of South African hotels with rating 10 is ' || v_average_rooms_per_facility);
    
END;
/





INSERT INTO HotelFacilities (hid, hname, hstate, hcity, hcountry, hzipcode, hotel_rating, hotel_capacity, rooms_per_facility, htype)
VALUES (199, 'RainbowSafari Resort','Orange Free State','Botshabelo', 'South Africa', '47898', 10, 800, 125, 'Resort');












SELECT COUNT(*)
        FROM ROOMS r
        WHERE  r.bed_type = 'Twin XL' AND r.hot_id IN 
           (SELECT h.hid FROM HOTELFACILITIES h WHERE h.hname = 'Vacation Resort');


CREATE OR REPLACE TRIGGER TwinXLroomcount
AFTER UPDATE ON ROOMS
DECLARE
    v_TwinXL NUMBER;
BEGIN
        SELECT COUNT(*)
        INTO v_TwinXL
        FROM ROOMS r
        WHERE  r.bed_type = 'Twin XL' AND r.hot_id IN 
           (SELECT h.hid FROM HOTELFACILITIES h WHERE h.hname = 'Vacation Resort');
    

        DBMS_OUTPUT.PUT_LINE(' The total number of TwinXL rooms in Vacation Resort is' || v_TwinXL);
    
END;
/

UPDATE Rooms
SET bed_type = 'Twin'
WHERE hot_id IN (
    SELECT h.hid
    FROM HotelFacilities h
    WHERE h.hname = 'Vacation Resort'
)
AND square_footage != 500;







SELECT MAX(cuisine_price) FROM Restaurants;

    
CREATE OR REPLACE TRIGGER expensive_cuisine_price
AFTER DELETE ON Restaurants
DECLARE
    expensive_cuisine Number;
BEGIN

    SELECT MAX(cuisine_price)
    INTO expensive_cuisine
    FROM Restaurants;

    DBMS_OUTPUT.PUT_LINE('The most expensive cuisine has a price of ' || expensive_cuisine);
END;
/

DELETE FROM Restaurants
WHERE cuisine_price = (
    SELECT MAX(cuisine_price)
    FROM Restaurants
);




CREATE OR REPLACE PACKAGE HotelCostCalculation AS
    
    FUNCTION calculate_total_maintenance_expense(hotel_id IN HotelFacilities.hid%TYPE) RETURN NUMBER;

   
    FUNCTION calculate_total_upgrade_expense(hotel_id IN HotelFacilities.hid%TYPE) RETURN NUMBER;

    
    PROCEDURE calculate_total_costs(hotel_id IN HotelFacilities.hid%TYPE);
END ;
/



CREATE OR REPLACE PACKAGE BODY HotelCostCalculation AS
    
    FUNCTION calculate_total_maintenance_expense(hotel_id IN HotelFacilities.hid%TYPE) RETURN NUMBER IS
        total_maintenance_expense NUMBER;
    BEGIN
        SELECT SUM(m.mexpense) INTO total_maintenance_expense
        FROM Maintenance m
        WHERE m.hot_id = hotel_id;
        
        RETURN total_maintenance_expense;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Error: No Hotels found under the Id' || hotel_id);
    END;




    FUNCTION calculate_total_upgrade_expense(hotel_id IN HotelFacilities.hid%TYPE) RETURN NUMBER IS
        total_upgrade_expense NUMBER;
    BEGIN
        SELECT SUM(u.upgrade_cost) INTO total_upgrade_expense
        FROM Upgrades u
        WHERE u.hot_id = hotel_id;
        
        RETURN total_upgrade_expense;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Error: No Hotels found under the Id' || hotel_id);
    END;




    PROCEDURE calculate_total_costs(hotel_id IN HotelFacilities.hid%TYPE) IS
        total_maintenance_expense NUMBER;
        total_upgrade_expense NUMBER;
        total_costs NUMBER;
    BEGIN
        
           total_maintenance_expense := calculate_total_maintenance_expense(hotel_id);
           total_upgrade_expense := calculate_total_upgrade_expense(hotel_id);
        
           total_costs := total_maintenance_expense + total_upgrade_expense;
        
           DBMS_OUTPUT.PUT_LINE('Total Management Costs for Hotel with ID ' || hotel_id || ' are ' || total_costs);
    END;
END;
/


SELECT HotelCostCalculation.calculate_total_maintenance_expense(149) FROM DUAL;

SELECT HotelCostCalculation.calculate_total_upgrade_expense(149) FROM DUAL;

EXECUTE HotelCostCalculation.calculate_total_costs(149);











