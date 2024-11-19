--1.Database Creation
--a) Create a database named "EventsManagement".

-- Database: "EventsManagement"

-- DROP DATABASE "EventsManagement";

CREATE DATABASE "EventsManagement"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'Portuguese_Brazil.1252'
       LC_CTYPE = 'Portuguese_Brazil.1252'
       CONNECTION LIMIT = -1;

--b) Create tables for Events, Attendees, and Registrations.
CREATE TABLE Events (
    Event_Id INT PRIMARY KEY,
    Event_Name VARCHAR(100),
    Event_Date DATE,
    Event_Location VARCHAR(100),
    Event_Description TEXT
);

CREATE TABLE Attendees (
    Attendee_Id INT PRIMARY KEY,
    Attendee_Name VARCHAR(100),
    Attendee_Phone VARCHAR(15),
    Attendee_Email VARCHAR(100),
    Attendee_City VARCHAR(50)
);

CREATE TABLE Registrations (
    Registration_Id INT PRIMARY KEY,
    Event_Id INT,
    Attendee_Id INT,
    Registration_Date DATE,
    Registration_Amount DECIMAL(10, 2),
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id),
    FOREIGN KEY (Attendee_Id) REFERENCES Attendees(Attendee_Id)
);

--2.Data Creation
--a) inserting sample data for Events, Attendees, and Registrations tables

INSERT INTO Events (Event_Id, Event_Name, Event_Date, Event_Location, Event_Description)
VALUES
	(1, 'Event Name 1', '2024-12-01', 'City 1', 'Event description 1.'),
	(2, 'Event Name 2', '2024-12-10', 'City 2', 'Event description 2.'),
	(3, 'Event Name 3', '2024-12-15', 'City 3', 'Event description 3.')
;

INSERT INTO Attendees (Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES
	(1, 'Name1', '11111111111', 'name1@email.com', 'City 1'),
	(2, 'Name2', '22222222222', 'name2@email.com', 'City 2'),
	(3, 'Name3', '33333333333', 'name3@email.com', 'City 3'),
	(4, 'Name4', '44444444444', 'name4@email.com', 'City 4')
;

INSERT INTO Registrations (Registration_Id, Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES
	(1, 1, 1, '2024-11-20', 100.00),
	(2, 1, 2, '2024-11-21', 100.00),
	(3, 2, 3, '2024-11-22', 200.00),
	(4, 3, 4, '2024-11-23', 150.00),
	(5, 3, 1, '2024-11-24', 150.00),
	(6, 2, 2, '2024-11-25', 200.00),
	(7, 1, 3, '2024-11-26', 100.00),
	(8, 3, 2, '2024-11-27', 150.00),
	(9, 1, 4, '2024-11-28', 100.00),
	(10, 2, 4, '2024-11-29', 200.00)
;

--3.Manage Event Details
--a) inserting a new event.
INSERT INTO Events (Event_Id, Event_Name, Event_Date, Event_Location, Event_Description)
VALUES
	(4, 'Event Name 4', '2024-12-15', 'City 5', 'Event description 4.')
;

--b) updating an event's information.
UPDATE 
	Events
SET 
	Event_Name = 'New Event Name',
	Event_Description = 'New event description.'
WHERE 
	Event_Id = 2
;

--c) deleting an event.
DELETE FROM Registrations WHERE Event_Id = 3;
DELETE FROM Events WHERE Event_Id = 3;

--4.Manage Track Attendees & Handle Events
--a) inserting a new attendee.
INSERT INTO Attendees (Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES
	(5, 'Name5', '55555555555', 'name5@email.com', 'City 5')
;

--b) registering an attendee for an event.
INSERT INTO Registrations (Registration_Id, Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES
	(11, 2, 5, '2024-11-30', 200.00)
;

--5.Develop queries to retrieve event information
--a) generating attendee lists, and calculate event attendance statistics.

-- attendee lists
SELECT 
	e.Event_Name,
	e.Event_Date,
	e.Event_Location,
	a.Attendee_Name,
	a.Attendee_Email,
	a.Attendee_Phone
FROM 
	Registrations r
JOIN 
	Events e ON 
	r.Event_Id = e.Event_Id
JOIN 
	Attendees a ON 
	r.Attendee_Id = a.Attendee_Id
ORDER BY 
	e.Event_Id, 
	a.Attendee_Name
;

-- total attendee
SELECT 
	e.Event_Name,
	COUNT(r.Registration_Id) AS Total_Attendees
FROM 
	Events e
LEFT JOIN 
	Registrations r ON 
	e.Event_Id = r.Event_Id
GROUP BY 
	e.Event_Id, e.Event_Name
ORDER BY 
	Total_Attendees DESC
;

-- revenue per event
SELECT 
	e.Event_Name,
	SUM(r.Registration_Amount) AS Total_Revenue
FROM 
	Events e
LEFT JOIN 
	Registrations r ON 
	e.Event_Id = r.Event_Id
GROUP BY 
	e.Event_Id, 
	e.Event_Name
ORDER BY 
	Total_Revenue DESC
;

-- average registration amount per event
SELECT 
	e.Event_Name AS EventName,
	AVG(r.Registration_Amount) AS AverageAmount
FROM 
	Events e
JOIN 
	Registrations r ON 
	e.Event_Id = r.Event_Id
GROUP BY 
	e.Event_Id, 
	e.Event_Name
;

