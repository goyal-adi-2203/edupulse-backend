-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS edupulse_2;
USE edupulse_2;

-- Create the 'users' table
CREATE TABLE IF NOT EXISTS users (
    user_id VARCHAR(10) PRIMARY KEY,
    password VARCHAR(256) NOT NULL,
    usertype VARCHAR(10) NOT NULL
);

-- Create the 'admin' table
CREATE TABLE IF NOT EXISTS admin (
    admin_id VARCHAR(10) PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(30) NOT NULL,
    phone_no VARCHAR(15) NOT NULL,
    flat_no VARCHAR(255),
    colony VARCHAR(255),
    district VARCHAR(255),
    pin_code INT,
    FOREIGN KEY (admin_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create the 'teachers' table
CREATE TABLE IF NOT EXISTS teachers (
    teacher_id VARCHAR(10) PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(30) NOT NULL,
    phone_no VARCHAR(15) NOT NULL,
    flat_no VARCHAR(255),
    colony VARCHAR(255),
    district VARCHAR(255),
    pin_code INT,
    class_teacher_flag INT NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create the 'classes' table
CREATE TABLE IF NOT EXISTS classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(30) NOT NULL,
    total_students INT NOT NULL
);

-- Create the 'students' table
CREATE TABLE IF NOT EXISTS students (
    student_id VARCHAR(10) PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    DOB DATE NOT NULL,
    flat_no VARCHAR(255),
    colony VARCHAR(255),
    district VARCHAR(255),
    pin_code INT,
    class_id INT NOT NULL,
    sex VARCHAR(10) NOT NULL,
    Age INT NOT NULL,
    result_percent DECIMAL(5, 2),
    result_status VARCHAR(10),
    tot_atten_percent DECIMAL(5, 2),
    FOREIGN KEY (student_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create the 'parents' table
CREATE TABLE IF NOT EXISTS parents (
    parent_id VARCHAR(10) PRIMARY KEY,
    student_id VARCHAR(10) NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    relation VARCHAR(30) NOT NULL,
    phone_no VARCHAR(15) NOT NULL,
    email_id VARCHAR(30) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create the 'subjects' table
CREATE TABLE IF NOT EXISTS subjects (
    subject_id VARCHAR(10) PRIMARY KEY,
    subject_name VARCHAR(50) NOT NULL,
    class_id INT NOT NULL,
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create the 'teaches' table
CREATE TABLE IF NOT EXISTS teaches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_id VARCHAR(10) NOT NULL,
    class_id INT NOT NULL,
    subject_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create the 'leaves' table
CREATE TABLE IF NOT EXISTS leaves (
    id INT PRIMARY KEY,
    student_id VARCHAR(10) NOT NULL,
    date_asked DATE NOT NULL,
    date_from DATE NOT NULL,
    date_to DATE NOT NULL,
    reason VARCHAR(255) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create the 'marks' table
CREATE TABLE IF NOT EXISTS marks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id VARCHAR(10) NOT NULL,
    subject_id VARCHAR(10) NOT NULL,
    MST1 INT,
    MST2 INT,
    half_yearly INT,
    MST3 INT,
    MST4 INT,
    annual INT,
    percent DECIMAL(5, 2),
    grade CHAR(1),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create the 'attendance' table
CREATE TABLE IF NOT EXISTS attendance (
    attendance_id INT PRIMARY KEY,
    student_id VARCHAR(10) NOT NULL,
    date DATE NOT NULL,
    flag INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create the 'announcements' table
CREATE TABLE IF NOT EXISTS announcements (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(10),
    date DATE NOT NULL,
    content VARCHAR(2048),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Create a trigger to handle user deletions and set user_id to NULL in announcements
DELIMITER $$
CREATE TRIGGER `user_delete` BEFORE DELETE ON `users`
  FOR EACH ROW BEGIN
    UPDATE `announcements` SET `user_id` = NULL WHERE `user_id` = OLD.`user_id`;
  END $$
DELIMITER ;

-- Insert data into the 'users' table
INSERT INTO users (user_id, password, usertype) VALUES
    ('a01', 'a01@edu', 'admin'),
    ('a02', 'a02@edu', 'admin'),
    ('t001', 't001@edu', 'teacher'),
    ('t002', 't002@edu', 'teacher'),
    ('t003', 't003@edu', 'teacher'),
    ('t004', 't004@edu', 'teacher'),
    ('t005', 't005@edu', 'teacher'),
    ('t006', 't006@edu', 'teacher'),
    ('t007', 't007@edu', 'teacher'),
    ('t008', 't008@edu', 'teacher'),
    ('t009', 't009@edu', 'teacher'),
    ('t010', 't010@edu', 'teacher'),
    ('s001', 's001@edu', 'student'),
    ('s002', 's002@edu', 'student'),
    ('s003', 's003@edu', 'student'),
    ('s004', 's004@edu', 'student'),
    ('s005', 's005@edu', 'student'),
    ('s006', 's006@edu', 'student'),
    ('s007', 's007@edu', 'student'),
    ('s008', 's008@edu', 'student'),
    ('s009', 's009@edu', 'student'),
    ('s010', 's010@edu', 'student'),
    ('s011', 's011@edu', 'student'),
    ('s012', 's012@edu', 'student'),
    ('s013', 's013@edu', 'student'),
    ('s014', 's014@edu', 'student'),
    ('s015', 's015@edu', 'student'),
    ('s016', 's016@edu', 'student'),
    ('s017', 's017@edu', 'student'),
    ('s018', 's018@edu', 'student'),
    ('s019', 's019@edu', 'student'),
    ('s020', 's020@edu', 'student'),
    ('s021', 's021@edu', 'student'),
    ('s022', 's022@edu', 'student'),
    ('s023', 's023@edu', 'student'),
    ('s024', 's024@edu', 'student'),
    ('s025', 's025@edu', 'student'),
    ('s026', 's026@edu', 'student'),
    ('s027', 's027@edu', 'student'),
    ('s028', 's028@edu', 'student'),
    ('s029', 's029@edu', 'student'),
    ('s030', 's030@edu', 'student'),
    ('s031', 's031@edu', 'student'),
    ('s032', 's032@edu', 'student'),
    ('s033', 's033@edu', 'student'),
    ('s034', 's034@edu', 'student'),
    ('s035', 's035@edu', 'student'),
    ('s036', 's036@edu', 'student'),
    ('s037', 's037@edu', 'student'),
    ('s038', 's038@edu', 'student'),
    ('s039', 's039@edu', 'student'),
    ('s040', 's040@edu', 'student'),
    ('s041', 's041@edu', 'student'),
    ('s042', 's042@edu', 'student'),
    ('s043', 's043@edu', 'student'),
    ('s044', 's044@edu', 'student'),
    ('s045', 's045@edu', 'student'),
    ('s046', 's046@edu', 'student'),
    ('s047', 's047@edu', 'student'),
    ('s048', 's048@edu', 'student'),
    ('s049', 's049@edu', 'student'),
    ('s050', 's050@edu', 'student'),
    ('s051', 's051@edu', 'student'),
    ('s052', 's052@edu', 'student'),
    ('s053', 's053@edu', 'student'),
    ('s054', 's054@edu', 'student'),
    ('s055', 's055@edu', 'student'),
    ('s056', 's056@edu', 'student'),
    ('s057', 's057@edu', 'student'),
    ('s058', 's058@edu', 'student'),
    ('s059', 's059@edu', 'student'),
    ('s060', 's060@edu', 'student'),
    ('s061', 's061@edu', 'student'),
    ('s062', 's062@edu', 'student'),
    ('s063', 's063@edu', 'student'),
    ('s064', 's064@edu', 'student'),
    ('s065', 's065@edu', 'student'),
    ('s066', 's066@edu', 'student'),
    ('s067', 's067@edu', 'student'),
    ('s068', 's068@edu', 'student'),
    ('s069', 's069@edu', 'student'),
    ('s070', 's070@edu', 'student'),
    ('s071', 's071@edu', 'student'),
    ('s072', 's072@edu', 'student'),
    ('s073', 's073@edu', 'student'),
    ('s074', 's074@edu', 'student'),
    ('s075', 's075@edu', 'student'),
    ('s076', 's076@edu', 'student'),
    ('s077', 's077@edu', 'student'),
    ('s078', 's078@edu', 'student'),
    ('s079', 's079@edu', 'student'),
    ('s080', 's080@edu', 'student'),
    ('s081', 's081@edu', 'student'),
    ('s082', 's082@edu', 'student'),
    ('s083', 's083@edu', 'student'),
    ('s084', 's084@edu', 'student'),
    ('s085', 's085@edu', 'student'),
    ('s086', 's086@edu', 'student'),
    ('s087', 's087@edu', 'student'),
    ('s088', 's088@edu', 'student'),
    ('s089', 's089@edu', 'student'),
    ('s090', 's090@edu', 'student');


-- Insert data into the 'admin' table
INSERT INTO admin (admin_id, first_name, last_name, email, phone_no, flat_no, colony, district, pin_code)
VALUES
    ('a01', 'Admin', 'One', 'admin1@example.com', '1234567890', 'Flat 101', 'Vallabh Nagar', 'Indore', 452001),
    ('a02', 'Admin', 'Two', 'admin2@example.com', '9876543210', 'Flat 202', 'Shivaji Nagar', 'Indore', 452002);

-- Insert data into the 'teachers' table
INSERT INTO teachers (teacher_id, first_name, last_name, email, phone_no, flat_no, colony, district, pin_code, class_teacher_flag)
VALUES
    ('t001', 'Rajesh', 'Kumar', 'rajesh.kumar@example.com', '+91 12345 67890', 'Flat 101', 'Shivaji Nagar', 'Delhi', 110001, 3),
    ('t002', 'Priya', 'Sharma', 'priya.sharma@example.com', '+91 98765 43210', 'Apt 202', 'Malviya Nagar', 'Mumbai', 400001, 0),
    ('t003', 'Amit', 'Singh', 'amit.singh@example.com', '+91 55555 55555', 'Suite 303', 'Rajwada', 'Bhopal', 462001, 0),
    ('t004', 'Sneha', 'Verma', 'sneha.verma@example.com', '+91 77777 77777', 'Unit 404', 'Geeta Bhawan', 'Indore', 452001,0),
    ('t005', 'Pooja', 'Patel', 'pooja.patel@example.com', '+91 22222 33333', 'Flat 505', 'Sapna Sangeeta', 'Indore', 452002, 0),
    ('t006', 'Rahul', 'Gupta', 'rahul.gupta@example.com', '+91 99999 88888', 'Apt 606', 'Bhawarkua', 'Indore', 452003, 4),
    ('t007', 'Neha', 'Yadav', 'neha.yadav@example.com', '+91 11111 22222', 'Flat 707', 'Vallabh Nagar', 'Indore', 452004, 0),
    ('t008', 'Vikas', 'Tiwari', 'vikas.tiwari@example.com', '+91 88888 99999', 'Suite 808', 'Pardesipura', 'Indore', 452005, 0),
    ('t009', 'Suman', 'Shukla', 'suman.shukla@example.com', '+91 44444 55555', 'Apt 909', 'MG Road', 'Indore', 452006, 0),
    ('t010', 'Amit', 'Sharma', 'amit.sharma@example.com', '+91 77777 88888', 'Flat 1010', 'Rajwada', 'Indore', 452007, 5);


-- Insert data into the 'classes' table
INSERT INTO classes (class_id, class_name, total_students) VALUES
    (4, 'Class 4', 30),
    (5, 'Class 5', 30),
    (6, 'Class 6', 30);

-- Insert data into the 'students' table
INSERT INTO students (student_id, first_name, last_name, DOB, flat_no, colony, district, pin_code, class_id, sex, Age, result_percent, result_status, tot_atten_percent)
VALUES
    ('s001', 'Aditi', 'Solanki', '2005-05-15', 'Flat 501', 'Vallabh Nagar', 'Indore', 452001, 4, 'Female', 16, 90.50, 'Pass', 95.00),
    ('s002', 'Aniket', 'Pandey', '2005-06-20', 'Flat 502', 'Shivaji Nagar', 'Mumbai', 400001, 4, 'Male', 16, 85.25, 'Pass', 94.50),
    ('s003', 'Aishwarya', 'Verma', '2005-07-25', 'Flat 503', 'Malviya Nagar', 'Delhi', 110001, 4, 'Female', 16, 88.75, 'Pass', 96.00),
    ('s004', 'Aarav', 'Joshi', '2005-08-30', 'Flat 504', 'Mhow Naka', 'Bhopal', 462001, 4, 'Male', 16, 86.00, 'Pass', 94.00),
    ('s005', 'Akshita', 'Sharma', '2005-09-05', 'Flat 505', 'Geeta Bhawan', 'Jaipur', 302001, 4, 'Female', 16, 91.25, 'Pass', 96.50),
    ('s006', 'Shruti', 'Shukla', '2005-10-10', 'Flat 506', 'Rajwada', 'Indore', 452006, 4, 'Female', 16, 87.75, 'Pass', 95.25),
    ('s007', 'Ram', 'Sharma', '2005-11-15', 'Flat 507', 'Sapna Sangeeta', 'Indore', 452007, 4, 'Male', 16, 89.00, 'Pass', 95.75),
    ('s008', 'Aman', 'Tiwari', '2005-12-20', 'Flat 508', 'Bhawarkua', 'Kanpur', 208001, 4, 'Male', 16, 88.50, 'Pass', 94.75),
    ('s009', 'Ishita', 'Kumar', '2006-01-25', 'Flat 509', 'Pardesipura', 'Lucknow', 226001, 4, 'Female', 15, 90.00, 'Pass', 97.00),
    ('s010', 'Kartik', 'Singh', '2006-02-28', 'Flat 510', 'MG Road', 'Lucknow', 226002, 4, 'Male', 15, 85.75, 'Pass', 94.25),
    ('s011', 'Riya', 'Mishra', '2006-03-05', 'Flat 511', 'Vallabh Nagar', 'Bhopal', 462002, 4, 'Female', 15, 87.25, 'Pass', 96.25),
    ('s012', 'Nikhil', 'Gupta', '2006-04-10', 'Flat 512', 'Shivaji Nagar', 'Mumbai', 400002, 4, 'Male', 15, 89.50, 'Pass', 95.50),
    ('s013', 'Amit', 'Yadav', '2006-05-15', 'Flat 513', 'Malviya Nagar', 'Delhi', 110002, 4, 'Male', 15, 90.75, 'Pass', 97.25),
    ('s014', 'Divya', 'Choudhary', '2006-06-20', 'Flat 514', 'Mhow Naka', 'Bhopal', 462003, 4, 'Female', 15, 86.25, 'Pass', 94.75),
    ('s015', 'Akash', 'Rajput', '2006-07-25', 'Flat 515', 'Geeta Bhawan', 'Jaipur', 302002, 4, 'Male', 15, 88.00, 'Pass', 96.00),
    ('s016', 'Neha', 'Sharma', '2006-08-30', 'Flat 516', 'Rajwada', 'Indore', 452008, 4, 'Female', 15, 87.50, 'Pass', 95.50),
    ('s017', 'Rahul', 'Verma', '2006-09-05', 'Flat 517', 'Sapna Sangeeta', 'Indore', 452009, 4, 'Male', 15, 90.25, 'Pass', 97.00),
    ('s018', 'Pooja', 'Yadav', '2006-10-10', 'Flat 518', 'Bhawarkua', 'Kanpur', 208002, 4, 'Female', 15, 89.75, 'Pass', 96.25),
    ('s019', 'Abhishek', 'Kumar', '2006-11-15', 'Flat 519', 'Pardesipura', 'Lucknow', 226003, 4, 'Male', 15, 91.50, 'Pass', 97.50),
    ('s020', 'Priya', 'Gupta', '2006-12-20', 'Flat 520', 'MG Road', 'Lucknow', 226004, 4, 'Female', 15, 85.00, 'Pass', 94.00),
	('s021', 'Vikas', 'Sharma', '2007-01-25', 'Flat 521', 'Vallabh Nagar', 'Bhopal', 462004, 4, 'Male', 14, 87.75, 'Pass', 95.00),
    ('s022', 'Ritika', 'Mishra', '2007-02-28', 'Flat 522', 'Shivaji Nagar', 'Mumbai', 400003, 4, 'Female', 14, 89.25, 'Pass', 95.75),
    ('s023', 'Rahul', 'Gupta', '2007-03-05', 'Flat 523', 'Malviya Nagar', 'Delhi', 110003, 4, 'Male', 14, 90.00, 'Pass', 96.50),
    ('s024', 'Priyanka', 'Singh', '2007-04-10', 'Flat 524', 'Mhow Naka', 'Bhopal', 462005, 4, 'Female', 14, 86.75, 'Pass', 94.25),
    ('s025', 'Varun', 'Yadav', '2007-05-15', 'Flat 525', 'Geeta Bhawan', 'Jaipur', 302003, 4, 'Male', 14, 88.50, 'Pass', 96.25),
    ('s026', 'Pooja', 'Sharma', '2007-06-20', 'Flat 526', 'Rajwada', 'Indore', 452010, 4, 'Female', 14, 87.25, 'Pass', 95.25),
    ('s027', 'Ravi', 'Verma', '2007-07-25', 'Flat 527', 'Sapna Sangeeta', 'Indore', 452011, 4, 'Male', 14, 91.75, 'Pass', 97.75),
    ('s028', 'Meenu', 'Tiwari', '2007-08-30', 'Flat 528', 'Bhawarkua', 'Kanpur', 208003, 4, 'Female', 14, 85.00, 'Pass', 94.00),
    ('s029', 'Rohan', 'Kumar', '2007-09-05', 'Flat 529', 'Pardesipura', 'Lucknow', 226005, 4, 'Male', 14, 87.00, 'Pass', 95.00),
    ('s030', 'Sneha', 'Shukla', '2007-10-10', 'Flat 530', 'MG Road', 'Lucknow', 226006, 4, 'Female', 14, 90.25, 'Pass', 96.75),
    ('s031', 'Rahul', 'Gupta', '2005-03-25', 'Flat 531', 'Vallabh Nagar', 'Bhopal', 462006, 5, 'Male', 16, 92.00, 'Pass', 97.25),
    ('s032', 'Anamika', 'Sharma', '2005-04-30', 'Flat 532', 'Shivaji Nagar', 'Mumbai', 400004, 5, 'Female', 16, 84.50, 'Pass', 93.50),
    ('s033', 'Ajay', 'Yadav', '2005-05-05', 'Flat 533', 'Malviya Nagar', 'Delhi', 110004, 5, 'Male', 16, 89.25, 'Pass', 95.75),
    ('s034', 'Neha', 'Verma', '2005-06-10', 'Flat 534', 'Mhow Naka', 'Bhopal', 462007, 5, 'Female', 16, 87.75, 'Pass', 95.25),
    ('s035', 'Amit', 'Sharma', '2005-07-15', 'Flat 535', 'Geeta Bhawan', 'Jaipur', 302004, 5, 'Male', 16, 91.00, 'Pass', 96.75),
    ('s036', 'Neha', 'Sinha', '2005-08-20', 'Flat 536', 'Rajwada', 'Indore', 452012, 5, 'Female', 16, 88.00, 'Pass', 95.00),
    ('s037', 'Rahul', 'Shukla', '2005-09-25', 'Flat 537', 'Sapna Sangeeta', 'Indore', 452013, 5, 'Male', 16, 92.75, 'Pass', 97.50),
    ('s038', 'Rani', 'Mishra', '2005-10-30', 'Flat 538', 'Bhawarkua', 'Kanpur', 208004, 5, 'Female', 16, 85.50, 'Pass', 94.25),
    ('s039', 'Aditya', 'Yadav', '2005-11-05', 'Flat 539', 'Pardesipura', 'Lucknow', 226007, 5, 'Male', 16, 88.75, 'Pass', 96.00),
    ('s040', 'Aparna', 'Kumar', '2005-12-10', 'Flat 540', 'MG Road', 'Lucknow', 226008, 5, 'Female', 15, 90.50, 'Pass', 97.00),
    ('s041', 'Vikas', 'Sharma', '2006-01-15', 'Flat 541', 'Vallabh Nagar', 'Bhopal', 462008, 5, 'Male', 15, 86.75, 'Pass', 94.75),
    ('s042', 'Sapna', 'Gupta', '2006-02-20', 'Flat 542', 'Shivaji Nagar', 'Mumbai', 400005, 5, 'Female', 15, 88.00, 'Pass', 96.00),
    ('s043', 'Raj', 'Tiwari', '2006-03-25', 'Flat 543', 'Malviya Nagar', 'Delhi', 110005, 5, 'Male', 15, 89.25, 'Pass', 95.25),
	('s044', 'Riya', 'Verma', '2006-04-30', 'Flat 544', 'Mhow Naka', 'Bhopal', 462009, 5, 'Female', 15, 90.50, 'Pass', 97.00),
    ('s045', 'Alok', 'Sharma', '2006-05-05', 'Flat 545', 'Geeta Bhawan', 'Jaipur', 302005, 5, 'Male', 15, 87.25, 'Pass', 95.25),
    ('s046', 'Anjali', 'Yadav', '2006-06-10', 'Flat 546', 'Rajwada', 'Indore', 452014, 5, 'Female', 15, 89.75, 'Pass', 96.25),
    ('s047', 'Rahul', 'Mishra', '2006-07-15', 'Flat 547', 'Sapna Sangeeta', 'Indore', 452015, 5, 'Male', 15, 91.00, 'Pass', 96.75),
    ('s048', 'Priya', 'Shukla', '2006-08-20', 'Flat 548', 'Bhawarkua', 'Kanpur', 208005, 5, 'Female', 15, 86.50, 'Pass', 94.50),
    ('s049', 'Rajesh', 'Gupta', '2006-09-25', 'Flat 549', 'Pardesipura', 'Lucknow', 226009, 5, 'Male', 15, 88.25, 'Pass', 95.25),
    ('s050', 'Poonam', 'Sinha', '2006-10-30', 'Flat 550', 'MG Road', 'Lucknow', 226010, 5, 'Female', 15, 92.50, 'Pass', 97.50),
    ('s051', 'Vikram', 'Sharma', '2006-11-05', 'Flat 551', 'Vallabh Nagar', 'Bhopal', 462010, 5, 'Male', 15, 85.75, 'Pass', 94.25),
    ('s052', 'Renu', 'Mishra', '2006-12-10', 'Flat 552', 'Shivaji Nagar', 'Mumbai', 400006, 5, 'Female', 15, 87.75, 'Pass', 95.00),
    ('s053', 'Manoj', 'Gupta', '2007-01-15', 'Flat 553', 'Malviya Nagar', 'Delhi', 110006, 5, 'Male', 14, 90.25, 'Pass', 96.50),
    ('s054', 'Aarti', 'Yadav', '2007-02-20', 'Flat 554', 'Mhow Naka', 'Bhopal', 462011, 5, 'Female', 14, 86.75, 'Pass', 94.75),
    ('s055', 'Ankur', 'Sharma', '2007-03-25', 'Flat 555', 'Geeta Bhawan', 'Jaipur', 302006, 5, 'Male', 14, 91.75, 'Pass', 97.75),
    ('s056', 'Sarika', 'Tiwari', '2007-04-30', 'Flat 556', 'Rajwada', 'Indore', 452016, 5, 'Female', 14, 85.00, 'Pass', 94.00),
    ('s057', 'Deepak', 'Kumar', '2007-05-05', 'Flat 557', 'Sapna Sangeeta', 'Indore', 452017, 5, 'Male', 14, 87.00, 'Pass', 95.00),
    ('s058', 'Sonam', 'Sharma', '2007-06-10', 'Flat 558', 'Bhawarkua', 'Kanpur', 208006, 5, 'Female', 14, 90.00, 'Pass', 96.25),
    ('s059', 'Vikas', 'Verma', '2007-07-15', 'Flat 559', 'Pardesipura', 'Lucknow', 226011, 5, 'Male', 14, 86.00, 'Pass', 94.00),
    ('s060', 'Neha', 'Yadav', '2007-08-20', 'Flat 560', 'MG Road', 'Lucknow', 226012, 5, 'Female', 14, 88.00, 'Pass', 95.50),
    ('s061', 'Rajesh', 'Shukla', '2007-09-25', 'Flat 561', 'Vallabh Nagar', 'Bhopal', 462012, 6, 'Male', 14, 92.00, 'Pass', 97.00),
    ('s062', 'Suman', 'Verma', '2007-10-30', 'Flat 562', 'Shivaji Nagar', 'Mumbai', 400007, 6, 'Female', 16, 85.50, 'Pass', 94.25),
    ('s063', 'Pawan', 'Gupta', '2007-11-05', 'Flat 563', 'Malviya Nagar', 'Delhi', 110007, 6, 'Male', 16, 88.50, 'Pass', 96.00),
    ('s064', 'Kiran', 'Yadav', '2007-12-10', 'Flat 564', 'Mhow Naka', 'Bhopal', 462013, 6, 'Female', 16, 89.75, 'Pass', 96.50),
    ('s065', 'Sanjay', 'Sharma', '2008-01-15', 'Flat 565', 'Geeta Bhawan', 'Jaipur', 302007, 6, 'Male', 16, 85.75, 'Pass', 94.75),
    ('s066', 'Sneha', 'Tiwari', '2008-02-20', 'Flat 566', 'Rajwada', 'Indore', 452018, 6, 'Female', 16, 88.75, 'Pass', 95.25),
	('s067', 'Rajat', 'Kumar', '2008-03-25', 'Flat 567', 'Sapna Sangeeta', 'Indore', 452019, 6, 'Male', 16, 92.50, 'Pass', 97.50),
    ('s068', 'Anjali', 'Sharma', '2008-04-30', 'Flat 568', 'Bhawarkua', 'Kanpur', 208007, 6, 'Female', 16, 85.25, 'Pass', 94.25),
    ('s069', 'Vivek', 'Yadav', '2008-05-05', 'Flat 569', 'Pardesipura', 'Lucknow', 226013, 6, 'Male', 16, 87.00, 'Pass', 95.00),
    ('s070', 'Swati', 'Mishra', '2008-06-10', 'Flat 570', 'MG Road', 'Lucknow', 226014, 6, 'Female', 16, 91.25, 'Pass', 96.75),
    ('s071', 'Abhishek', 'Shukla', '2008-07-15', 'Flat 571', 'Vallabh Nagar', 'Bhopal', 462014, 6, 'Male', 16, 86.00, 'Pass', 94.00),
    ('s072', 'Nisha', 'Gupta', '2008-08-20', 'Flat 572', 'Shivaji Nagar', 'Mumbai', 400008, 6, 'Female', 16, 89.00, 'Pass', 95.50),
    ('s073', 'Rajeev', 'Verma', '2008-09-25', 'Flat 573', 'Malviya Nagar', 'Delhi', 110008, 6, 'Male', 16, 92.00, 'Pass', 97.00),
    ('s074', 'Priyanka', 'Yadav', '2008-10-30', 'Flat 574', 'Mhow Naka', 'Bhopal', 462015, 6, 'Female', 16, 85.50, 'Pass', 94.25),
    ('s075', 'Saurabh', 'Sharma', '2008-11-05', 'Flat 575', 'Geeta Bhawan', 'Jaipur', 302008, 6, 'Male', 16, 87.50, 'Pass', 95.25),
    ('s076', 'Pooja', 'Tiwari', '2008-12-10', 'Flat 576', 'Rajwada', 'Indore', 452020, 6, 'Female', 16, 91.50, 'Pass', 97.50),
    ('s077', 'Amit', 'Kumar', '2009-01-15', 'Flat 577', 'Sapna Sangeeta', 'Indore', 452021, 6, 'Male', 16, 86.75, 'Pass', 94.75),
    ('s078', 'Anita', 'Verma', '2009-02-20', 'Flat 578', 'Bhawarkua', 'Kanpur', 208008, 6, 'Female', 16, 88.75, 'Pass', 96.25),
    ('s079', 'Rakesh', 'Sharma', '2009-03-25', 'Flat 579', 'Pardesipura', 'Lucknow', 226015, 6, 'Male', 16, 92.75, 'Pass', 97.75),
    ('s080', 'Swati', 'Mishra', '2009-04-30', 'Flat 580', 'MG Road', 'Lucknow', 226016, 6, 'Female', 16, 85.00, 'Pass', 94.00),
    ('s081', 'Suresh', 'Yadav', '2009-05-05', 'Flat 581', 'Vallabh Nagar', 'Bhopal', 462016, 6, 'Male', 16, 87.00, 'Pass', 95.25),
    ('s082', 'Poonam', 'Shukla', '2009-06-10', 'Flat 582', 'Shivaji Nagar', 'Mumbai', 400009, 6, 'Female', 16, 91.00, 'Pass', 96.50),
    ('s083', 'Amit', 'Gupta', '2009-07-15', 'Flat 583', 'Malviya Nagar', 'Delhi', 110009, 6, 'Male', 16, 86.25, 'Pass', 94.25),
    ('s084', 'Neha', 'Verma', '2009-08-20', 'Flat 584', 'Mhow Naka', 'Bhopal', 462017, 6, 'Female', 16, 88.00, 'Pass', 95.00),
    ('s085', 'Rajat', 'Sharma', '2009-09-25', 'Flat 585', 'Geeta Bhawan', 'Jaipur', 302009, 6, 'Male', 16, 92.00, 'Pass', 97.00),
    ('s086', 'Nisha', 'Tiwari', '2009-10-30', 'Flat 586', 'Rajwada', 'Indore', 452022, 6, 'Female', 16, 85.50, 'Pass', 94.25),
    ('s087', 'Alok', 'Yadav', '2009-11-05', 'Flat 587', 'Sapna Sangeeta', 'Indore', 452023, 6, 'Male', 16, 88.75, 'Pass', 96.25),
    ('s088', 'Suman', 'Sharma', '2009-12-10', 'Flat 588', 'Bhawarkua', 'Kanpur', 208009, 6, 'Female', 16, 91.50, 'Pass', 97.50),
    ('s089', 'Abhishek', 'Kumar', '2010-01-15', 'Flat 589', 'Pardesipura', 'Lucknow', 226017, 6, 'Male', 16, 85.75, 'Pass', 94.50),
    ('s090', 'Rajesh', 'Verma', '2010-02-20', 'Flat 590', 'MG Road', 'Lucknow', 226018, 6, 'Male', 16, 85.75, 'Pass', 94.50);





-- Insert data into the 'parents' table for the first 10 students
INSERT INTO parents (parent_id, student_id, first_name, last_name, relation, phone_no, email_id)
VALUES
    ('p001', 's001', 'Ramesh', 'Solanki', 'Father', '+91 12345 67890', 'ramesh.solanki@example.com'),
    ('p002', 's002', 'Sunita', 'Solanki', 'Mother', '+91 98765 43210', 'sunita.solanki@example.com'),
    ('p003', 's003', 'Vikram', 'Suryavanshi', 'Father', '+91 55555 55555', 'vikram.suryavanshi@example.com'),
    ('p004', 's004', 'Neha', 'Suryavanshi', 'Mother', '+91 77777 77777', 'neha.suryavanshi@example.com'),
    ('p005', 's005', 'Rajesh', 'Goyal', 'Father', '+91 22222 33333', 'rajesh.goyal@example.com'),
    ('p006', 's006', 'Anita', 'Goyal', 'Mother', '+91 99999 88888', 'anita.goyal@example.com'),
    ('p007', 's007', 'Vijay', 'Bajpai', 'Father', '+91 11111 22222', 'vijay.bajpai@example.com'),
    ('p008', 's008', 'Sarita', 'Bajpai', 'Mother', '+91 88888 99999', 'sarita.bajpai@example.com'),
    ('p009', 's016', 'Kamal', 'Solanki', 'Father', '+91 44444 55555', 'kamal.solanki@example.com'),
    ('p010', 's009', 'Neeta', 'Solanki', 'Mother', '+91 77777 88888', 'neeta.solanki@example.com'),
    ('p011', 's010', 'Rajendra', 'Shukla', 'Father', '+91 11111 22222', 'rajendra.shukla@example.com'),
    ('p012', 's011', 'Meera', 'Shukla', 'Mother', '+91 88888 99999', 'meera.shukla@example.com'),
    ('p013', 's012', 'Lakshman', 'Sharma', 'Father', '+91 22222 33333', 'lakshman.sharma@example.com'),
    ('p014', 's013', 'Rekha', 'Sharma', 'Mother', '+91 99999 88888', 'rekha.sharma@example.com'),
    ('p015', 's014', 'Vishal', 'Tiwari', 'Father', '+91 55555 55555', 'vishal.tiwari@example.com'),
    ('p016', 's015', 'Anju', 'Tiwari', 'Mother', '+91 77777 77777', 'anju.tiwari@example.com'),
    ('p017', 's017', 'Raj', 'Nine', 'Father', '+91 12345 67890', 'raj.nine@example.com'),
    ('p018', 's018', 'Suman', 'Nine', 'Mother', '+91 98765 43210', 'suman.nine@example.com'),
    ('p019', 's019', 'Vivek', 'Ten', 'Father', '+91 55555 55555', 'vivek.ten@example.com'),
    ('p020', 's020', 'Neelam', 'Ten', 'Mother', '+91 77777 77777', 'neelam.ten@example.com'),
    ('p021', 's021', 'Rajesh', 'tiwari', 'Father', '+91 22222 33333', 'rajesh.tiwari@example.com'),
    ('p022', 's022', 'Savita', 'tiwari', 'Mother', '+91 99999 88888', 'savita.tiwari@example.com'),
    ('p023', 's023', 'Vijay', 'Twelve', 'Father', '+91 11111 22222', 'vijay.twelve@example.com'),
    ('p024', 's024', 'Neeta', 'Twelve', 'Mother', '+91 88888 99999', 'neeta.twelve@example.com'),
    ('p025', 's025', 'Rajendra', 'Thirteen', 'Father', '+91 44444 55555', 'rajendra.thirteen@example.com'),
    ('p026', 's026', 'Meera', 'Thirteen', 'Mother', '+91 77777 88888', 'meera.thirteen@example.com'),
    ('p027', 's027', 'Lakshman', 'tiwari', 'Father', '+91 12345 67890', 'lakshman.tiwari@example.com'),
    ('p028', 's028', 'Rekha', 'tiwari', 'Mother', '+91 98765 43210', 'rekha.tiwari@example.com'),
    ('p029', 's029', 'Vishal', 'Fifteen', 'Father', '+91 55555 55555', 'vishal.fifteen@example.com'),
    ('p030', 's030', 'Anju', 'Fifteen', 'Mother', '+91 77777 77777', 'anju.fifteen@example.com'),
    ('p031', 's031', 'Raj', 'tiwari', 'Father', '+91 22222 33333', 'raj.tiwari@example.com'),
    ('p032', 's032', 'Suman', 'tiwari', 'Mother', '+91 99999 88888', 'suman.tiwari@example.com'),
    ('p033', 's033', 'Vivek', 'Seventeen', 'Father', '+91 55555 55555', 'vivek.seventeen@example.com'),
    ('p034', 's034', 'Neelam', 'Seventeen', 'Mother', '+91 77777 77777', 'neelam.seventeen@example.com'),
    ('p035', 's035', 'Rajesh', 'Eighteen', 'Father', '+91 12345 67890', 'rajesh.eighteen@example.com'),
    ('p036', 's036', 'Savita', 'Eighteen', 'Mother', '+91 98765 43210', 'savita.eighteen@example.com'),
    ('p037', 's037', 'Vijay', 'Nineteen', 'Father', '+91 55555 55555', 'vijay.nineteen@example.com'),
    ('p038', 's038', 'Neeta', 'Nineteen', 'Mother', '+91 77777 77777', 'neeta.nineteen@example.com'),
    ('p039', 's039', 'Rajendra', 'Twenty', 'Father', '+91 22222 33333', 'rajendra.twenty@example.com'),
    ('p040', 's040', 'Meera', 'Twenty', 'Mother', '+91 99999 88888', 'meera.twenty@example.com'),
    ('p041', 's041', 'Amit', 'Singh', 'Father', '+91 33333 44444', 'amit.singh@example.com'),
    ('p042', 's042', 'Sangeeta', 'Singh', 'Mother', '+91 88888 77777', 'sangeeta.singh@example.com'),
    ('p043', 's043', 'Rajat', 'Verma', 'Father', '+91 77777 66666', 'rajat.verma@example.com'),
    ('p044', 's044', 'Poonam', 'Verma', 'Mother', '+91 22222 55555', 'poonam.verma@example.com'),
    ('p045', 's045', 'Vikram', 'Kumar', 'Father', '+91 66666 77777', 'vikram.kumar@example.com'),
    ('p046', 's046', 'Neeta', 'Kumar', 'Mother', '+91 11111 44444', 'neeta.kumar@example.com'),
    ('p047', 's047', 'Rajendra', 'Yadav', 'Father', '+91 44444 55555', 'rajendra.yadav@example.com'),
    ('p048', 's048', 'Sunita', 'Yadav', 'Mother', '+91 77777 66666', 'sunita.yadav@example.com'),
    ('p049', 's049', 'Amit', 'Sharma', 'Father', '+91 55555 44444', 'amit.sharma@example.com'),
    ('p050', 's050', 'Meera', 'Sharma', 'Mother', '+91 88888 55555', 'meera.sharma@example.com'),
    ('p051', 's051', 'Vivek', 'Singh', 'Father', '+91 33333 44444', 'vivek.singh@example.com'),
    ('p052', 's052', 'Savita', 'Singh', 'Mother', '+91 88888 77777', 'savita.singh@example.com'),
    ('p053', 's053', 'Rajesh', 'Verma', 'Father', '+91 77777 66666', 'rajesh.verma@example.com'),
    ('p054', 's054', 'Poonam', 'Verma', 'Mother', '+91 22222 55555', 'poonam.verma@example.com'),
    ('p055', 's055', 'Vikram', 'Kumar', 'Father', '+91 66666 77777', 'vikram.kumar@example.com'),
    ('p056', 's056', 'Neeta', 'Kumar', 'Mother', '+91 11111 44444', 'neeta.kumar@example.com'),
    ('p057', 's057', 'Rajendra', 'Yadav', 'Father', '+91 44444 55555', 'rajendra.yadav@example.com'),
    ('p058', 's058', 'Sunita', 'Yadav', 'Mother', '+91 77777 66666', 'sunita.yadav@example.com'),
    ('p059', 's059', 'Amit', 'Sharma', 'Father', '+91 55555 44444', 'amit.sharma@example.com'),
    ('p060', 's060', 'Meera', 'Sharma', 'Mother', '+91 88888 55555', 'meera.sharma@example.com');
    -- Previous 60 tuples (from the previous responses)
INSERT INTO parents (parent_id, student_id, first_name, last_name, relation, phone_no, email_id)
VALUES
    ('p061', 's061', 'Amit', 'Singh', 'Father', '+91 33333 44444', 'amit.singh@example.com'),
    ('p062', 's062', 'Sangeeta', 'Singh', 'Mother', '+91 88888 77777', 'sangeeta.singh@example.com'),
    ('p063', 's063', 'Rajat', 'Verma', 'Father', '+91 77777 66666', 'rajat.verma@example.com'),
    ('p064', 's064', 'Poonam', 'Verma', 'Mother', '+91 22222 55555', 'poonam.verma@example.com'),
    ('p065', 's065', 'Vikram', 'Kumar', 'Father', '+91 66666 77777', 'vikram.kumar@example.com'),
    ('p066', 's066', 'Neeta', 'Kumar', 'Mother', '+91 11111 44444', 'neeta.kumar@example.com'),
    ('p067', 's067', 'Rajendra', 'Yadav', 'Father', '+91 44444 55555', 'rajendra.yadav@example.com'),
    ('p068', 's068', 'Sunita', 'Yadav', 'Mother', '+91 77777 66666', 'sunita.yadav@example.com'),
    ('p069', 's069', 'Amit', 'Sharma', 'Father', '+91 55555 44444', 'amit.sharma@example.com'),
    ('p070', 's070', 'Meera', 'Sharma', 'Mother', '+91 88888 55555', 'meera.sharma@example.com'),
    ('p071', 's071', 'Vivek', 'Singh', 'Father', '+91 33333 44444', 'vivek.singh@example.com'),
    ('p072', 's072', 'Savita', 'Singh', 'Mother', '+91 88888 77777', 'savita.singh@example.com'),
    ('p073', 's073', 'Rajesh', 'Verma', 'Father', '+91 77777 66666', 'rajesh.verma@example.com'),
    ('p074', 's074', 'Poonam', 'Verma', 'Mother', '+91 22222 55555', 'poonam.verma@example.com'),
    ('p075', 's075', 'Vikram', 'Kumar', 'Father', '+91 66666 77777', 'vikram.kumar@example.com'),
    ('p076', 's076', 'Neeta', 'Kumar', 'Mother', '+91 11111 44444', 'neeta.kumar@example.com'),
    ('p077', 's077', 'Rajendra', 'Yadav', 'Father', '+91 44444 55555', 'rajendra.yadav@example.com'),
    ('p078', 's078', 'Sunita', 'Yadav', 'Mother', '+91 77777 66666', 'sunita.yadav@example.com'),
    ('p079', 's079', 'Amit', 'Sharma', 'Father', '+91 55555 44444', 'amit.sharma@example.com'),
    ('p080', 's080', 'Meera', 'Sharma', 'Mother', '+91 88888 55555', 'meera.sharma@example.com'),
    ('p081', 's081', 'Rajat', 'Singh', 'Father', '+91 33333 44444', 'rajat.singh@example.com'),
    ('p082', 's082', 'Poonam', 'Singh', 'Mother', '+91 88888 77777', 'poonam.singh@example.com'),
    ('p083', 's083', 'Vikram', 'Verma', 'Father', '+91 77777 66666', 'vikram.verma@example.com'),
    ('p084', 's084', 'Neeta', 'Verma', 'Mother', '+91 22222 55555', 'neeta.verma@example.com'),
    ('p085', 's085', 'Rajendra', 'Kumar', 'Father', '+91 66666 77777', 'rajendra.kumar@example.com'),
    ('p086', 's086', 'Sunita', 'Kumar', 'Mother', '+91 11111 44444', 'sunita.kumar@example.com'),
    ('p087', 's087', 'Amit', 'Yadav', 'Father', '+91 44444 55555', 'amit.yadav@example.com'),
    ('p088', 's088', 'Meera', 'Yadav', 'Mother', '+91 77777 66666', 'meera.yadav@example.com'),
    ('p089', 's089', 'Vivek', 'Sharma', 'Father', '+91 55555 44444', 'vivek.sharma@example.com'),
    ('p090', 's090', 'Savita', 'Sharma', 'Mother', '+91 88888 55555', 'savita.sharma@example.com');



-- Insert data into the 'subjects' table
INSERT INTO subjects (subject_id, subject_name, class_id) VALUES
    ('sub001', 'Mathematics', 4),
    ('sub002', 'Science', 4),
    ('sub003', 'English', 4),
    ('sub004', 'Social Studies', 4),
    ('sub005', 'Hindi', 4),
    ('sub006', 'Mathematics', 5),
    ('sub007', 'Science', 5),
    ('sub008', 'English', 5),
    ('sub009', 'Social Studies', 5),
    ('sub010', 'Hindi', 5),
    ('sub011', 'Mathematics', 6),
    ('sub012', 'Science', 6),
    ('sub013', 'English', 6),
    ('sub014', 'Social Studies', 6),
    ('sub015', 'Hindi', 6);

-- Insert data into the 'teaches' table for the first 2 teachers
INSERT INTO teaches (teacher_id, class_id, subject_id) VALUES
    ('t001', 4, 'sub001'),
    ('t002', 4, 'sub002'),
    ('t003', 4, 'sub003'),
    ('t004', 4, 'sub005'),
    ('t005', 4, 'sub004'),
	('t006', 5, 'sub006'),
    ('t003', 5, 'sub008'),
    ('t004', 5, 'sub010'),
    ('t008', 5, 'sub007'),
    ('t009', 5, 'sub009'),
    ('t003', 6, 'sub013'),
    ('t004', 6, 'sub015'),
    ('t010', 6, 'sub012'),
	('t007', 6, 'sub011'),
    ('t005', 6, 'sub014');


-- Insert data into the 'leaves' table for the first 2 students
INSERT INTO leaves (id, student_id, date_asked, date_from, date_to, reason)
VALUES
    (1, 's001', '2023-09-01', '2023-09-05', '2023-09-06', 'Medical Leave'),
    (2, 's002', '2023-09-02', '2023-09-07', '2023-09-10', 'Family Vacation');

-- Insert data into the 'marks' table for the first 2 students
INSERT INTO marks (student_id, subject_id, MST1, MST2,half_yearly, MST3, MST4) VALUES
    ('s001', 'sub001', 20, 15, 90, 18, 12),
    ('s002', 'sub001', 15, 12, 88, 16, 20),
    ('s003', 'sub001', 15, 18, 92, 10, 14),
    ('s004', 'sub001', 18, 16, 87, 15, 19),
    ('s005', 'sub001', 20, 12, 95, 13, 16),
    ('s006', 'sub001', 12, 14, 98, 16, 19),
    ('s007', 'sub001', 14, 18, 90, 17, 11),
    ('s008', 'sub001', 16, 14, 86, 12, 18),
    ('s009', 'sub001', 19, 11, 94, 12, 16),
    ('s010', 'sub001', 10, 17, 88, 15, 10);

-- Insert data into the 'attendance' table for the first 2 students
INSERT INTO attendance (attendance_id, student_id, date, flag)
VALUES
    (1, 's001', '2023-09-01', 1),
    (2, 's002', '2023-09-01', 1);

-- Insert data into the 'announcements' table
INSERT INTO announcements (user_id, date, content) VALUES
    ('a01', '2023-09-01', 'Welcome to the new school year!'),
    ('a01', '2023-09-05', 'Parent-Teacher meetings on September 15th.'),
    ('a02', '2023-09-02', 'Important: Class 1A field trip on September 10th.'),
    ('a02', '2023-09-06', 'School will be closed on September 8th due to a holiday.'),
    ('t001', '2023-09-03', 'Homework for Math: Complete exercises 1-5.'),
    ('t002', '2023-09-04', 'Science quiz on Friday. Study chapters 3 and 4.');

