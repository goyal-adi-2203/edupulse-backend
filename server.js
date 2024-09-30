import express from "express";
import mysql from "mysql2";
import bodyParser from "body-parser";
import cookieParser from "cookie-parser";
import cors from "cors";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";
import multer from "multer";
import { dirname } from "path";
import { fileURLToPath } from "url";

// const __dirname = dirname(fileURLToPath(import.meta.url));

const app = express();
dotenv.config();
const port = 4000;
app.use(cors());
// app.use(bodyParser.urlencoded({extended: true}));
app.use(cookieParser());
app.use(express.json());

// for pictures in announcements
const storage = multer.diskStorage({
	destination: function (req, file, cb) {
		cb(null, "../frontend/public/uploads");
	},

	filename: function (req, file, cb) {
		cb(null, Date.now() + file.originalname);
	},
});

const upload = multer({ storage: storage });

const secret = "drhftvgjbhjtstzdfhxcgjh";

const db = mysql.createConnection({
	host: "localhost",
	user: "root",
	password: "adi221203",
	database: "edupulse_2",
	multipleStatements: true,
});

function verifyToken(req, res, next) {
	const token = req.cookies.token; // Get the token from the cookie

	if (!token) {
		return res.status(401).json({ error: "Unauthorized" });
	}

	jwt.verify(token, secret, (err, decoded) => {
		if (err) {
			return res.status(401).json({ error: "Unauthorized" });
		}

		// You can access the user information from the decoded JWT payload
		const { username, userType } = decoded;

		// Add user information to the request object for later use
		req.user = { username, userType };

		// Continue with the next middleware or route handler
		next();
	});
}

db.connect((err) => {
	if (err) throw err;
	console.log("Connected to the MySQL database");
});

// poosting announcement
app.post("/api/upload", upload.single("file"), (req, res) => {
	const file = req.file;
	res.status(200).json({ Status: "Success", data: file.filename });
});

// Login
app.post("/login", async (req, res) => {
	const { username, password } = req.body;
	// console.log(username, password);

	const sql = "SELECT * FROM users Where user_id = ? and password = ?";
	db.query(sql, [req.body.username, req.body.password], (err, result) => {
		// console.log(result);
		if (err) return res.json({ Error: err });
		if (result.length > 0) {
			const userType = result[0].usertype;
			// console.log(username, userType);
			jwt.sign(
				{ username, password, userType },
				secret,
				{ expiresIn: "2h" },
				(err, token) => {
					if (err) throw err;
					return res.cookie("token", token).json({
						username,
						userType,
						token,
						Status: "Success",
					});
				}
			);
		} else {
			return res.json({
				Status: "Error",
				Error: ".     Wrong Credentials",
			});
		}
	});
});

app.post("/admin/:id/register", async (req, res) => {
	const check = (t) => {
		return t === undefined || t === "";
	};

	if (req.body.userType === "Teacher") {
		console.log(req.body);
		const {
			username,
			password,
			userType,
			First_name,
			Last_name,
			class1,
			class2,
			class3,
			subject1,
			subject2,
			subject3,
			class_teacher,
			mobile,
			flatno,
			colony,
			district,
			state,
			email,
			gender,
		} = req.body;
		const sql =
			"INSERT INTO users (user_id, password, usertype) VALUES ?; INSERT INTO teachers (teacher_id, first_name, last_name, email, phone_no, flat_no, gender, colony, district, state, class_teacher_flag) VALUES ?; INSERT INTO teaches (teacher_id,class_id,subject_name) VALUES ?;";
		var values1 = [[username, password, userType]];
		var values2 = [
			[
				username,
				First_name,
				Last_name,
				email,
				mobile,
				flatno,
				gender,
				colony,
				district,
				state,
				class_teacher,
			],
		];
		var values3 = [[username, class1, subject1]];
		if (check(class2) && check(class3)) {
			values3 = [[username, class1, subject1]];
		} else if (check(class3)) {
			values3 = [
				[username, class1, subject1],
				[username, class2, subject2],
			];
		} else {
			values3 = [
				[username, class1, subject1],
				[username, class2, subject2],
				[username, class3, subject3],
			];
		}
		// console.log(class2);
		// console.log(values1);
		// console.log(values2);

		db.query(sql, [values1, values2, values3], (err, result) => {
			if (err) return res.json({ Error: "Error in Storing", err });
			return res.status(200).json({ Status: "Success", result });
		});
	} else if (req.body.userType === "Student") {
		const {
			username,
			password,
			userType,
			First_name,
			Last_name,
			student_class,
			mobile,
			flatno,
			colony,
			district,
			state,
			email,
			gender,
			Father_name,
			Mother_name,
		} = req.body;

		const sql =
			"INSERT INTO users (user_id, password, usertype) VALUES ?; INSERT INTO students (student_id, first_name, last_name, flat_no, colony, district, class_id, state, gender) VALUES ?; INSERT INTO parents (student_id, Father_name, Mother_name, phone_no, email_id) VALUES ?; SELECT subject_name from subjects where class_id= ?";
		var values1 = [[username, password, userType]];
		var values2 = [
			[
				username,
				First_name,
				Last_name,
				flatno,
				colony,
				district,
				student_class,
				state,
				gender,
			],
		];
		var data = [];
		var values3 = [[username, Father_name, Mother_name, mobile, email]];
		const sql2 =
			"INSERT INTO marks (student_id, class_id, subject_name) VALUES ?";
		db.query(
			sql,
			[values1, values2, values3, student_class],
			(err, result) => {
				if (err)
					return res
						.status(500)
						.json({ Error: "Error in Storing", err });
				const sub1 = result[3][0].subject_name;
				const sub2 = result[3][1].subject_name;
				const sub3 = result[3][2].subject_name;
				const sub4 = result[3][3].subject_name;
				const sub5 = result[3][4].subject_name;
				var values4 = [
					[username, student_class, sub1],
					[username, student_class, sub2],
					[username, student_class, sub3],
					[username, student_class, sub4],
					[username, student_class, sub5],
				];
				db.query(sql2, [values4], (err2, result2) => {
					if (err2) console.log(err2);
				});

				return res.status(200).json({ Status: "Success", result });
			}
		);
	}
});

// app.get("/teacher/dashboard/:id", verifyToken, async (req, res) => {
//   let tokenHeaderKey = process.env.TOKEN_HEADER_KEY;
//   let jwtSecretKey = process.env.JWT_SECRET_KEY;
//   try {
//     const token = req.header(tokenHeaderKey);
//     const verified = jwt.verify(token, jwtSecretKey);
//     if (verified) {
//       console.log("HELIIIIIIIIII");
//       return res.send("Successfully Verified");
//     } else {
//       return res.status(401).send(error);
//     }
//   } catch (error) {
//     return res.status(401).send(error);
//   }
// });

app.get("/adminCount", (req, res) => {
	const sql =
		"Select count(user_id) as admin from users where usertype = 'Admin'";
	db.query(sql, (err, result) => {
		if (err) return res.json({ Error: "Error in runnig query" });
		return res.json(result);
	});
});

app.get("/teacherCount", (req, res) => {
	const sql =
		"Select count(user_id) as teacher from users where usertype = 'Teacher'";
	db.query(sql, (err, result) => {
		if (err) return res.json({ Error: "Error in runnig query" });
		return res.json(result);
	});
});

app.get("/studentCount", (req, res) => {
	const sql =
		"SELECT COUNT(user_id) AS student FROM users WHERE usertype = 'Student'";
	db.query(sql, (err, result) => {
		if (err) return res.json({ Error: "Error in runnig query" });
		return res.json(result);
	});
});

app.post("/getData", (req, res) => {
	const user_id = req.body.user_id;
	const userType = req.body.userType;
	// console.log(req.body);

	if (userType == "Student") {
		// console.log("student");
		db.query(
			"SELECT * FROM students s JOIN parents p ON p.student_id = s.student_id WHERE s.student_id = ?;",
			[user_id],
			(err, result) => {
				// console.log(result);
				if (err) return res.json({ Error: err });
				if (result.length > 0) {
					// console.log(result);
					return res.json({ Status: "Success", data: result });
				} else {
					return res.json({ Status: "Error", Error: "No Details" });
				}
			}
		);
	} else if (userType == "Admin") {
		db.query(
			"SELECT * FROM admin WHERE admin_id = ?;",
			[user_id],
			(err, result) => {
				if (err) return res.json({ Error: err });
				if (result.length > 0) {
					// console.log(result);
					return res.json({ Status: "Success", data: result });
				} else {
					return res.json({ Status: "Error", Error: "No Details" });
				}
			}
		);
	} else if (userType == "Teacher") {
		db.query(
			"SELECT * FROM teachers WHERE teacher_id = ?;",
			[user_id],
			(err, result) => {
				if (err) return res.json({ Error: err });
				if (result.length > 0) {
					// console.log(result);
					return res.json({ Status: "Success", data: result });
				} else {
					return res.json({ Status: "Error", Error: "No Details" });
				}
			}
		);
	}
});

// POSTing to SidePanel
// API to sent classes for a teacher and
// to send classTeacher flag for the teacher
app.post("/teacher/getClasses", (req, res) => {
	const { user_id, userType } = { ...req.body };
	// console.log(req.body);

	// to send classes
	const q1 =
		"SELECT t.class_id, t.subject_name, c.class_name FROM teaches t JOIN classes c ON c.class_id = t.class_id WHERE t.teacher_id = ? ";

	// send class teacher flag
	const q2 =
		"SELECT t.class_teacher_flag, c.class_name from teachers t \
            JOIN classes c ON c.class_id = t.class_teacher_flag \
            WHERE t.teacher_id = ?";

	const sql = q1 + ";" + q2 + ";";

	db.query(sql, [req.body.user_id, req.body.user_id], (err, result) => {
		// console.log(result);

		if (err) return res.json({ Error: err });
		if (result.length > 0) {
			// console.log(result.length);
			return res.json({ Status: "Success", data: result });
		} else {
			return res.json({ Status: "Error", Error: "No Details" });
		}
	});
});

// POSTing to updateMarks
// API to send students who belong to that class
app.post("/teacher/getStudentDataMark", (req, res) => {
	// const { user_id, userType, class_id, subject_name } = {...req.body};
	// console.log(req.body);
	// to get marks
	const q1 =
		"SELECT m.student_id, s.class_id, s.first_name, s.last_name, m.MST1, m.MST2, \
        m.half_yearly, m.MST3, m.MST4, m.annual, m.percent, m.grade, m.remark FROM marks m \
        JOIN students s ON s.student_id = m.student_id \
        WHERE s.class_id = ? AND m.subject_name = ?; ";

	db.query(q1, [req.body.class_id, req.body.subject_name], (err, result) => {
		// console.log(result);

		if (err) return res.json({ Error: err });
		if (result.length > 0) {
			// console.log(result);
			return res.json({ Status: "Success", data: result });
		} else {
			console.log(result, "error");
			return res.json({ Status: "Error", Error: "No Details" });
		}
	});
});

// POSTing to updateMarks
// API to update Marks
app.post("/teacher/studentUpdateMarks", (req, res) => {
	// console.log(req.body.studentData);

	const studentData = req.body.studentData;
	const subject_name = req.body.subject_name.subject_name;
	const class_id = req.body.subject_name.class_id;
	// console.log(studentData.subject_name);
	// console.log(req.body.subject_name);
	var sql = "";

	studentData.forEach((element) => {
		const q1 =
			"UPDATE marks SET MST1=" +
			(element.MST1 || 0) +
			", MST2=" +
			(element.MST2 || 0) +
			", MST3=" +
			(element.MST3 || 0) +
			", MST4=" +
			(element.MST4 || 0) +
			", half_yearly=" +
			(element.half_yearly || 0) +
			", annual=" +
			(element.annual || 0) +
			", percent=" +
			(element.percent || 0) +
			", grade='" +
			(element.grade || "'C'") +
			"', remark='" +
			(element.remark || "'PASS'") +
			"' WHERE student_id ='" +
			element.student_id +
			"' AND subject_name='" +
			subject_name +
			"';";

		// console.log(q1,"\n");
		sql += q1;
	});

	// console.log(sql);

	db.query(sql, (err, result) => {
		// console.log(result);

		if (err) return res.json({ Error: err });
		return res.json({ Status: "Success", data: result });
	});
});

// POSTing to updateAttendance
// API to send students who belong to that class
app.post("/teacher/getAttendanceData", (req, res) => {
	// const { user_id, userType, class_id, subject_name } = {...req.body};
	// console.log(req.body, "nope");
	const date = [...req.body.dates];
	// console.log(date);

	const q1 =
		"SELECT a.student_id, a.class_id, a.date, a.flag FROM attendance a WHERE a.class_id = ? AND (a.date = ? OR a.date = ? OR a.date = ? OR a.date = ? OR a.date = ?);";

	db.query(
		q1,
		[
			req.body.class_id,
			date[0].date,
			date[1].date,
			date[2].date,
			date[3].date,
			date[4].date,
		],
		(err, result) => {
			// console.log(result);

			if (err) return res.json({ Error: err });
			return res.json({ Status: "Success", data: result });
		}
	);
});

// fetching students list for attendance
app.post("/teacher/getStudentDataAttendance", (req, res) => {
	// console.log(req.body);
	const q1 =
		"SELECT student_id, first_name, last_name, tot_atten_percent FROM students\
            WHERE class_id = ?;";

	db.query(q1, [req.body.class_id], (err, result) => {
		if (err) return res.json({ Error: err });
		if (result.length > 0) {
			// console.log(result);
			return res.json({ Status: "Success", data: result });
		} else {
			// console.log(result, "error");
			return res.json({ Status: "Error", Error: "No Details" });
		}
	});
});

// updating attendance of students
// to updateAttendance.js
app.post("/teacher/updateAttendance", (req, res) => {
	// console.log(req.body);
	const class_id = req.body.class_id;
	const attendance = req.body.attendanceRecord;

	// console.log(attendance);

	var sql = "";
	attendance.forEach((ele) => {
		const q1 =
			"INSERT INTO attendance(student_id, class_id, date, flag) \
            VALUES('" +
			ele.student_id +
			"'," +
			class_id +
			" ,'" +
			ele.date +
			"','" +
			ele.flag +
			"') AS alias\
            ON DUPLICATE KEY UPDATE \
            flag = alias.flag;";

		// console.log(q1);
		sql += q1;
		// console.log(sql);
	});

	db.query(sql, (err, result) => {
		// console.log(result);

		if (err) return res.json({ Error: err });
		return res.json({ Status: "Success", data: result });
	});
});

// POSTing to viewMarks
// API to send marks of student
app.post("/student/getMarks", (req, res) => {
	const q1 = "SELECT * FROM marks WHERE student_id = ?;";
	// console.log(req.body.user_id);
	db.query(q1, [req.body.user_id], (err, result) => {
		if (err) return res.json({ Error: err });
		if (result.length > 0)
			return res.json({ Status: "Success", data: result });
		else return res.json({ Status: "Error", Error: "No Details" });
	});
});

// fetching attendance data for students calenders
// to View Attendance
app.post("/student/getAttendance", (req, res) => {
	// console.log(req.body);
	const q1 = "SELECT * FROM attendance WHERE student_id = ?";
	db.query(q1, [req.body.student_id], (err, result) => {
		if (err) return res.json({ Error: err });
		if (result.length > 0)
			return res.json({ Status: "Success", data: result });
		else return res.json({ Status: "Error", Error: "No Details" });
	});
});

// add announcements
app.post("/addAnnouncement", (req, res) => {
	// console.log(req.body);
	const values = req.body;

	const q1 =
		"INSERT INTO announcements (user_id, usertype, first_name, last_name, class_id, subject_name, date, title, content, imgurl) VALUES (?); ";

	db.query(q1, [values], (err, result) => {
		// console.log(result, "dvfbdgnhjmhkjl");
		if (err) return res.json({ Error: err });
		return res.json({ Status: "Success", data: result });
	});
});

// getching announcements for admin
// AdminAnns.js
app.post("/admin/getAnnouncements", (req, res) => {
	// console.log(req.body);
	const user_id = req.body.user_id;
	const userType = req.body.userType;

	db.query(
		"SELECT * FROM announcements ORDER BY date DESC, user_id;",
		(err, result) => {
			// console.log(result);

			if (err) return res.status(404).json({ Error: err });
			return res.status(200).json({ Status: "Success", data: result });
		}
	);
});

// getching announcements for admin
// TeacherAnns.js
app.post("/teacher/getAnnouncements", (req, res) => {
	// console.log(req.body);
	const user_id = req.body.user_id;
	const userType = req.body.userType;

	db.query(
		"SELECT * FROM announcements ORDER BY date DESC, user_id;",
		(err, result) => {
			// console.log(result);

			if (err) return res.status(404).json({ Error: err });
			return res.status(200).json({ Status: "Success", data: result });
		}
	);
});

// getching announcements for admin
// StudentAnns.js
app.post("/student/getAnnouncements", (req, res) => {
	// console.log(req.body);
	const user_id = req.body.user_id;
	const userType = req.body.userType;

	db.query(
		"select * from announcements where class_id = '' or class_id = (select class_id from students where student_id = ?) order by date desc, user_id;",
		[user_id],
		(err, result) => {
			// console.log(result);

			if (err) return res.status(404).json({ Error: err });
			return res.status(200).json({ Status: "Success", data: result });
		}
	);
});

// // search keyword
// app.post("/searchKeyword", (req, res) => {
//     // console.log(req.body[0]);
//     var word = req.body[0];

//     var q1 = "SELECT * FROM announcements WHERE (title like '%" + word + "%' or content like '%" + word + "%' or first_name like '%" + word + "%' or last_name like '%" + word + "%' or subject_name like '%" + word + "%' or class_id like '%" + word + "%' or usertype like '%" + word + "%') ORDER BY date desc, user_id;"

//     db.query(q1, (err, result) => {
//         console.log(err);
//         if (err) return res.status(404).json({ Error: err });
//         return res.status(200).json({ Status: "Success", data: result });
//     })
// });

app.post("/student/getSubjects", (req, res) => {
	const user_id = req.body.user_id;
	// console.log(user_id);
	db.query(
		"SELECT subject_name FROM subjects WHERE class_id = (SELECT class_id FROM students WHERE student_id = ?);",
		[user_id],
		(err, result) => {
			// console.log(result);
			if (err) return res.json({ Error: err });
			return res.json({ Status: "Success", data: result });
		}
	);
});

// get class of student
app.post("/student/getClass", (req, res) => {
	const user_id = req.body.user_id;

	db.query(
		"SELECT class_id FROM students WHERE student_id = ?",
		[user_id],
		(err, result) => {
			if (err) return res.json({ Error: err });
			return res.json({ Status: "Success", data: result });
		}
	);
});

// apply for leave for student
app.post("/student/applyLeave", (req, res) => {
	// console.log(req.body);

	const values = [
		req.body.user_id,
		req.body.class_id,
		req.body.today,
		req.body.startdate,
		req.body.enddate,
		req.body.subject,
		req.body.reason,
	];

	db.query(
		"INSERT INTO leaves (student_id, class_id, date_asked, date_from, date_to, subject, reason) VALUES (?);",
		[values],
		(err, result) => {
			if (err) return res.json({ Error: err });
			return res.json({ Status: "Success" });
		}
	);
});

// getting the leave reqs for the teacher of her class
app.post("/teacher/getLeaveReqs", (req, res) => {
	// console.log(req.body);

	const q1 =
		"SELECT l.*, s.* FROM leaves l JOIN students s ON s.student_id = l.student_id WHERE l.class_id = ? ORDER BY l.date_asked DESC, l.student_id;";

	db.query(q1, [req.body.class_id], (err, result) => {
		// console.log(result);

		if (err) return res.json({ Error: err });
		return res.json({ Status: "Success", data: result });
	});
});

// accepting or denying leave
app.post("/teacher/leaveAccept", (req, res) => {
	// console.log(req.body);
	const student_id = req.body.student_id;
	const class_id = req.body.class_id;
	const date_from = req.body.date_from;
	const date_to = req.body.date_to;
	const flag = req.body.accepted === 1 ? "2" : "1";
	// console.log(flag);

	const q1 = "UPDATE leaves SET accepted = ? WHERE id= ?;";
	var sql = q1;

	const startDate = new Date(date_from);
	const endDate = new Date(date_to);

	let currentDate = startDate;

	function formatDate(date) {
		const year = date.getFullYear();
		const month = String(date.getMonth() + 1).padStart(2, "0");
		const day = String(date.getDate()).padStart(2, "0");
		return `${year}-${month}-${day}`;
	}

	for (
		;
		currentDate <= endDate;
		currentDate.setDate(currentDate.getDate() + 1)
	) {
		const formattedDate = formatDate(currentDate);

		const q2 =
			"INSERT INTO attendance(student_id, class_id, date, flag) \
                VALUES('" +
			student_id +
			"'," +
			class_id +
			" ,'" +
			formattedDate +
			"','" +
			flag +
			"') AS alias\
                ON DUPLICATE KEY UPDATE \
                flag = alias.flag;";

		// console.log(q2);
		sql += q2;
	}

	db.query(sql, [req.body.accepted, req.body.id], (err, result) => {
		if (err) return res.json({ Error: err });
		return res.json({ Status: "Success" });
	});
});

// deleting leaves
app.post("/teacher/deleteLeaves", (req, res) => {
	// console.log(req.body.dltReqArr);
	const dltId = req.body.dltReqArr;

	db.query(`DELETE FROM leaves WHERE id IN (${dltId})`, (err, result) => {
		// console.log(result);
		if (err) return res.json({ Error: err });
		else if (result.affectedRows !== dltId.length)
			return res.json({
				Status: "Error",
				Error: "Incorrect Indices",
				data: result,
			});
		else return res.json({ Status: "Success", data: result });
	});
});

// fetching leave reqs for attendance
// app.post("/teacher/getLeaves", (req, res) => {
//     const q1 =
//         "SELECT id, student_id, class_id, date_from, date_to, accepted FROM leaves WHERE class_id=? AND accepted=1;"

//     db.query(q1, [req.body.class_id], (err, result) => {
//         // console.log(result);
//         if (err) return res.json({ Error: err });
//         return res.json({ Status: "Success", data: result });
//     });
// });

// setting flag to 2 when on leave
// app.post("/teacher/enterLeaveAttendance", (req, res) => {
//     // console.log(req.body);

//     const values = [
//         req.body.student_id,
//         req.body.class_id,
//         req.body.date,
//         req.body.flag
//     ];

//     const q1 =
//         "INSERT INTO attendance(student_id, class_id, date, flag) \
//         VALUES(?) AS alias\
//         ON DUPLICATE KEY UPDATE \
//         flag = alias.flag;";

//     // console.log(values);
//     db.query(q1, [values], (err, result) => {
//         if (err) return res.json({ Error: err });
//         return res.json({ Status: "Success"});
//     });
// });

app.get("/getTeacher", (req, res) => {
	const sql = "SELECT * FROM teachers";
	db.query(sql, (err, result) => {
		if (err) return res.json({ Error: "Get teacher error in sql" });
		return res.json({ Status: "Success", Result: result });
	});
});

app.get("/get/:teacher_id", (req, res) => {
	const teacher_id = req.params.teacher_id;
	const sql = "SELECT * FROM teachers WHERE teacher_id = ?";
	db.query(sql, [teacher_id], (err, result) => {
		if (err) return res.json({ Error: "Get teacher error in SQL" });
		return res.json({ Status: "Success", Result: result });
	});
});

// app.put('/update/:teacher_id', (req, res) => {
//   const teacher_id = req.params.teacher_id;
//   // const { name, email, address } = req.body;
//   const sql = "UPDATE teachers SET email = ? WHERE teacher_id = ?";
//   db.query(sql, [req.body.email,teacher_id], (err, result) => {
//     if (err) {
//       return res.json({ Error: "Update teacher error in SQL" });
//     }
//     return res.json({ Status: "Success" });
//   });
// });
app.put("/update/:teacher_id", (req, res) => {
	const teacher_id = req.params.teacher_id;
	// console.log(req.body);
	const {
		first_name,
		last_name,
		email,
		phone_no,
		gender,
		colony,
		flat_no,
		district,
	} = req.body;

	// console.log(req.body);

	const sql =
		"UPDATE teachers SET first_name = ?, last_name = ?, email = ?, phone_no = ?, gender = ?, colony = ?, district = ?, flat_no = ? WHERE teacher_id = ?";
	db.query(
		sql,
		[
			first_name,
			last_name,
			email,
			phone_no,
			gender,
			colony,
			district,
			flat_no,
			teacher_id,
		],
		(err, result) => {
			if (err) {
				return res.json({ Error: "Update teacher error in SQL" });
			}
			return res.json({ Status: "Success" });
		}
	);
});

app.delete("/delete/:teacher_id", (req, res) => {
	const teacher_id = req.params.teacher_id;
	const sql = "Delete FROM users WHERE user_id = ?";
	db.query(sql, [teacher_id], (err, result) => {
		if (err) return res.json({ Error: "delete teacher error in sql" });
		return res.json({ Status: "Success" });
	});
});

app.get("/getStudent", (req, res) => {
	const sql = "SELECT * FROM students";
	db.query(sql, (err, result) => {
		if (err) return res.json({ Error: "Get student error in sql" });
		return res.json({ Status: "Success", Result: result });
	});
});

app.get("/getStu/:student_id", (req, res) => {
	const student_id = req.params.student_id;
	const sql = "SELECT * FROM students WHERE student_id = ?";
	db.query(sql, [student_id], (err, result) => {
		if (err) return res.json({ Error: "Get student error in SQL" });
		return res.json({ Status: "Success", Result: result });
	});
	// db.query(sql, [student_id], (err, result) => {
	//   if (err) {
	//     console.error(err);
	//     return res.json({ Error: "Database error: " + err.message });
	//   }
	//   if (result.length === 0) {
	//     return res.json({ Error: "Student not found....." });
	//   }
	//   return res.json({ Status: "Success", Result: result });
	// });
});

app.put("/updateStu/:student_id", (req, res) => {
	const student_id = req.params.student_id;
	const { first_name, last_name, flat_no, district, gender, address } =
		req.body;
	const sql =
		"UPDATE students SET first_name = ?, last_name = ?, flat_no = ?, district = ?,  gender = ?, colony = ? WHERE student_id = ?";
	db.query(
		sql,
		[first_name, last_name, flat_no, district, gender, address, student_id],
		(err, result) => {
			if (err) {
				return res.json({ Error: "Update student error in SQL" });
			}
			return res.json({ Status: "Success" });
		}
	);
});

app.delete("/deleteStu/:student_id", (req, res) => {
	const student_id = req.params.student_id;
	const sql = "Delete FROM users WHERE user_id = ?";
	db.query(sql, [student_id], (err, result) => {
		if (err) return res.json({ Error: "delete student error in sql" });
		return res.json({ Status: "Success" });
	});
});

// delete announcement
app.delete(`/deleteAnnouncement/:id`, (req, res) => {
	const sql = "DELETE FROM announcements WHERE ann_id=?;";
	// console.log(req.params.id);

	db.query(sql, [req.params.id], (err, result) => {
		if (err) return res.json({ Error: "DELETE ERROR" });
		// console.log(result);
		return res.json({ Status: "Success" });
	});

	// return res.json({Status: "Success"});
});

app.listen(port, () => {
	console.log(`Server is running on port ${port}`);
});
