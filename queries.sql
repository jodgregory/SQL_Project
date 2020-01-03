CREATE TABLE `courses` (
  `courses_course_id` int(11) NOT NULL AUTO_INCREMENT,
  `courses_name` varchar(45) NOT NULL,
  PRIMARY KEY (`courses_course_id`),
  UNIQUE KEY `courses_id_UNIQUE` (`courses_course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `grades` (
  `grades_id` int(11) NOT NULL AUTO_INCREMENT,
  `grades_grade` decimal(10,0) NOT NULL,
  `grades_student_id` int(11) NOT NULL,
  `grades_employee_id` int(11) NOT NULL,
  `grades_course_id` int(11) NOT NULL,
  PRIMARY KEY (`grades_id`),
  UNIQUE KEY `grades_id_UNIQUE` (`grades_id`),
  KEY `grades_course_id_idx` (`grades_course_id`),
  KEY `grades_employee_id_idx` (`grades_employee_id`),
  KEY `grades_student_id_idx` (`grades_student_id`),
  CONSTRAINT `grades_course_id` FOREIGN KEY (`grades_course_id`) REFERENCES `courses` (`courses_course_id`),
  CONSTRAINT `grades_employee_id` FOREIGN KEY (`grades_employee_id`) REFERENCES `professors` (`professors_employee_id`),
  CONSTRAINT `grades_student_id` FOREIGN KEY (`grades_student_id`) REFERENCES `students` (`students_student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `professors` (
  `professors_employee_id` int(11) NOT NULL AUTO_INCREMENT,
  `professors_name` varchar(45) NOT NULL,
  PRIMARY KEY (`professors_employee_id`),
  UNIQUE KEY `professors_id_UNIQUE` (`professors_employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `students` (
  `students_student_id` int(11) NOT NULL AUTO_INCREMENT,
  `students_name` varchar(45) NOT NULL,
  PRIMARY KEY (`students_student_id`),
  UNIQUE KEY `students_student_id_UNIQUE` (`students_student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

-- Add records

USE school1;

INSERT INTO courses(courses_name)
VALUES ('Digital Lit');

INSERT INTO courses(courses_name)
VALUES ('Creative Coding');

INSERT INTO courses(courses_name)
VALUES ('Exploring Computer Science');

INSERT INTO courses(courses_name)
VALUES ('Keyboarding');

SELECT *
FROM courses;

INSERT INTO students(students_name)
VALUES ('Jodi');

INSERT INTO students(students_name)
VALUES ('Jo');

INSERT INTO students(students_name)
VALUES ('Trent');

INSERT INTO students(students_name)
VALUES ('Darin');

INSERT INTO students(students_name)
VALUES ('Kortni');

INSERT INTO students(students_name)
VALUES ('Conner');

SELECT *
FROM students;


INSERT INTO professors(professors_name)
VALUES ('Jensen');
INSERT INTO professors(professors_name)
VALUES ('Gregory');
INSERT INTO professors(professors_name)
VALUES ('Saviano');
INSERT INTO professors(professors_name)
VALUES ('Atkins');

SELECT *
FROM professors;

INSERT INTO grades(grades_student_id, grades_course_id, grades_employee_id, grades_grade)
VALUES(1, 1, 1, 90);

INSERT INTO grades(grades_student_id, grades_course_id, grades_employee_id, grades_grade)
VALUES(2, 2, 2, 80);

INSERT INTO grades(grades_student_id, grades_course_id, grades_employee_id, grades_grade)
VALUES(3, 3, 3, 90);

INSERT INTO grades(grades_student_id, grades_course_id, grades_employee_id, grades_grade)
VALUES(4, 4, 4, 85);

INSERT INTO grades(grades_student_id, grades_course_id, grades_employee_id, grades_grade)
VALUES(5, 1, 1, 92);

INSERT INTO grades(grades_student_id, grades_course_id, grades_employee_id, grades_grade)
VALUES(6, 1, 1, 75);

INSERT INTO grades(grades_student_id, grades_course_id, grades_employee_id, grades_grade)
VALUES(1, 2, 2, 85);

INSERT INTO grades(grades_student_id, grades_course_id, grades_employee_id, grades_grade)
VALUES(1, 1, 1, 100);

INSERT INTO grades(grades_student_id, grades_course_id, grades_employee_id, grades_grade)
VALUES(2, 2, 1, 90);

INSERT INTO grades(grades_student_id, grades_course_id, grades_employee_id, grades_grade)
VALUES(2, 2, 2, 80);

INSERT INTO grades(grades_student_id, grades_course_id, grades_employee_id, grades_grade)
VALUES(3, 2, 2, 80);

INSERT INTO grades(grades_student_id, grades_course_id, grades_employee_id, grades_grade)
VALUES(3, 3, 2, 80);

INSERT INTO grades(grades_student_id, grades_course_id, grades_employee_id, grades_grade)
VALUES(3, 4, 2, 75);

INSERT INTO grades(grades_student_id, grades_course_id, grades_employee_id, grades_grade)
VALUES(3, 1, 2, 75);

SELECT *
FROM grades;

USE school1;

-- Finds the average grade given by each professor

SELECT professors_name AS 'Professor Name', AVG(grades_grade) AS 'Average Grade', professors_employee_id AS 'ID'
FROM grades
JOIN professors
ON grades.grades_employee_id = professors.professors_employee_id
GROUP BY grades_employee_id;

-- The top grades for each student
USE school1;

SELECT students_name as 'Name', MAX(grades_grade) AS 'Top Grade'
FROM grades
JOIN students
ON grades.grades_student_id = students.students_student_id
GROUP BY students.students_name;


-- Group students by the courses that they are enrolled in 
USE school1;

SELECT grades_course_id AS 'Course ID', students_name AS 'Name', courses_name AS 'Coures Name'
FROM grades g
JOIN students s
ON g.grades_student_id = s.students_student_id
JOIN courses c
ON g.grades_course_id = c.courses_course_id
ORDER BY grades_course_id ASC;

-- Create a summary report of courses and their average grades, sorted by the most challenging course 
-- (course with the lowest average grade) to the easiest course

USE schools;

SELECT courses_name AS 'Course Name', AVG(grades_grade) AS 'Average Grade'
FROM grades
JOIN courses
ON grades.grades_course_id = courses.courses_course_id
GROUP BY grades.grades_course_id
ORDER BY AVG(grades_grade) ASC;

-- Finding which student and professor have the most courses in common

USE school1;

SELECT grades_student_id AS 'Student', grades_employee_id AS 'Professor', COUNT(*) AS Course
FROM grades g
JOIN students s
ON g.grades_student_id = s.students_student_id
JOIN professors p
ON g.grades_employee_id = p.professors_employee_id
JOIN courses c 
ON g.grades_course_id = c.courses_course_id
GROUP BY grades_employee_id, grades_student_id
ORDER BY Course DESC;
