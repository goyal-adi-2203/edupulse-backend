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
