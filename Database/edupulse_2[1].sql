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
    ('s030', 's030@edu', 'student');


-- Insert data into the 'admin' table
INSERT INTO admin (admin_id, first_name, last_name, email, phone_no, flat_no, colony, district, pin_code)
VALUES
    ('a01', 'Admin', 'One', 'admin1@example.com', '1234567890', 'Flat 101', 'Vallabh Nagar', 'Indore', 452001),
    ('a02', 'Admin', 'Two', 'admin2@example.com', '9876543210', 'Flat 202', 'Shivaji Nagar', 'Indore', 452002);

-- Insert data into the 'teachers' table
INSERT INTO teachers (teacher_id, first_name, last_name, email, phone_no, flat_no, colony, district, pin_code, class_teacher_flag)
VALUES
    ('t001', 'Teacher', 'One', 'teacher1@example.com', '1111111111', 'Flat 301', 'Vallabh Nagar', 'Indore', 452001, 1),
    ('t002', 'Teacher', 'Two', 'teacher2@example.com', '2222222222', 'Flat 401', 'Shivaji Nagar', 'Indore', 452002, 0),
    ('t003', 'Teacher', 'Three', 'teacher3@example.com', '3333333333', 'Flat 501', 'Malviya Nagar', 'Indore', 452003, 0),
    ('t004', 'Teacher', 'Four', 'teacher4@example.com', '4444444444', 'Flat 601', 'Mhow Naka', 'Indore', 452004, 1),
    ('t005', 'Teacher', 'Five', 'teacher5@example.com', '5555555555', 'Flat 701', 'Geeta Bhawan', 'Indore', 452005, 0),
    ('t006', 'Teacher', 'Six', 'teacher6@example.com', '6666666666', 'Flat 801', 'Rajwada', 'Indore', 452006, 0),
    ('t007', 'Teacher', 'Seven', 'teacher7@example.com', '7777777777', 'Flat 901', 'Sapna Sangeeta', 'Indore', 452007, 1),
    ('t008', 'Teacher', 'Eight', 'teacher8@example.com', '8888888888', 'Flat 1001', 'Bhawarkua', 'Indore', 452008, 0),
    ('t009', 'Teacher', 'Nine', 'teacher9@example.com', '9999999999', 'Flat 1101', 'Pardesipura', 'Indore', 452009, 0),
    ('t010', 'Teacher', 'Ten', 'teacher10@example.com', '1010101010', 'Flat 1201', 'MG Road', 'Indore', 452010, 1);

-- Insert data into the 'classes' table
INSERT INTO classes (class_id, class_name, total_students) VALUES
    (1, 'Class 1', 30),
    (2, 'Class 2', 30),
    (3, 'Class 3', 30),
    (4, 'Class 4', 30),
    (5, 'Class 5', 30),
    (6, 'Class 6', 30),
    (7, 'Class 7', 30),
    (8, 'Class 8', 30),
    (9, 'Class 9', 30),
    (10, 'Class 10', 30);

-- Insert data into the 'students' table
INSERT INTO students (student_id, first_name, last_name, DOB, flat_no, colony, district, pin_code, class_id, sex, Age, result_percent, result_status, tot_atten_percent)
VALUES
    ('s001', 'Student', 'One', '2005-05-15', 'Flat 501', 'Vallabh Nagar', 'Indore', 452001, 1, 'Male', 16, 90.50, 'Pass', 95.00),
    ('s002', 'Student', 'Two', '2005-06-20', 'Flat 502', 'Shivaji Nagar', 'Indore', 452002, 1, 'Female', 16, 85.25, 'Pass', 94.50),
    ('s003', 'Student', 'Three', '2005-07-25', 'Flat 503', 'Malviya Nagar', 'Indore', 452003, 1, 'Male', 16, 88.75, 'Pass', 96.00),
    ('s004', 'Student', 'Four', '2005-08-30', 'Flat 504', 'Mhow Naka', 'Indore', 452004, 2, 'Female', 16, 86.00, 'Pass', 94.00),
    ('s005', 'Student', 'Five', '2005-09-05', 'Flat 505', 'Geeta Bhawan', 'Indore', 452005, 2, 'Male', 16, 91.25, 'Pass', 96.50),
    ('s006', 'Student', 'Six', '2005-10-10', 'Flat 506', 'Rajwada', 'Indore', 452006, 2, 'Female', 16, 87.75, 'Pass', 95.25),
    ('s007', 'Student', 'Seven', '2005-11-15', 'Flat 507', 'Sapna Sangeeta', 'Indore', 452007, 3, 'Male', 16, 89.00, 'Pass', 95.75),
    ('s008', 'Student', 'Eight', '2005-12-20', 'Flat 508', 'Bhawarkua', 'Indore', 452008, 3, 'Female', 16, 88.50, 'Pass', 94.75),
    ('s009', 'Student', 'Nine', '2006-01-25', 'Flat 509', 'Pardesipura', 'Indore', 452009, 3, 'Male', 15, 90.00, 'Pass', 97.00),
    ('s010', 'Student', 'Ten', '2006-02-28', 'Flat 510', 'MG Road', 'Indore', 452010, 4, 'Female', 15, 85.75, 'Pass', 94.25),
    ('s011', 'Student', 'Eleven', '2006-03-05', 'Flat 511', 'Vallabh Nagar', 'Indore', 452001, 4, 'Male', 15, 87.25, 'Pass', 96.25),
    ('s012', 'Student', 'Twelve', '2006-04-10', 'Flat 512', 'Shivaji Nagar', 'Indore', 452002, 4, 'Female', 15, 89.50, 'Pass', 95.50),
    ('s013', 'Student', 'Thirteen', '2006-05-15', 'Flat 513', 'Malviya Nagar', 'Indore', 452003, 5, 'Male', 15, 90.75, 'Pass', 97.25),
    ('s014', 'Student', 'Fourteen', '2006-06-20', 'Flat 514', 'Mhow Naka', 'Indore', 452004, 5, 'Female', 15, 86.25, 'Pass', 94.75),
    ('s015', 'Student', 'Fifteen', '2006-07-25', 'Flat 515', 'Geeta Bhawan', 'Indore', 452005, 5, 'Male', 15, 88.00, 'Pass', 96.00),
    ('s016', 'Student', 'Sixteen', '2006-08-30', 'Flat 516', 'Rajwada', 'Indore', 452006, 6, 'Female', 15, 87.50, 'Pass', 95.50),
    ('s017', 'Student', 'Seventeen', '2006-09-05', 'Flat 517', 'Sapna Sangeeta', 'Indore', 452007, 6, 'Male', 15, 90.25, 'Pass', 97.00),
    ('s018', 'Student', 'Eighteen', '2006-10-10', 'Flat 518', 'Bhawarkua', 'Indore', 452008, 6, 'Female', 15, 89.75, 'Pass', 96.25),
    ('s019', 'Student', 'Nineteen', '2006-11-15', 'Flat 519', 'Pardesipura', 'Indore', 452009, 7, 'Male', 15, 91.50, 'Pass', 97.50),
    ('s020', 'Student', 'Twenty', '2006-12-20', 'Flat 520', 'MG Road', 'Indore', 452010, 7, 'Female', 15, 85.00, 'Pass', 94.00),
    ('s021', 'Student', 'Twenty-One', '2007-01-25', 'Flat 521', 'Vallabh Nagar', 'Indore', 452001, 7, 'Male', 14, 87.75, 'Pass', 95.00),
    ('s022', 'Student', 'Twenty-Two', '2007-02-28', 'Flat 522', 'Shivaji Nagar', 'Indore', 452002, 8, 'Female', 14, 89.25, 'Pass', 95.75),
    ('s023', 'Student', 'Twenty-Three', '2007-03-05', 'Flat 523', 'Malviya Nagar', 'Indore', 452003, 8, 'Male', 14, 90.00, 'Pass', 96.50),
    ('s024', 'Student', 'Twenty-Four', '2007-04-10', 'Flat 524', 'Mhow Naka', 'Indore', 452004, 8, 'Female', 14, 86.75, 'Pass', 94.25),
    ('s025', 'Student', 'Twenty-Five', '2007-05-15', 'Flat 525', 'Geeta Bhawan', 'Indore', 452005, 9, 'Male', 14, 88.50, 'Pass', 96.25),
    ('s026', 'Student', 'Twenty-Six', '2007-06-20', 'Flat 526', 'Rajwada', 'Indore', 452006, 9, 'Female', 14, 87.25, 'Pass', 95.25),
    ('s027', 'Student', 'Twenty-Seven', '2007-07-25', 'Flat 527', 'Sapna Sangeeta', 'Indore', 452007, 9, 'Male', 14, 91.75, 'Pass', 97.75),
    ('s028', 'Student', 'Twenty-Eight', '2007-08-30', 'Flat 528', 'Bhawarkua', 'Indore', 452008, 10, 'Female', 14, 85.00, 'Pass', 94.00),
    ('s029', 'Student', 'Twenty-Nine', '2007-09-05', 'Flat 529', 'Pardesipura', 'Indore', 452009, 10, 'Male', 14, 87.00, 'Pass', 95.00),
    ('s030', 'Student', 'Thirty', '2007-10-10', 'Flat 530', 'MG Road', 'Indore', 452010, 10, 'Female', 14, 90.25, 'Pass', 96.75);

-- Insert data into the 'parents' table for the first 10 students
INSERT INTO parents (parent_id, student_id, first_name, last_name, relation, phone_no, email_id)
VALUES
    ('p001', 's001', 'Parent', 'One', 'Mother', '7111111111', 'parent1@example.com'),
    ('p002', 's002', 'Parent', 'Two', 'Father', '8222222222', 'parent2@example.com'),
    ('p003', 's003', 'Parent', 'Three', 'Mother', '7333333333', 'parent3@example.com'),
    ('p004', 's004', 'Parent', 'Four', 'Father', '8444444444', 'parent4@example.com'),
    ('p005', 's005', 'Parent', 'Five', 'Mother', '7555555555', 'parent5@example.com'),
    ('p006', 's006', 'Parent', 'Six', 'Father', '8666666666', 'parent6@example.com'),
    ('p007', 's007', 'Parent', 'Seven', 'Mother', '7777777777', 'parent7@example.com'),
    ('p008', 's008', 'Parent', 'Eight', 'Father', '8888888888', 'parent8@example.com'),
    ('p009', 's009', 'Parent', 'Nine', 'Mother', '9999999999', 'parent9@example.com'),
    ('p010', 's010', 'Parent', 'Ten', 'Father', '7101010101', 'parent10@example.com');

-- Insert data into the 'subjects' table
INSERT INTO subjects (subject_id, subject_name, class_id) VALUES
    ('sub001', 'Mathematics', 1),
    ('sub002', 'Science', 1),
    ('sub003', 'English', 1),
    ('sub004', 'Social Studies', 2),
    ('sub005', 'Hindi', 2),
    ('sub006', 'Mathematics', 2),
    ('sub007', 'Science', 3),
    ('sub008', 'English', 3),
    ('sub009', 'Social Studies', 3),
    ('sub010', 'Hindi', 4);

-- Insert data into the 'teaches' table for the first 2 teachers
INSERT INTO teaches (teacher_id, class_id, subject_id) VALUES
    ('t001', 1, 'sub001'),
    ('t002', 1, 'sub002');

-- Insert data into the 'leaves' table for the first 2 students
INSERT INTO leaves (id, student_id, date_asked, date_from, date_to, reason)
VALUES
    (1, 's001', '2023-09-01', '2023-09-05', '2023-09-06', 'Medical Leave'),
    (2, 's002', '2023-09-02', '2023-09-07', '2023-09-10', 'Family Vacation');

-- Insert data into the 'marks' table for the first 2 students
INSERT INTO marks (student_id, subject_id, MST1, MST2, half_yearly, MST3, MST4, annual, percent, grade) VALUES
    ('s001', 'sub001', 80, 85, 90, 88, 92, 95, 90.00, 'A'),
    ('s002', 'sub001', 75, 82, 88, 86, 90, 92, 88.00, 'B'),
    ('s003', 'sub001', 85, 88, 92, 90, 94, 97, 92.00, 'A'),
    ('s004', 'sub001', 78, 86, 87, 85, 89, 91, 86.00, 'B'),
    ('s005', 'sub001', 90, 92, 95, 93, 96, 98, 94.00, 'A'),
    ('s006', 'sub001', 92, 94, 98, 96, 99, 100, 96.00, 'A'),
    ('s007', 'sub001', 84, 88, 90, 87, 91, 94, 89.00, 'B'),
    ('s008', 'sub001', 76, 84, 86, 82, 88, 90, 84.00, 'B'),
    ('s009', 'sub001', 89, 91, 94, 92, 96, 98, 92.00, 'A'),
    ('s010', 'sub001', 80, 87, 88, 85, 90, 93, 88.00, 'B');

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


