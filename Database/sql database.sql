create database edupulse;
use edupulse;
drop database edupulse;

CREATE DATABASE IF NOT EXISTS edupulse_2;
USE edupulse_2;

-- Create the 'users' table
CREATE TABLE IF NOT EXISTS users (
    user_id VARCHAR(10) PRIMARY KEY,
    password VARCHAR(256) NOT NULL,
    usertype VARCHAR(10) NOT NULL
);

desc users;
INSERT INTO users (user_id, password, usertype) VALUES
    ('a01', 'a01@edu', 'Admin'),
    ('t001', 't001@edu', 'Teacher'),
    ('s001', 's001@edu', 'Student'),
    ('s002', 's002@edu', 'Student'),
    ('s003', 's003@edu', 'Student'),
    ('s004', 's004@edu', 'Student'),
    ('s005', 's005@edu', 'Student');

insert into users(user_id, password, usertype)
values ('a02', 'a02@edu', 'Admin');

insert into users(user_id, password, usertype)
values ('t002', 't002@edu', 'Teacher'),
		('t003', 't003@edu', 'Teacher');

select * from users;

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

insert into admin values('a01', 'Aditya', 'Goyal', 'goyaladitya2212@gmail.com', '8269164751', '106', 'Rajkamal Tower, Navlakha', 'Indore', 452001);
select * from admin;	

-- Create the 'teachers' table
CREATE TABLE IF NOT EXISTS teachers (
    teacher_id VARCHAR(10) PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(30) NOT NULL,
    phone_no VARCHAR(15) NOT NULL,
    flat_no VARCHAR(255),
    gender VARCHAR(10) NOT NULL,
    colony VARCHAR(255),
    district VARCHAR(255),
    state VARCHAR(50) NOT NULL,
    pin_code INT,
    class_teacher_flag INT DEFAULT 0,
    FOREIGN KEY (teacher_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);

alter table teachers drop column pin_code;
desc teachers;

INSERT INTO teachers (teacher_id, first_name, last_name, email, phone_no, flat_no, gender, colony, district, state, pin_code, class_teacher_flag)
VALUES
    ('t001', 'Rajesh', 'Kumar', 'rajesh.kumar@example.com', '+91 12345 67890', 'Flat 101', 'Male', 'Shivaji Nagar', 'Delhi', 'Delhi', 110001, 4),
    ('t002', 'Priya', 'Sharma', 'priya.sharma@example.com', '+91 98765 43210', 'Apt 202', 'Female', 'Malviya Nagar', 'Mumbai', 'Maharashtra', 400001, 0),
    ('t003', 'Amit', 'Singh', 'amit.singh@example.com', '+91 55555 55555', 'Suite 303', 'Male', 'Rajwada', 'Bhopal', 'Madhya Pradesh', 462001, 0);

-- INSERT INTO 
select * from teaches;
select * from teachers; 
select * from users;
delete from users where user_id = 't005';
    
    
-- Create the 'classes' table
CREATE TABLE IF NOT EXISTS classes (
    class_id INT NOT NULL,
    class_name VARCHAR(30) NOT NULL,
    total_students INT DEFAULT 0,
    PRIMARY KEY(class_id,class_name)
);

drop table classes;
select * from classes;
INSERT INTO classes (class_id, class_name)
VALUES (1, 'I'),
       (2, 'II'),
       (3, 'III'),
       (4, 'IV'),
       (5, 'V'),
       (6, 'VI'),
       (7, 'VII'),
       (8, 'VIII');

insert into classes (class_id, class_name) values(0, 'No');

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
    state VARCHAR(50) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    result_percent DECIMAL(5, 2),
    result_status VARCHAR(10),
    tot_atten_percent DECIMAL(5, 2),
    FOREIGN KEY (student_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE ON UPDATE CASCADE
);

alter table students drop column pin_code;

INSERT INTO students (student_id, first_name, last_name, DOB, flat_no, colony, district, pin_code, class_id, state, gender, result_percent, result_status, tot_atten_percent)
VALUES
    ('s001', 'Aditya', 'Goyal', '2005-12-22', 'Flat 501', 'Vallabh Nagar', 'Indore', 452001, 4, 'Madhya Pradesh', 'Male', 0, '', 0),
    ('s002', 'Aditi', 'Solanki', '2005-06-20', 'Flat 502', 'Shivaji Nagar', 'Indore', 452002, 4, 'Madhya Pradesh', 'Female', 0, '', 0),
    ('s003', 'Aditya', 'Bajpai', '2005-07-25', 'Flat 503', 'Malviya Nagar', 'Indore', 452003, 4, 'Madhya Pradesh', 'Male', 0, '', 0),
    ('s004', 'Adeesh', 'Jain', '2005-08-30', 'Flat 504', 'Mhow Naka', 'Indore', 452004, 5, 'Madhya Pradesh','Female', 0, '', 0),
    ('s005', 'Anishiddh', 'Suryawanshi', '2005-09-05', 'Flat 505', 'Geeta Bhawan', 'Indore', 452005, 6, 'Madhya Pradesh','Male', 0, '', 0)
;
update students set class_id = '5' where student_id = 's004';
update students set class_id = '6' where student_id = 's005';

select * from teaches;

-- Create the 'parents' table'
CREATE TABLE IF NOT EXISTS parents (
	student_id VARCHAR(10) PRIMARY KEY,
    Father_name VARCHAR(30) NOT NULL,
    Mother_name VARCHAR(30) NOT NULL,
    phone_no VARCHAR(15) NOT NULL,
    email_id VARCHAR(30) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE ON UPDATE CASCADE
);

insert into parents(student_id, Father_name, Mother_name, phone_no, email_id) 
values ('s001', 'Rajendra Goyal', 'Manorama Goyal', '9943212341', 'rajendra@gmail.com'),
		('s003', 'Sanjay Bajpai', 'Seeta Bajpai', '9876543210', 'sanjay@gmail,com');



-- Create the 'subjects' table
CREATE TABLE IF NOT EXISTS subjects (
    subject_name VARCHAR(50) NOT NULL,
    class_id INT NOT NULL,
    PRIMARY KEY (subject_name, class_id),
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE ON UPDATE CASCADE
);

drop table subjects;
INSERT INTO subjects (class_id, subject_name)
VALUES (4, 'Maths'),
       (4, 'Science'),
       (4, 'Hindi'),
       (4, 'English'),
       (4, 'Social'),
       (5, 'Maths'),
       (5, 'Science'),
       (5, 'Hindi'),
       (5, 'English'),
       (5, 'Social'),
       (6, 'Maths'),
       (6, 'Science'),
       (6, 'Hindi'),
       (6, 'English'),
       (6, 'Social');
select * from subjects;

-- Create the 'teaches' table
CREATE TABLE IF NOT EXISTS teaches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_id VARCHAR(10) NOT NULL,
    class_id INT NOT NULL,
    subject_name VARCHAR(50) NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (subject_name) REFERENCES subjects(subject_name) ON DELETE CASCADE ON UPDATE CASCADE
);

desc teaches;
insert into teaches(teacher_id, class_id, subject_name) 
values ('t001', '4', 'English'),
		('t001', '5', 'English'),
        ('t001', '6', 'English'),
        ('t002', '4', 'Social'),
        ('t002', '6', 'Social'),
        ('t003', '4', 'Hindi'),
        ('t003','5','Hindi'),
        ('t003', '6', 'Hindi');
        
select * from teaches;




-- Create the 'marks' table
CREATE TABLE IF NOT EXISTS marks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id VARCHAR(10) NOT NULL,
    class_id INT NOT NULL,
    subject_name VARCHAR(50) NOT NULL,
    MST1 char(5) DEFAULT '',
    MST2 char(5) DEFAULT '',
    half_yearly char(5) DEFAULT '',
    MST3 char(5) DEFAULT '',
    MST4 char(5) DEFAULT '',
    annual char(5) DEFAULT '',
    percent char(5) DEFAULT '',
    grade char(5) DEFAULT 'C',
    remark char(10) DEFAULT 'PASS',
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (subject_name) REFERENCES subjects(subject_name) ON DELETE CASCADE ON UPDATE CASCADE
);
desc marks;

INSERT INTO marks (student_id, class_id, subject_name, MST1, MST2) VALUES
    ('s001', '4', 'Maths', 20, 20),
    ('s001', '4', 'Science', 20, 20),
    ('s001', '4', 'Hindi', 20, 20),
    ('s001', '4', 'English', 20, 20),
    ('s001', '4', 'Social', 20, 20),
    
    ('s002', '4', 'Maths', 15, 12),
	('s002', '4', 'Science', 15, 12),
	('s002', '4', 'Hindi', 15, 12),
	('s002', '4', 'English', 15, 12),
	('s002', '4', 'Social', 15, 12),
    
	('s003', '4', 'Maths', 15, 18),
	('s003', '4', 'Science', 15, 18),
	('s003', '4', 'Hindi', 15, 18),
	('s003', '4', 'English', 15, 18),
	('s003', '4', 'Social', 15, 18),
    
	('s004', '5', 'Maths', 18, 16),
	('s004', '5', 'Science', 18, 16),
	('s004', '5', 'Hindi', 18, 16),
	('s004', '5', 'English', 18, 16),
	('s004', '5', 'Social', 18, 16),
    
	('s005', '6', 'Maths', 20, 12),
	('s005', '6', 'Science', 20, 12),
	('s005', '6', 'Hindi', 20, 12),
	('s005', '6', 'English', 20, 12),
	('s005', '6', 'Social', 20, 12);
    
select * from marks;


-- Create the 'attendance' table
CREATE TABLE IF NOT EXISTS attendance (
    student_id VARCHAR(10) NOT NULL,
	class_id int,
    date varchar(10),
    flag char(5),
    primary key(student_id, date),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key (class_id) references classes(class_id) on delete cascade on update cascade
);
desc attendance;

insert into attendance(student_id, date, flag)
values 	('s001', '2023-09-22', '0'),
		('s001', '2023-09-23', '0'),
		('s001', '2023-09-24', '0'),
        
		('s002', '2023-09-22', '0'),
        ('s002', '2023-09-23', '1'),
        ('s002', '2023-09-24', '0'),
        
        ('s003', '2023-09-22', '0'),
        ('s003', '2023-09-23', '0'),
        ('s003', '2023-09-24', '0');
select * from attendance;


-- Create the 'announcements' table


-- Create a trigger to handle user deletions and set user_id to NULL in announcements
DELIMITER $$
CREATE TRIGGER `user_delete` BEFORE DELETE ON `users`
  FOR EACH ROW BEGIN
    UPDATE `announcements` SET `user_id` = NULL WHERE `user_id` = OLD.`user_id`;
  END $$
DELIMITER ;

SELECT t.class_id, t.subject_name, c.class_name FROM teaches t
JOIN classes c ON c.class_id = t.class_id
WHERE t.teacher_id = 't002' ;

SELECT t.class_teacher_flag, c.class_name from teachers t 
	JOIN classes c ON c.class_id = t.class_teacher_flag 
	WHERE t.teacher_id = 't002';
    
SELECT m.student_id, s.class_id, s.first_name, s.last_name, 
	m.MST1, m.MST2, m.half_yearly, 
    m.MST3, m.MST4, m.annual, 
    m.percent, m.grade, m.remark FROM marks m
    JOIN students s ON s.student_id = m.student_id
    WHERE s.class_id = 6 AND m.subject_name = 'Social';

select * from marks where class_id = 4;

select * from marks where student_id = 's001';
update marks set half_yearly = '100' where student_id = 's001';


select a.student_id, a.date, a.flag from attendance a
	where (select class_id from students where student_id = a.student_id) = '4'
		AND date in ('2023-09-22', '2023-09-23', '2023-09-24');



update attendance set flag = '1' where student_id = 's003' and date = '2023-09-23';

SELECT student_id, first_name, last_name, tot_atten_percent FROM students
            WHERE class_id = '4';

update marks set half_yearly = '100' where student_id = 's001' and subject_name = 'Maths';
select * from marks;
select * from marks;

use edupulse_2;


desc marks;
UPDATE marks SET MST1='15', MST2='12', half_yearly='', MST3='', MST4='', annual='', percent='', grade='C', remark='PASS' WHERE student_id ='s002' AND subject_name='Social';


select * from marks where subject_name='Social';

drop table marks;
CREATE TABLE IF NOT EXISTS marks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id VARCHAR(10) NOT NULL,
    class_id INT NOT NULL,
    subject_name VARCHAR(50) NOT NULL,
    MST1 int DEFAULT 0,
    MST2 int DEFAULT 0,
    half_yearly int DEFAULT 0,
    MST3 int DEFAULT 0,
    MST4 int DEFAULT 0,
    annual int DEFAULT 0,
    percent int DEFAULT 0,
    grade char(5) DEFAULT 'C',
    remark char(10) DEFAULT 'PASS',
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (subject_name) REFERENCES subjects(subject_name) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO marks (student_id, class_id, subject_name, MST1, MST2) VALUES
    ('s001', '4', 'Maths', 20, 20),
    ('s001', '4', 'Science', 20, 20),
    ('s001', '4', 'Hindi', 20, 20),
    ('s001', '4', 'English', 20, 20),
    ('s001', '4', 'Social', 20, 20),
    
    ('s002', '4', 'Maths', 15, 12),
	('s002', '4', 'Science', 15, 12),
	('s002', '4', 'Hindi', 15, 12),
	('s002', '4', 'English', 15, 12),
	('s002', '4', 'Social', 15, 12),
    
	('s003', '4', 'Maths', 15, 18),
	('s003', '4', 'Science', 15, 18),
	('s003', '4', 'Hindi', 15, 18),
	('s003', '4', 'English', 15, 18),
	('s003', '4', 'Social', 15, 18),
    
	('s004', '5', 'Maths', 18, 16),
	('s004', '5', 'Science', 18, 16),
	('s004', '5', 'Hindi', 18, 16),
	('s004', '5', 'English', 18, 16),
	('s004', '5', 'Social', 18, 16),
    
	('s005', '6', 'Maths', 20, 12),
	('s005', '6', 'Science', 20, 12),
	('s005', '6', 'Hindi', 20, 12),
	('s005', '6', 'English', 20, 12),
	('s005', '6', 'Social', 20, 12);
    

select * from marks where subject_name='English';

-- "UPDATE marks SET MST1=" + (element.MST1 || 0) + ", MST2=" + (element.MST2 || 0) + ", MST3=" + (element.MST3 || 0) + ", MST4=" + (element.MST4 || 0) + ", half_yearly=" + (element.half_yearly || 0) + ", annual=" + (element.annual || 0) + ", percent=" + (element.percent || 0) + ", grade='" + (element.grade || "'C'") + "', remark='" + (element.remark || "'PASS'") + "' WHERE student_id ='" + (element.student_id) + "' AND subject_name='" + (subject_name) +"';"

select * from marks where student_id='s001'; 

SELECT * FROM students s JOIN parents p ON p.student_id = s.student_id where s.student_id = 's001';
select * from attendance;


insert into attendance (student_id, class_id, date, flag)
values ('s001', '4', '2023-09-26', '0'),
		('s002', '4','2023-09-26', '0'),
        ('s003', '4','2023-09-26', '0'),
        ('s001', '4','2023-09-27', '1'),
        ('s002', '4','2023-09-27', '0'),
        ('s003', '4','2023-09-27', '0'),
        ('s001', '4','2023-09-28', '0'),
        ('s002', '4','2023-09-28', '1'),
        ('s003', '4','2023-09-28', '0');

select * from attendance;
delete from attendance;

select a.attendance_id, a.student_id, a.date, a.flag from attendance a where a.class_id = '4' and a.date like '2023-09-26' or '2023-09-27' or '2023-09-28';

select * from students where student_id = 's003';


INSERT INTO attendance (student_id, class_id, date, flag) 
VALUES ('s001', '4', '2023-09-26', '1') as alias
ON DUPLICATE KEY UPDATE 
flag = alias.flag;

select * from attendance;
select * from teachers;

update teachers set class_teacher_flag = 5 where teacher_id = 't003';
update attendance set flag = '1' where student_id = 's004';

INSERT INTO attendance (student_id, class_id, date, flag) 
VALUES ('s001', '4', '2023-10-05', '2');

CREATE TABLE IF NOT EXISTS announcements (
    ann_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(10),
    usertype VARCHAR(10),
    first_name VARCHAR(30) default '',
    last_name VARCHAR(30) default '',
    class_id varchar(5),
    subject_name varchar(20),
    date varchar(20) not null,
    title varchar(255) default '',
    content text,
    imgurl text,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE cascade ON UPDATE CASCADE
);

insert into announcements (user_id, usertype,first_name, last_name, class_id, subject_name, date, title, content, imgurl)
values ('a01', 'Admin', 'Aditya', 'Goyal','','', '2023-12-02', 'post1', 'First Post','');

select * from announcements where class_id = '' or class_id = (select class_id from students where student_id = 's001') order by date desc, user_id;
delete from announcements;

select * from announcements;
desc announcements;

SELECT a.student_id, a.class_id, a.date, a.flag FROM attendance a WHERE a.class_id = 4 AND (a.date =	 '2023-09-29' OR a.date = '2023-09-30' OR a.date = '2023-09-28');
alter table announcements modify date varchar(20);
delete from announcements where ann_id = 9;
select * from attendance where date like '2023-10%';

select * from students;
select * from marks;

select * from announcements order by title;
select * from announcements where title like "%post2%" or content like "%post2%";

select * from announcements where title like "%%" or content like "%%";
select * from announcements where user_id like "%a%";
select * from announcements where user_id like "%%%";

delete from announcements where user_id = 't002' limit 2;

select * from announcements where user_id like "%" and (title like "%%" or content like "%%" or first_name like "%%" or last_name like "%%" or subject_name like "%%" or class_id like "%%" or usertype like "%%") order by date desc, title desc;

SELECT * FROM students s JOIN parents p ON p.student_id = s.student_id WHERE s.student_id = 's002';
select * from parents;
select * from students;
insert into parents(student_id, Father_name, Mother_name, phone_no, email_id)
values ('s002', 'Father Solanki', 'Mother Solanki', '9876543210', 'solan.kii@gmail.com'),
		('s004', 'Father Jain', 'Mother Jain', '9876543210', 'jain.adeesh@gmail.com'),
        ('s005', 'Father Ani', 'Mother Ani', '9876543210', 'ani.shiddh@gmail.com');


select * from students;

SELECT * FROM announcements WHERE user_id like 'a%' and (title like '%%' or content like '%%' or first_name like '%%' or last_name like '%%' or subject_name like '%%' or class_id like '%%' or usertype like '%%') ORDER BY date desc, title, user_id;

use edupulse_2;
select * from announcements;

select * from (select ann_id, CONCAT(title, '|', content, '|', subject_name) txt from announcements) announcements
where txt like '%announcement%';

select * from announcements where '' in (user_id, usertype, first_name, last_name, class_id, subject_name, date, title, content, imgurl);

alter table announcements 
add fulltext(usertype, first_name, last_name, class_id, subject_name, date, title, content, imgurl);

select * from announcements;
desc announcements;

select * from announcements
where match(usertype, first_name, last_name, class_id, subject_name, date, title, content, imgurl)
against ('Admin');

select subject_name, class_id from subjects where class_id = (select class_id from students where student_id = 's001');

use edupulse_2;
-- Create the 'leaves' table
CREATE TABLE leaves (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(10) NOT NULL,
    class_id int,
    date_asked varchar(20) NOT NULL,
    date_from varchar(20) NOT NULL,
    date_to varchar(20) NOT NULL,
    subject text,
    reason text,
    accepted int default 0,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE ON UPDATE CASCADE
);

desc leaves;


insert into leaves(student_id, class_id, date_asked, date_from, date_to, subject, reason)
values ('s003', 4, '2023-10-07', '2023-10-09', '2023-10-10', 'e', 'fffffff');

select * from leaves;	
delete from leaves where id=10;

desc attendance;
update attendance set flag = '1' where student_id = 's003' and date ='2023-10-09';
delete from attendance where date='2023-10-09';
select * from attendance where date='2023-10-09';

delete from attendance limit 10;
use edupulse_2;
UPDATE leaves SET accepted = 1 WHERE id= 1;
select * from students where student_id = 's001';
SELECT l.*, s.* FROM leaves l JOIN students s ON s.student_id = l.student_id WHERE l.class_id = 4;

delete from announcements where ann_id=5;
select * from announcements;


delete from attendance limit 10;
select * from attendance where student_id='s001';
insert into attendance(student_id, class_id, date, flag)
values ('s001', 4, '2023-10-26', '2') as alias
ON DUPLICATE KEY UPDATE 
flag = alias.flag,
class_id=alias.class_id;

delete from attendance where date = '2023-10-26';
update attendance set flag = 0 where student_id='s001' and date = '2023-10-16';
update leaves set reason='ffffffffffffffffffffffffffffffffffffffffffffffffffffffffff' where date_asked='2023-10-07';

select * from attendance;
delete from leaves where id=13;
select * from leaves where id in (18,19,20);

delete from leaves where id in (2,3,143,'2%'); 

SELECT l.*, s.* FROM leaves l JOIN students s ON s.student_id = l.student_id WHERE l.class_id = 4;





















