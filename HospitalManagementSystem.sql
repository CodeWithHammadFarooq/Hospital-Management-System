CREATE DATABASE HospitalManagementSystem;
USE HospitalManagementSystem;

CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    phone_number VARCHAR(15),
    address VARCHAR(255)
);


CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100),
    phone_number VARCHAR(15),
    email VARCHAR(100)
);

CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME,
    status ENUM('Scheduled', 'Completed', 'Cancelled'),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

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

INSERT INTO patients (first_name, last_name, date_of_birth, gender, phone_number, address)
VALUES 
('John', 'Doe', '1990-05-15', 'Male', '123-456-7890', '123 Main St'),
('Jane', 'Smith', '1985-08-22', 'Female', '987-654-3210', '456 Elm St');

INSERT INTO doctors (first_name, last_name, specialization, phone_number, email)
VALUES 
('Alice', 'Johnson', 'Cardiologist', '555-123-4567', 'alice.johnson@hospital.com'),
('Bob', 'Williams', 'Neurologist', '555-987-6543', 'bob.williams@hospital.com');

INSERT INTO appointments (patient_id, doctor_id, appointment_date, status)
VALUES 
(1, 1, '2023-10-25 10:00:00', 'Scheduled'),
(2, 2, '2023-10-26 14:00:00', 'Scheduled');

INSERT INTO prescriptions (patient_id, doctor_id, prescription_date, medication, dosage, instructions)
VALUES 
(1, 1, '2023-10-20', 'Ibuprofen', '400mg', 'Take once daily after meals'),
(2, 2, '2023-10-21', 'Paracetamol', '500mg', 'Take twice daily');

INSERT INTO medical_records (patient_id, doctor_id, visit_date, diagnosis, treatment, notes)
VALUES 
(1, 1, '2023-10-20', 'High Blood Pressure', 'Prescribed medication', 'Patient advised to reduce salt intake'),
(2, 2, '2023-10-21', 'Migraine', 'Prescribed painkillers', 'Patient advised to avoid stress');

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

