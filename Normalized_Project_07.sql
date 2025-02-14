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
CREATE TABLE HotelFacilityNames (
    hname VARCHAR2(40) NOT NULL,
    hstate VARCHAR2(40)PRIMARY KEY
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




















CREATE TABLE EmployeeNames (
    date_of_birth DATE PRIMARY KEY,
    first_name VARCHAR2(255)
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
VALUES (152, 'Golden Hill Resort','Louisiana','Layfetville', 'USA', '75052', 10, 500, 70, 'Resort');
INSERT INTO HotelFacilities (hid, hname, hstate, hcity, hcountry, hzipcode, hotel_rating, hotel_capacity, rooms_per_facility, htype)
VALUES (157, 'The Grand Canyon','Arizona','Flagstaff', 'USA', '75088', 10, 500, 70, 'Resort');















INSERT INTO HotelFacilityNames (hname, hstate)
VALUES ('Vacation Resort', 'California');
INSERT INTO HotelFacilityNames (hname, hstate)
VALUES ('Legendary Resort', 'Texas');
INSERT INTO HotelFacilityNames (hname, hstate)
VALUES ('Beach Resort', 'Florida');
INSERT INTO HotelFacilityNames (hname, hstate)
VALUES ('Riverbridge Hotel', 'New Jersey');
INSERT INTO HotelFacilityNames (hname, hstate)
VALUES ('Lakeview Hotel', 'Cordoba');
INSERT INTO HotelFacilityNames (hname, hstate)
VALUES ('Beach Inn', 'Tasmania');
INSERT INTO HotelFacilityNames (hname, hstate)
VALUES ('Red Triangle Resort', 'Bayangol');
INSERT INTO HotelFacilityNames (hname, hstate)
VALUES ('Wild Safari Resort', 'Orange Free State');
INSERT INTO HotelFacilityNames (hname, hstate)
VALUES ('Spanish Heritage Resort', 'Vizcaya provincia');
INSERT INTO HotelFacilityNames (hname, hstate)
VALUES ('Vintage Düsseldorf', 'North Rhine-Westphalia');
INSERT INTO HotelFacilityNames (hname, hstate)
VALUES ('Unicorn Rainbow Resort', 'North Carolina');
INSERT INTO HotelFacilityNames (hname, hstate)
VALUES ('Golden Hill Resort', 'Louisiana');
INSERT INTO HotelFacilityNames (hname, hstate)
VALUES ('The Grand Canyon', 'Arizona');








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







INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id,workdate)
VALUES ('E101', NULL, 'John, Wilson', 50000.00, 'Active', 'Manager', TO_DATE('1980-05-15', 'YYYY-MM-DD'), TO_DATE('2020-01-01', 'YYYY-MM-DD'), 'Bachelors Degree', 'None', 'Management Certification', 40, 'Alice', 'Smith', 117, TO_DATE('2022-01-01', 'YYYY-MM-DD'));
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id,workdate)
VALUES ('E102', 'E101', 'Henry, Amanda', 30000.00, 'Active', 'Staff', TO_DATE('1987-08-15', 'YYYY-MM-DD'), TO_DATE('2015-07-01', 'YYYY-MM-DD'), 'Bachelors Degree', 'None', 'Management Certification', 30, 'Jane', 'Parker', 117, TO_DATE('2022-01-01', 'YYYY-MM-DD'));
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id,workdate)
VALUES ('E103', NULL, 'Scott', 45000.00, 'Active', 'Staff', TO_DATE('1984-08-22', 'YYYY-MM-DD'), TO_DATE('2021-04-15', 'YYYY-MM-DD'), 'Masters Degree', 'Child Abuse', 'Leadership Certification', 35, 'Bob', 'Johansson', 119, TO_DATE('2022-01-01', 'YYYY-MM-DD'));
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id,workdate)
VALUES ('E104', NULL, 'Alex, Ethan, Eli', 60000.00, 'Active', 'Supervisor', TO_DATE('1992-11-10', 'YYYY-MM-DD'), TO_DATE('2019-07-01', 'YYYY-MM-DD'), 'Bachelors Degree', 'None', 'None', 38, 'Ross', 'DeSand', 118, TO_DATE('2022-01-01', 'YYYY-MM-DD'));
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id,workdate)
VALUES ('E105', NULL, 'Olivia', 55000.00, 'Active', 'Analyst', TO_DATE('1988-04-30', 'YYYY-MM-DD'), TO_DATE('2018-02-10', 'YYYY-MM-DD'), 'Bachelors Degree', 'None', 'Analytical Certification', 30, 'Chris', 'Renaux', 121, TO_DATE('2022-01-01', 'YYYY-MM-DD'));
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id,workdate)
VALUES ('E106', NULL, 'Grace, Sophie', 48000.00, 'Inactive', 'Clerk', TO_DATE('1995-09-18', 'YYYY-MM-DD'), TO_DATE('2022-05-05', 'YYYY-MM-DD'), 'Associate Degree', 'Domestic Violence', 'None', 25, 'Sophia', 'Clark', 122, TO_DATE('2022-01-01', 'YYYY-MM-DD'));
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id,workdate)
VALUES ('E107', NULL, 'Oscar,Amelia', 58000.00, 'Active', 'Supervisor', TO_DATE('1983-11-12', 'YYYY-MM-DD'), TO_DATE('2017-11-20', 'YYYY-MM-DD'), 'Masters Degree', 'None', 'Leadership Certification', 40, 'Bandlie', 'Ayanda', 124, TO_DATE('2022-01-01', 'YYYY-MM-DD'));
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id,workdate)
VALUES ('E108', 'E107', 'Kholwa,Kamau', 48000.00, 'Active', 'Staff', TO_DATE('1983-19-12', 'YYYY-MM-DD'), TO_DATE('2017-11-20', 'YYYY-MM-DD'), 'Masters Degree', 'Gun Crime', 'None', 34, 'Francois', 'Bavuma', 124, TO_DATE('2022-01-01', 'YYYY-MM-DD'));
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id,workdate)
VALUES ('E109', NULL, 'Baker', 42000.00, 'Active', 'Staff', TO_DATE('1990-07-25', 'YYYY-MM-DD'), TO_DATE('2016-06-10', 'YYYY-MM-DD'), 'Bachelors Degree', 'None', 'None', 28, 'Warren', 'Nottingam', 127, TO_DATE('2022-01-01', 'YYYY-MM-DD'));
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id,workdate)
VALUES ('E110', NULL, 'Zoe, Zach', 49000.00, 'Inactive', 'Staff', TO_DATE('1993-03-14', 'YYYY-MM-DD'), TO_DATE('2023-01-15', 'YYYY-MM-DD'), 'Associate Degree', 'Theft', 'None', 32, 'Harry', 'Jones', 129, TO_DATE('2022-01-01', 'YYYY-MM-DD'));
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id,workdate)
VALUES ('E111', NULL, 'Diego, Isabella', 43000.00, 'Active', 'Analyst', TO_DATE('1981-09-08', 'YYYY-MM-DD'), TO_DATE('2019-12-01', 'YYYY-MM-DD'), 'Masters Degree', 'None', 'Analytical Certification', 36, 'Manuel', 'Alvarez', 137, TO_DATE('2022-01-01', 'YYYY-MM-DD'));
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id,workdate)
VALUES ('E112', NULL, NULL, 56000.00, 'Active', 'Staff', TO_DATE('1986-11-20', 'YYYY-MM-DD'), TO_DATE('2015-08-05', 'YYYY-MM-DD'), 'Bachelors Degree', 'Gang Offender', 'Leadership Certification', 34, 'Adolf', 'Günter', 147, TO_DATE('2022-01-01', 'YYYY-MM-DD'));
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id,workdate)
VALUES ('E113', NULL, 'Atlan,Batu', 46000.00, 'Active', 'Staff', TO_DATE('1986-11-20', 'YYYY-MM-DD'), TO_DATE('2015-08-05', 'YYYY-MM-DD'), 'Bachelors Degree', 'None', 'Management Certification', 34, 'Arban', 'Temullen', 149, TO_DATE('2022-01-01', 'YYYY-MM-DD'));
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id,workdate)
VALUES ('E114', NULL, 'Eun,Park,Hun', 54000.00, 'Active', 'Analyst', TO_DATE('1994-06-28', 'YYYY-MM-DD'), TO_DATE('2016-12-10', 'YYYY-MM-DD'), 'Bachelors Degree', 'None', 'Analytical Certification', 40, 'Beom', 'Seok', 152, TO_DATE('2022-01-01', 'YYYY-MM-DD'));
INSERT INTO Employees (emp_id, sid, dependents, salary, status, role, date_of_birth, start_date, education, criminal_record, certification, hours, first_name, last_name, hot_id,workdate)
VALUES ('E115', NULL, NULL, 51000.00, 'Active', 'Coordinator', TO_DATE('1989-04-12', 'YYYY-MM-DD'), TO_DATE('2020-05-20', 'YYYY-MM-DD'), 'Associate Degree', 'Property Crime', 'None', 15, 'Diachi', 'Yamamoto', 157, TO_DATE('2022-01-01', 'YYYY-MM-DD'));


INSERT INTO employeenames (date_of_birth, first_name)
VALUES (TO_DATE('1980-05-15', 'YYYY-MM-DD'), 'Alice');
INSERT INTO employeenames (date_of_birth, first_name)
VALUES (TO_DATE('1987-08-15', 'YYYY-MM-DD'), 'Jane');
INSERT INTO employeenames (date_of_birth, first_name)
VALUES (TO_DATE('1984-08-22', 'YYYY-MM-DD'), 'Bob');
INSERT INTO employeenames (date_of_birth, first_name)
VALUES (TO_DATE('1992-11-10', 'YYYY-MM-DD'), 'Ross');
INSERT INTO employeenames (date_of_birth, first_name)
VALUES (TO_DATE('1988-04-30', 'YYYY-MM-DD'), 'Chris');
INSERT INTO employeenames (date_of_birth, first_name)
VALUES (TO_DATE('1995-09-18', 'YYYY-MM-DD'), 'Sophia');
INSERT INTO employeenames (date_of_birth, first_name)
VALUES (TO_DATE('1983-11-12', 'YYYY-MM-DD'), 'Bandlie');
INSERT INTO employeenames (date_of_birth, first_name)
VALUES (TO_DATE('1993-03-14', 'YYYY-MM-DD'), 'Harry');
INSERT INTO employeenames (date_of_birth, first_name)
VALUES (TO_DATE('1981-09-08', 'YYYY-MM-DD'), 'Manuel');
INSERT INTO employeenames (date_of_birth, first_name)
VALUES (TO_DATE('1989-11-20', 'YYYY-MM-DD'), 'Adolf');
INSERT INTO employeenames (date_of_birth, first_name)
VALUES (TO_DATE('1986-11-20', 'YYYY-MM-DD'), 'Arban');
INSERT INTO employeenames (date_of_birth, first_name)
VALUES (TO_DATE('1994-06-28', 'YYYY-MM-DD'), 'Beom');
INSERT INTO employeenames (date_of_birth, first_name)
VALUES (TO_DATE('1989-04-12', 'YYYY-MM-DD'), 'Diachi');

INSERT INTO employeenames (date_of_birth, first_name)
VALUES (TO_DATE('1990-07-25', 'YYYY-MM-DD'), 'Warren');
delete from EmployeeNames where date_of_birth = TO_DATE('1983-12-12', 'YYYY-MM-DD');


select * from EmployeeNames where date_of_birth Not In ( select date_of_birth from Employees);







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


select * from HealthInsurance;






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


select * from Employees;












SELECT * FROM EmployeeNames;



SELECT *
FROM Employees
NATURAL JOIN EmployeeNames;
