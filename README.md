# DAMG-6210-PROJ

## About DAMG 6210
### Course Description
Studies design of information systems from a data perspective for engineering and business applications; data modeling, including entity-relationship (E-R) and object approaches; user-centric information requirements and data sharing; fundamental concepts of database management systems (DBMS) and their applications; alternative data models, with emphasis on relational design; SQL; data normalization; data-driven application design for personal computer, server-based, enterprise-wide, and Internet databases; and distributed data applications

### Professor
Yusuf Ozbek

## ERD

![hospital_erd](https://user-images.githubusercontent.com/110271091/194777830-64958446-4369-48cb-9a21-330b522ca0b2.png)

## Database
Mysql

## Summary

The hospital management system is a database system including the core functions of the hospital. This database system will allow patients to make appointments with doctors, view their own appointment records, support doctors in making diagnoses, prescribing prescriptions, formulating drug plans and making their own schedules, and more.

## Project Specific

### Entity Clusters
Just a simple division to make all entities into small groups.
1.	Invoice: Entities related to invoice that patients should pay for hospital.
2.	Inquiry: Entities related to the inquiry process between patients and doctors.
3.	Staff: Entities related to all hospital staff and their salary, etc.
4.	Patient: Entities related to patients and their status in the hospital.
5.	Medicine Device: Entities related to medicine, device, their vendor and orders.
6.	Schedule: Entities related to scheduling and appointment, etc.

### Entities
Entities: 27 Entities
All entities are listed here:
1.	admin
2.	appointment
3.	clinic
4.	department
5.	device
6.	device_order
7.	diagnosis
8.	disease
9.	doctor
10.	equipment
11.	factory
12.	hospitalization
13.	inquiry
14.	invoice
15.	medicine
16.	medicine_order
17.	nurse
18.	patient
19.	patient_record
20.	prescription
21.	producer
22.	room
23.	salary_payment
24.	schedule
25.	staff
26.	staff_record
27.	ward

### User Identities
1. admin: admin will have all the access and privileges towards the “hospital” database only.
2. analyst: analyst will only have access to the views that allows them to do analysis.
3. doctor: doctors will only have access to some of the procedures that are used for them to view their appointments and prescriptions.

### Procedures:
1.	getDoctorAppointment: this procedure is for doctors to see their appointments in one day.
2.	getDoctorPrescription: this procedure is for doctors to view prescriptions they made.
3.	getPatientPrescription: this procedure is to get prescriptions made for single patient.
4.	getSalaryPaymentDuring: this procedure is for financial analysis, to get all salary payments toward all the departments.

### Triggers:
1.	invoiceAppointmentTrigger: this will be triggered before a new record is added to appointment entity, the invoice will be generated and inserted, and a foreign key will be set to the appointment record.
2.	invoicePrescriptionTrigger: this will be triggered before a new record is added to prescription entity, the invoice will be generated and inserted, and a foreign key will be set to the appointment record.
3.	invoiceHospitalizationTrigger: this will be triggered before a new record is added to hospitalization entity, the invoice will be generated and inserted, and a foreign key will be set to the appointment record.
4.	staffUpdateBackup: this will be triggered after staff entity record has been updated, the original value will be inserted to staff_record table.
5.	staffDeleteBackup: this will be triggered after staff entity record has been deleted, the original value will be inserted to staff_record table.
6.	patientUpdateBackup: this will be triggered after patient entity record has been updated, the original value will be inserted to staff_record table.
7.	patientDeleteBackup: this will be triggered after patient entity record has been deleted, the original value will be inserted to staff_record table.

### Views
1.	departmentStaffNumberView: shows the staff number of each department.
2.	diseaseLeadPatientInHospitalView: shows the disease that may lead a patient to be in hospital.
3.	patientWithMedicinePaymentView: shows all patients that paid for their medicines (prescriptions).
4.	topDeviceSellerView: shows all device producer and their turnovers, etc.
5.	topMedicineSellerView: shows all medicine factories and their turnovers, etc.
