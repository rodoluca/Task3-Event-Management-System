# Task3 - Event Management System

### Project Description:
To develop the application that allows users to create and manage events, track
attendees, and handle event registrations efficiently. 

The project will include the following tasks:

### 1.Database Creation
a) Create a database named "EventsManagement".

b) Create tables for Events, Attendees, and Registrations.

c) Events columns: Event_Id, Event_Name, Event_Date, Event_Location, Event_Description

d) Attendees columns: Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City

e) Registrations columns: Registration_id, Event_Id, Attendee_Id, Registration_Date, Registration_Amount

d) The FOREIGN KEY constraint in the Registrations table references the Event_Id column in the Events table and the Attendee_Id column in the Attendees table.

### 2.Data Creation
a) Insert some sample data for Events, Attendees, and Registrations tables with respective fields.

### 3.Manage Event Details
a) Inserting a new event.

b) Updating an event's information.

c) Deleting an event.

### 4.Manage Track Attendees & Handle Events
a) Inserting a new attendee.

b) Registering an attendee for an event.

### 5.Develop queries to retrieve event information
a) Generate attendee lists, and calculate event attendance statistics.
