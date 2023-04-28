CREATE DATABASE TaskJoinDB

USE TaskJoinDB

CREATE TABLE Groups
(
Id INT PRIMARY KEY IDENTITY,
No NVARCHAR(5) UNIQUE
)


CREATE TABLE Students
(
Id INT PRIMARY KEY IDENTITY,
FullName NVARCHAR(30) NOT NULL,
Point INT CHECK(Point<=100),
GroupId INT FOREIGN KEY (GroupId) REFERENCES Groups(Id)
)



CREATE TABLE Exams
(
Id INT PRIMARY KEY IDENTITY,
SubjectName NVARCHAR(30) NOT NULL,
StartDate DATETIME2 NOT NULL,
EndDate DATETIME2 NOT NULL
)
ALTER TABLE Exams
ALTER COLUMN EndDate DATETIME2

ALTER TABLE Exams
ALTER COLUMN StartDate DATETIME2


CREATE TABLE StudentsExams
(
StudentId INT FOREIGN KEY (StudentId) REFERENCES Students(Id) ,
ExamId INT FOREIGN KEY (ExamId) REFERENCES Exams(Id),
ResultPoint INT NOT NULL
)

INSERT Groups
VALUES
('P100'),
('D238'),
('S300'),
('P328'),
('D123'),
('P404'),
('P202')


INSERT Students
VALUES
('Umid Museyibli',31,1),
('Rovsen Lenkeranski',50,2),
('Balaeli Yevropski',23,3),
('Resad Dagli',50,4),
('Mesedi Baba',87,2),
('Muslum Gurses',64,1),
('Aleyna Caqqal',78,1),
('Polat Alemdar',43,2),
('Batman Arxamov',51,2),
('Neset Ceketov',44,4),
('Aysov Spit',69,5)

INSERT Exams
VALUES
('Fizika','2023-04-27 11:00:00','2023-02-27 13:00:00'),
('Riyaziyyat','2023-04-30 15:00:00','2023-04-30 17:00:00'),
('Kimya','2023-05-01 09:00:00','2023-05-01 11:00:00'),
('Tarix','2023-04-27 11:00:00','2023-04-27 13:00:00')

INSERT Exams
VALUES
('Biologiya',NULL,NULL)

INSERT StudentsExams
VALUES
(1,1,80),
(2,4,43),
(3,3,75),
(1,3,40),
(4,2,90),
(3,1,50),
(10,2,80),
(7,5,80)



SELECT Students.Id,Students.FullName,Students.Point,Students.GroupId,Groups.No FROM Students
JOIN Groups ON Groups.Id=Students.GroupId

SELECT *,(SELECT COUNT(StudentId) FROM StudentsExams WHERE StudentsExams.StudentId=Students.Id) AS ExamCount FROM Students

SELECT * FROM Exams
WHERE NOT EXISTS (SELECT * FROM StudentsExams WHERE Exams.Id=StudentsExams.ExamId)

SELECT SubjectName,(SELECT COUNT(ExamId) FROM StudentsExams WHERE Exams.Id=StudentsExams.ExamId) AS StudentCount FROM Exams
WHERE StartDate<GETDATE() AND StartDate>DATEADD(day,-1,GETDATE())

SELECT StudentsExams.StudentId,StudentsExams.ExamId,StudentsExams.ResultPoint,Students.FullName,Groups.No FROM StudentsExams
JOIN Students ON StudentsExams.StudentId=Students.Id
JOIN Groups ON Students.GroupId=Groups.Id

SELECT *,(SELECT AVG(ResultPoint) FROM StudentsExams WHERE Students.Id=StudentsExams.StudentId) AS AvarageExamPoint FROM Students