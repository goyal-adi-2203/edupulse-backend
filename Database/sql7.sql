use edupulse;

CREATE TABLE IF NOT EXISTS users (
    user_id VARCHAR(10) PRIMARY KEY,
    password VARCHAR(256) NOT NULL,
    usertype VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(30) NOT NULL,
    total_students INT NOT NULL
);

CREATE TABLE IF NOT EXISTS students (
    student_id VARCHAR(10) PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    class_id INT NOT NULL,
    tot_atten_percent DECIMAL(5, 2),
    FOREIGN KEY (student_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE ON UPDATE CASCADE
);

create table attendance (
	attendance_id int auto_increment primary key,
    sid VARCHAR(10) NOT NULL,
    present int,
    absent int,
    percent decimal(5,2),
    `2023-09-01` char(2), 
    `2023-09-02` char(2), 
    `2023-09-03` char(2), 
    `2023-09-04` char(2), 
    `2023-09-05` char(2), 
    `2023-09-06` char(2), 
    `2023-09-07` char(2), 
    `2023-09-08` char(2), 
    `2023-09-09` char(2), 
    `2023-09-10` char(2), 
    `2023-09-11` char(2), 
    `2023-09-12` char(2), 
    `2023-09-13` char(2), 
    `2023-09-14` char(2), 
    `2023-09-15` char(2), 
    `2023-09-16` char(2), 
    `2023-09-17` char(2), 
    `2023-09-18` char(2), 
    `2023-09-19` char(2), 
    `2023-09-20` char(2), 
    `2023-09-21` char(2), 
    `2023-09-22` char(2), 
    `2023-09-23` char(2), 
    `2023-09-24` char(2), 
    `2023-09-25` char(2), 
    `2023-09-26` char(2), users
    `2023-09-27` char(2), 
    `2023-09-28` char(2), 
    `2023-09-29` char(2), 
    `2023-09-30` char(2),
    foreign key(sid) references students(student_id)
		on delete cascade
        on update cascade
);

desc users;
desc students;
desc classes;
desc attendance;

INSERT INTO users (user_id, password, usertype) VALUES
    ('a01', 'a01@edu', 'admin'),
    ('t001', 't001@edu', 'teacher'),
    ('s001', 's001@edu', 'student'),
    ('s002', 's002@edu', 'student'),
    ('s003', 's003@edu', 'student'),
    ('s004', 's004@edu', 'student'),
    ('s005', 's005@edu', 'student');

select * from users;

insert into students(student_id, first_name, last_name, class_id. tot_atten_percent) values;