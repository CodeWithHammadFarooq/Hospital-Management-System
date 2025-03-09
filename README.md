The SQL script defines and manages a Hospital Management System database. Below is a detailed breakdown of the script:

1. Creating the Database

CREATE DATABASE HospitalManagementSystem;
USE HospitalManagementSystem;
The CREATE DATABASE statement creates a database named HospitalManagementSystem.
The USE statement selects this database for operations.
2. Creating Tables
The script defines five tables: patients, doctors, appointments, prescriptions, and medical_records.

a) Patients Table

CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    phone_number VARCHAR(15),
    address VARCHAR(255)
);
Stores patient details such as name, date of birth, gender, phone number, and address.
patient_id is the primary key (auto-incremented).
gender is an ENUM field to allow only predefined values.
b) Doctors Table

CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100),
    phone_number VARCHAR(15),
    email VARCHAR(100)
);
Stores doctor details such as name, specialization, contact number, and email.
doctor_id is the primary key.
c) Appointments Table

CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME,
    status ENUM('Scheduled', 'Completed', 'Cancelled'),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);
Records appointments between patients and doctors.
Uses foreign keys to link to the patients and doctors tables.
The status field tracks the appointment status.
d) Prescriptions Table

CREATE TABLE prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    prescription_date DATE,
    medication VARCHAR(255),
    dosage VARCHAR(100),
    instructions TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);
Stores prescriptions given by doctors to patients.
Includes medication name, dosage, and instructions.
e) Medical Records Table

CREATE TABLE medical_records (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    visit_date DATE,
    diagnosis TEXT,
    treatment TEXT,
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);
Maintains medical history of patients, including diagnosis, treatment, and doctor notes.
3. Inserting Sample Data
a) Patients Data

INSERT INTO patients (first_name, last_name, date_of_birth, gender, phone_number, address)
VALUES 
('John', 'Doe', '1990-05-15', 'Male', '123-456-7890', '123 Main St'),
('Jane', 'Smith', '1985-08-22', 'Female', '987-654-3210', '456 Elm St');
Adds two patients with basic details.
b) Doctors Data

INSERT INTO doctors (first_name, last_name, specialization, phone_number, email)
VALUES 
('Alice', 'Johnson', 'Cardiologist', '555-123-4567', 'alice.johnson@hospital.com'),
('Bob', 'Williams', 'Neurologist', '555-987-6543', 'bob.williams@hospital.com');
Adds two doctors with specialization.
c) Appointments Data

INSERT INTO appointments (patient_id, doctor_id, appointment_date, status)
VALUES 
(1, 1, '2023-10-25 10:00:00', 'Scheduled'),
(2, 2, '2023-10-26 14:00:00', 'Scheduled');
Schedules appointments for both patients.
d) Prescriptions Data

INSERT INTO prescriptions (patient_id, doctor_id, prescription_date, medication, dosage, instructions)
VALUES 
(1, 1, '2023-10-20', 'Ibuprofen', '400mg', 'Take once daily after meals'),
(2, 2, '2023-10-21', 'Paracetamol', '500mg', 'Take twice daily');
Adds prescriptions for both patients.
e) Medical Records Data

INSERT INTO medical_records (patient_id, doctor_id, visit_date, diagnosis, treatment, notes)
VALUES 
(1, 1, '2023-10-20', 'High Blood Pressure', 'Prescribed medication', 'Patient advised to reduce salt intake'),
(2, 2, '2023-10-21', 'Migraine', 'Prescribed painkillers', 'Patient advised to avoid stress');
Stores medical history of both patients.
4. Querying Data
a) Retrieve Upcoming Scheduled Appointments

SELECT 
    a.appointment_id,
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    a.appointment_date,
    a.status
FROM 
    appointments a
JOIN 
    patients p ON a.patient_id = p.patient_id
JOIN 
    doctors d ON a.doctor_id = d.doctor_id
WHERE 
    a.appointment_date >= NOW()
    AND a.status = 'Scheduled';
Retrieves scheduled appointments that are yet to occur.
Uses JOINs to fetch patient and doctor names.
b) List Doctors and Their Appointments

SELECT 
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name
FROM 
    appointments a
JOIN 
    patients p ON a.patient_id = p.patient_id
JOIN 
    doctors d ON a.doctor_id = d.doctor_id
ORDER BY 
    d.doctor_id;
Lists all appointments, sorted by doctor_id.
c) Retrieve Prescriptions for a Specific Patient

SELECT 
    pr.prescription_id,
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    pr.prescription_date,
    pr.medication,
    pr.dosage,
    pr.instructions
FROM 
    prescriptions pr
JOIN 
    patients p ON pr.patient_id = p.patient_id
JOIN 
    doctors d ON pr.doctor_id = d.doctor_id
WHERE 
    pr.patient_id = 1; -- Replace with desired patient_id
Retrieves prescriptions for a specific patient (ID = 1).
Conclusion
This SQL script efficiently sets up a Hospital Management System with structured tables, sample data, and useful queries. It enables:

Patient and doctor record management
Appointment scheduling
Prescription tracking
Medical history storage
Efficient retrieval of key information
This database provides a solid foundation for building a hospital management application. 🚀
