DROP DATABASE IF EXISTS companyHR2;
CREATE DATABASE companyHR2;
USE companyHR2;

DROP TABLE IF EXISTS co_employees2;
CREATE TABLE co_employees2 (
  id INT PRIMARY KEY AUTO_INCREMENT,
  em_name VARCHAR(225) NOT NULL,
  gender CHAR(1) NOT NULL,
  contact_number VARCHAR(225),
  salary INT NOT NULL,
  year_in_company INT NOT NULL
);

DROP TABLE IF EXISTS mentorships;
CREATE TABLE mentorships (
  mentor_id INT NOT NULL,
  mentee_id INT NOT NULL,
  status VARCHAR(255) NOT NULL,
  project VARCHAR(255) NOT NULL,
  PRIMARY KEY(mentor_id, mentee_id, project),
  CONSTRAINT fk1 FOREIGN KEY(mentor_id) REFERENCES co_employees2(id) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT fk2 FOREIGN KEY(mentee_id) REFERENCES co_employees2(id) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT mm_constraint UNIQUE(mentor_id, mentee_id)
);
SHOW CREATE TABLE co_employees2;
ALTER TABLE mentorships DROP FOREIGN KEY fk1;
ALTER TABLE mentorships DROP FOREIGN KEY fk2;
/* Alter Table Commands
ALTER TABLE co_employees
DROP COLUMN age,
#RENAME TABLE mentorships TO mentorship,
ADD COLUMN salary FLOAT NOT NULL AFTER contact_number,
ADD COLUMN years_in_company INT NOT NULL AFTER salary;
*/

CREATE TABLE ex_employees (
em_id INT PRIMARY KEY,
em_name VARCHAR(255) NOT NULL,
gender CHAR(1) NOT NULL,
date_left TIMESTAMP DEFAULT NOW()
);

INSERT INTO co_employees2 (em_name, gender, contact_number, salary, year_in_company) VALUES
('James Lee', 'M', '516-514-6568', 3500, 11),
('Peter Pasternak', 'M', '845-644-7919', 6010, 10),
('Clara Couto', 'F', '845-641-5236', 3900, 8),
('Walker Welch', 'M', NULL, 2500, 4),
('Li Xiao Ting', 'F', '646-218-7733', 5600, 4),
('Joyce Jones', 'F', '523-172-2191', 8000, 3),
('Jason Cerrone', 'M', '725-441-7172', 7980, 2),
('Prudence Phelps', 'F', '546-312-5112', 11000, 2),
('Larry Zucker', 'M', '817-267-9799', 3500, 1),
('Serena Parker', 'F', '621-211-7342', 12000, 1);

INSERT INTO mentorships VALUES
(1, 2, 'Ongoing', 'SQF Limited'),
(1, 3, 'Past', 'Wayne Fibre'), 
(2, 3, 'Ongoing', 'SQF Limited'),
(3, 4, 'Ongoing', 'SQF Limited'),
(6, 5, 'Past', 'Flynn Tech');

UPDATE co_employees2
SET contact_number = '516-514-1729'
WHERE id = 1;

UPDATE co_employees2
SET id = 12
WHERE id = 1;

SELECT * FROM co_employees2 WHERE id BETWEEN 1 AND 5;
SELECT * FROM co_employees2 WHERE em_name LIKE '%er%';
SELECT * FROM co_employees2 WHERE id IN (6,7,9);
SELECT * FROM co_employees2 WHERE (year_in_company > 5 OR salary > 5000) AND gender = 'F';

SHOW TABLES;
SELECT * FROM mentorships;
SELECT MIN(id), MAX(id) FROM co_employees2;
SELECT * FROM co_employees2;
SELECT COUNT(id), COUNT(em_name) FROM co_employees2;
SELECT em_name from co_employees2 WHERE id IN (SELECT mentor_id FROM mentorships WHERE project = 'SQF Limited');
SELECT NOW();
SELECT CURDATE();
SELECT COUNT(*) FROM co_employees2;
SELECT COUNT(contact_number) FROM co_employees2;
SELECT COUNT(gender) FROM co_employees2;
SELECT COUNT(DISTINCT gender) FROM co_employees2;
SELECT AVG(salary) FROM co_employees2;
SELECT ROUND(AVG(salary), 2) FROM co_employees2;
SELECT MAX(salary) FROM co_employees2;
SELECT SUM(salary) FROM co_employees2;
SELECT gender, MAX(salary) FROM co_employees2 GROUP BY gender HAVING MAX(salary) > 10000;

SELECT co_employees2.id, mentorships.mentor_id, co_employees2.em_name 
AS 'Mentor', mentorships.project AS 'Project Name'
FROM mentorships JOIN co_employees2 
ON co_employees2.id = mentorships.mentor_id;

SELECT em_name, salary FROM co_employees2 WHERE gender = 'M'
UNION
SELECT em_name, year_in_company FROM co_employees2 WHERE gender = 'F';

SELECT mentor_id FROM mentorships
UNION ALL
SELECT id FROM co_employees2 WHERE gender = 'F';

CREATE VIEW myView AS
SELECT co_employees2.id, mentorships.mentor_id, co_employees2.em_name AS 'Mentor', mentorships.project AS 'Project Name'
FROM mentorships JOIN co_employees2 
ON co_employees2.id = mentorships.mentor_id;

SELECT * FROM myView;

ALTER VIEW myView AS
SELECT co_employees2.id, mentorships.mentor_id, co_employees2.em_name
AS 'Mentor', mentorships.project AS 'Project'
FROM mentorships JOIN co_employees2 
ON co_employees2.id = mentorships.mentor_id;

DELIMITER $$
CREATE TRIGGER update_ex_employees BEFORE DELETE ON co_employees2
FOR EACH ROW
BEGIN
  INSERT INTO ex_employees(em_id, em_name, gender) VALUES
  (OLD.id, OLD.em_name, OLD.gender);
  END $$
DELIMITER ;

SET @em_id = 2;
SET @em_name = 'Jamie';

DELIMITER $$
CREATE PROCEDURE select_into()
BEGIN
  SELECT * FROM co_employees2;
  SELECT * FROM mentorships;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE employee_info(IN p_em_id INT)
BEGIN
  SELECT * FROM mentorships WHERE mentor_id = p_em_id;
  SELECT * FROM mentorships WHERE mentee_id = p_em_id;
  SELECT * FROM co_employees2 WHERE id = p_em_id;
END $$
DELIMITER ;

CALL select_into();

DELIMITER $$
CREATE FUNCTION calculateBonus(p_salary DOUBLE, p_multiple DOUBLE) 
RETURNS DOUBLE DETERMINISTIC
BEGIN
  DECLARE bonus DOUBLE(8, 2);
  SET bonus = p_salary*p_multiple;
  RETURN bonus;
END $$
DELIMITER ;


