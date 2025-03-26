CREATE TABLE floors (
    floor_no INT PRIMARY KEY,
    floor_service TEXT
);

CREATE TABLE departments (
    floor_no INT,
    dept_name VARCHAR(50) PRIMARY KEY,
    about TEXT,
    FOREIGN KEY (floor_no) REFERENCES floors(floor_no)
);

CREATE TABLE doctors (
    doc_id INT PRIMARY KEY,
    doc_name VARCHAR(50),
    dept_name VARCHAR(50),
    specialty TEXT,
    post VARCHAR(50),
    degree TEXT,
    floor_no INT,
    attending_external_hospital VARCHAR(50),
    FOREIGN KEY (dept_name) REFERENCES departments(dept_name),
    FOREIGN KEY (floor_no) REFERENCES floors(floor_no)
);

CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender VARCHAR(10),
    contact_number VARCHAR(20),
    email VARCHAR(100),
    address TEXT,
    emergency_contact VARCHAR(50),
    blood_group VARCHAR(15)
);

CREATE TABLE admissions (
    admission_id INT PRIMARY KEY,
    patient_id INT,
    floor_no INT,
    dept_name VARCHAR(50),
    admission_date DATE,
    discharge_date DATE,
    attending_doctor_id INT,
    admission_status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (floor_no) REFERENCES floors(floor_no),
    FOREIGN KEY (dept_name) REFERENCES departments(dept_name),
    FOREIGN KEY (attending_doctor_id) REFERENCES doctors(doc_id)
);

CREATE TABLE room (
    room_id INT PRIMARY KEY,
    room_number VARCHAR(20),
    floor_no INT,
    room_type VARCHAR(50),
    room_status VARCHAR(20),
    patient_id INT,
    admission_date DATE,
    discharge_date DATE,
    cost_per_day DECIMAL(10,2),
    FOREIGN KEY (floor_no) REFERENCES floors(floor_no),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

CREATE TABLE tests (
    test_id INT PRIMARY KEY,
    test_name VARCHAR(100),
    dept_name VARCHAR(50),
    floor_no INT,
    test_type VARCHAR(50),
    cost DECIMAL(10,2),
    FOREIGN KEY (dept_name) REFERENCES departments(dept_name),
    FOREIGN KEY (floor_no) REFERENCES floors(floor_no)
);

CREATE TABLE individual_patient_tests (
    test_record_id INT PRIMARY KEY,
    patient_id INT,
    test_id INT,
    test_date DATE,
    test_result TEXT,
    test_status VARCHAR(20),
    assigned_doctor_id INT,
    cost DECIMAL(10,2),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (test_id) REFERENCES tests(test_id),
    FOREIGN KEY (assigned_doctor_id) REFERENCES doctors(doc_id)
);

CREATE TABLE procedures (
    procedure_id INT PRIMARY KEY,
    procedure_name VARCHAR(100),
    dept_name VARCHAR(50),
    floor_no INT,
    procedure_type VARCHAR(50),
    cost DECIMAL(10,2),
    FOREIGN KEY (dept_name) REFERENCES departments(dept_name),
    FOREIGN KEY (floor_no) REFERENCES floors(floor_no)
);

CREATE TABLE patient_procedures (
    procedure_record_id INT PRIMARY KEY,
    patient_id INT,
    procedure_id INT,
    procedure_date DATE,
    procedure_notes TEXT,
    assigned_doctor_id INT,
    procedure_status VARCHAR(20),
    cost DECIMAL(10,2),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (procedure_id) REFERENCES procedures(procedure_id),
    FOREIGN KEY (assigned_doctor_id) REFERENCES doctors(doc_id)
);

CREATE TABLE medications (
    medication_id INT PRIMARY KEY,
    medication_name VARCHAR(100),
    dosage VARCHAR(50),
    medication_type VARCHAR(50),
    side_effects TEXT,
    cost DECIMAL(10,2)
);

CREATE TABLE prescriptions (
    prescription_id INT PRIMARY KEY,
    patient_id INT,
    appointment_id INT,
    doc_id INT,
    medication_id INT,
    dosage VARCHAR(50),
    start_date DATE,
    end_date DATE,
    instructions TEXT,
    cost DECIMAL(10,2),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doc_id) REFERENCES doctors(doc_id),
    FOREIGN KEY (medication_id) REFERENCES medications(medication_id)
);

CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doc_id INT,
    appointment_date DATE,
    appointment_time TIME,
    reason_for_visit TEXT,
    appointment_status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doc_id) REFERENCES doctors(doc_id)
);

CREATE TABLE nurses (
    nurse_id INT PRIMARY KEY,
    nurse_name VARCHAR(50),
    department VARCHAR(50),
    contact_number VARCHAR(20),
    email VARCHAR(100),
    hire_date DATE,
    floor_no INT,
    FOREIGN KEY (department) REFERENCES departments(dept_name),
    FOREIGN KEY (floor_no) REFERENCES floors(floor_no)
);


CREATE TABLE assigned_nurse (
    assignment_id INT PRIMARY KEY,
    patient_id INT,
    nurse_id INT,
    room_id INT,
    shift_time VARCHAR(50),
    assignment_date DATE,
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (room_id) REFERENCES room(room_id)
);

CREATE TABLE billing (
    billing_id INT PRIMARY KEY,
    patient_id INT,
    admission_id INT,
    amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    payment_date DATE,
    payment_method VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (admission_id) REFERENCES admissions(admission_id)
);


INSERT INTO floors (floor_no, floor_service) VALUES
(0, 'Emergency, Primary Care, and Outpatient Services'),
(1, 'Specialty Medical Departments'),
(2, 'Surgical Services'),
(3, 'Women’s Health and Reproductive Medicine'),
(4, 'Diagnostic and Laboratory Services'),
(5, 'Mental Health and Behavioral Health'),
(6, 'Critical Care and Specialized Units'),
(7, 'Rehabilitation and Therapy Services'),
(8, 'Oncology and Cancer Care'),
(9, 'Dialysis and Transplant Services');




INSERT INTO departments (floor_no, dept_name, about) VALUES
-- Floor 0
(0, 'Outpatient Clinics', 'For non-urgent consultations and follow-ups (e.g., general checkups, routine care).'),
(0, 'Urgent Care', 'For non-emergency but urgent medical concerns (e.g., minor injuries, infections, flu).'),
(0, 'Emergency Department (ER)', 'Immediate care for acute conditions and life-threatening injuries (heart attacks, strokes, trauma, etc.).'),
(0, 'Primary Care Services', 'Includes Family Medicine, Internal Medicine, Pediatrics, and Geriatrics for regular checkups, preventative care, and managing chronic conditions.'),
-- Floor 1
(1, 'Endocrinology', 'Focuses on diseases related to hormones and metabolism, such as diabetes, thyroid issues, and adrenal disorders.'),
(1, 'Rheumatology', 'Treats autoimmune diseases and musculoskeletal disorders, including arthritis and lupus.'),
(1, 'Pulmonology', 'Deals with respiratory diseases, including asthma, COPD, and pneumonia.'),
(1, 'Cardiology', 'Specializes in the diagnosis and treatment of heart conditions, such as coronary artery disease and arrhythmias.'),
(1, 'Nephrology', 'Focuses on kidney diseases and conditions such as kidney failure, dialysis, and kidney transplantation.'),
(1, 'Dermatology', 'Treats skin diseases, including acne, eczema, psoriasis, and skin cancers.'),
(1, 'Infectious Disease', 'Diagnoses and treats infections caused by bacteria, viruses, and fungi.'),
(1, 'Gastroenterology', 'Specializes in digestive system diseases, including the stomach, liver, pancreas, and intestines.'),
-- Floor 2
(2, 'Neurosurgery', 'Surgical treatment for brain, spinal cord, and nervous system disorders.'),
(2, 'General Surgery', 'Performs surgeries for conditions affecting the abdomen, digestive system, and soft tissues (e.g., appendectomies, hernia repairs).'),
(2, 'Cardiothoracic Surgery', 'Performs surgeries on the heart and lungs, including bypass surgeries and valve replacements.'),
(2, 'Orthopedic Surgery', 'Specializes in musculoskeletal conditions, including bone fractures, joint replacements, and spine surgery.'),
(2, 'Plastic Surgery', 'Offers reconstructive surgery (e.g., after injury or congenital deformities) and cosmetic procedures.'),
-- Floor 3
(3, 'Breast Health', 'Dedicated to breast exams, mammograms, and treatment for breast cancer.'),
(3, 'Gynecology (GYN)', 'Treats reproductive health issues for women, such as menstrual problems, contraception, and menopause.'),
(3, 'Obstetrics (OB)', 'Care for pregnant women, including prenatal, labor, and postpartum care.'),
(3, 'Reproductive Medicine', 'Deals with infertility treatments, in-vitro fertilization (IVF), and hormonal therapies.'),
-- Floor 4
(4, 'Clinical Laboratory', 'Blood tests, urine tests, and microbiology for diagnosing various conditions.'),
(4, 'Genetics', 'Provides genetic counseling and testing for hereditary conditions and genetic disorders.'),
(4, 'Pathology', 'Lab tests to diagnose diseases, including cancer, infections, and genetic conditions.'),
(4, 'Radiology', 'Imaging diagnostics such as X-rays, MRIs, CT scans, and ultrasounds.'),
-- Floor 5
(5, 'Addiction Medicine', 'Treatment for substance use disorders, including detoxification, counseling, and rehabilitation programs.'),
(5, 'Neuropsychology', 'Focuses on brain-behavior relationships, working with patients who have neurological conditions or brain injuries.'),
(5, 'Psychiatry', 'Medical treatment for mental health disorders, including medications and psychiatric evaluations.'),
(5, 'Psychology', 'Therapy services for mental health conditions through various forms of psychotherapy (CBT, DBT, etc.).'),
-- Floor 6
(6, 'Cardiac ICU (CICU)', 'Specialized ICU for patients recovering from heart surgery, heart attacks, or severe heart conditions.'),
(6, 'Intensive Care Unit (ICU)', 'Critical care for patients with life-threatening conditions, including respiratory failure, sepsis, and organ failure.'),
(6, 'Pediatric ICU (PICU)', 'For critically ill children who require intensive monitoring and support.'),
(6, 'Post-Anesthesia Care Unit (PACU)', 'Recovery area for patients coming out of anesthesia after surgery.'),
(6, 'Neonatal ICU (NICU)', 'Specialized care for premature or critically ill newborns.'),
-- Floor 7
(7, 'Physical Therapy (PT)', 'Helps patients regain mobility and strength after surgery, injury, or illness.'),
(7, 'Occupational Therapy (OT)', 'Focuses on helping patients return to daily activities (e.g., dressing, eating, grooming) after illness or injury.'),
(7, 'Rehabilitation Medicine', 'Includes multidisciplinary rehabilitation for patients with neurological or musculoskeletal conditions.'),
(7, 'Speech Therapy', 'Works with patients to recover speech, language, and swallowing abilities.'),
-- Floor 8
(8, 'Bone Marrow/Stem Cell Transplantation', 'For patients requiring hematopoietic stem cell transplants.'),
(8, 'Hematology', 'Treatment of blood cancers, such as leukemia, lymphoma, and other hematologic disorders.'),
(8, 'Palliative Care', 'For patients with serious illnesses, focusing on comfort, symptom management, and quality of life.'),
(8, 'Radiation Therapy', 'Administers targeted radiation treatments for cancer patients.'),
(8, 'Oncology', 'Specialized care for cancer patients, including chemotherapy, radiation therapy, and surgery.'),
-- Floor 9
(9, 'Dialysis Unit', 'Provides treatment for patients with kidney failure, including hemodialysis and peritoneal dialysis.'),
(9, 'Kidney Transplantation', 'Specialized services for kidney transplants and post-transplant care.'),
(9, 'Liver Transplantation', 'Care for patients undergoing liver transplants, including pre- and post-surgery services.');





-- DOCTORS : 

INSERT INTO Doctors (doc_id, doc_name, dept_name, specialty, post, degree, floor_no, attending_external_hospital) VALUES
-- Floor 0
(1, 'Dr. Alan Smith', 'Outpatient Clinics', 'General Medicine', 'Consultant', 'MD', 0, 'City General Hospital'),
(2, 'Dr. Beatrice Clark', 'Urgent Care', 'Emergency Medicine', 'Senior Consultant', 'MD', 0, 'QuickCare Clinic'),
(3, 'Dr. Charles Wilson', 'Emergency Department (ER)', 'Trauma Surgery', 'Surgeon', 'MD', 0, 'City Trauma Center'),
(4, 'Dr. Diana Brown', 'Primary Care Services', 'Family Medicine', 'Consultant', 'MBBS', 0, 'HealthFirst Clinic'),
(5, 'Dr. Edward Adams', 'Outpatient Clinics', 'Internal Medicine', 'Consultant', 'MD', 0, 'City Health Center'),
(6, 'Dr. Fiona Turner', 'Urgent Care', 'Critical Care', 'Consultant', 'MD', 0, 'Emergency Health Clinic'),
(7, 'Dr. George Moore', 'Primary Care Services', 'Pediatrics', 'Senior Consultant', 'MBBS', 0, 'Children’s Health Hospital'),

-- Floor 1
(8, 'Dr. Kevin White', 'Endocrinology', 'Diabetes Management', 'Consultant', 'MD', 1, 'Endocrine Care Clinic'),
(9, 'Dr. Laura Lee', 'Rheumatology', 'Arthritis Treatment', 'Rheumatologist', 'MD', 1, 'RheumaCare Center'),
(10, 'Dr. Mike Jackson', 'Cardiology', 'Heart Disease', 'Cardiologist', 'MD', 1, 'Cardiac Health Center'),
(11, 'Dr. Nancy Cooper', 'Pulmonology', 'COPD Management', 'Pulmonologist', 'MBBS', 1, 'Breathe Life Clinic'),
(12, 'Dr. Oliver Turner', 'Nephrology', 'Dialysis', 'Nephrologist', 'MD', 1, 'Renal Care Clinic'),
(13, 'Dr. Paula Mitchell', 'Gastroenterology', 'Digestive Disorders', 'Gastroenterologist', 'MD', 1, 'Gut Health Center'),
(14, 'Dr. Quentin Carter', 'Cardiology', 'Arrhythmias', 'Cardiologist', 'MBBS', 1, 'HeartCare Clinic'),

-- Floor 2
(15, 'Dr. Ursula Harris', 'Neurosurgery', 'Spinal Disorders', 'Neurosurgeon', 'MD', 2, 'NeuroSurgery Center'),
(16, 'Dr. Victor Davis', 'Orthopedic Surgery', 'Joint Replacement', 'Orthopedic Surgeon', 'MD', 2, 'Joint Care Clinic'),
(17, 'Dr. William White', 'Plastic Surgery', 'Reconstructive Surgery', 'Plastic Surgeon', 'MD', 2, 'Reconstructive Surgery Center'),
(18, 'Dr. Xavier Moore', 'General Surgery', 'Hernia Repair', 'Surgeon', 'MBBS', 2, 'Surgical Health Center'),
(19, 'Dr. Yvonne Johnson', 'Neurosurgery', 'Brain Tumors', 'Neurosurgeon', 'MD', 2, 'Brain Health Clinic'),
(20, 'Dr. Zachary Adams', 'Orthopedic Surgery', 'Spinal Surgery', 'Orthopedic Surgeon', 'MD', 2, 'Spine Surgery Center'),
(21, 'Dr. Alan Cooper', 'Cardiothoracic Surgery', 'Valve Replacement', 'Cardiothoracic Surgeon', 'MD', 2, 'Cardiac Surgery Center'),

-- Floor 3
(22, 'Dr. Edward King', 'Breast Health', 'Breast Cancer Treatment', 'Breast Surgeon', 'MD', 3, 'Breast Care Center'),
(23, 'Dr. Fiona Green', 'Gynecology (GYN)', 'Menstrual Disorders', 'Gynecologist', 'MD', 3, 'GynCare Clinic'),
(24, 'Dr. Gary Brown', 'Obstetrics (OB)', 'Prenatal Care', 'OB/GYN', 'MBBS', 3, 'Maternity Health Center'),
(25, 'Dr. Helen Thomas', 'Gynecology (GYN)', 'Contraceptive Counseling', 'Senior Consultant', 'MD', 3, 'Women’s Health Clinic'),
(26, 'Dr. Isabella Walker', 'Reproductive Medicine', 'IVF', 'Fertility Specialist', 'MD', 3, 'Fertility Health Center'),
(27, 'Dr. Jack Adams', 'Reproductive Medicine', 'Infertility', 'Specialist', 'MBBS', 3, 'Reproductive Health Institute'),
(28, 'Dr. Karen Turner', 'Breast Health', 'Mammogram', 'Radiologist', 'MD', 3, 'Mammography Clinic'),

-- Floor 4
(29, 'Dr. Liam Clark', 'Obstetrics (OB)', 'Labor and Delivery', 'OB/GYN', 'MD', 4, 'Obstetric Care Center'),
(30, 'Dr. Maria King', 'Obstetrics (OB)', 'Postpartum Care', 'Consultant', 'MBBS', 4, 'Postpartum Health Center'),
(31, 'Dr. Nathan Harris', 'Reproductive Medicine', 'Egg Freezing', 'Fertility Specialist', 'MD', 4, 'IVF Clinic'),
(32, 'Dr. Olivia White', 'Pathology', 'Cancer Diagnosis', 'Pathologist', 'MD', 4, 'Pathology Health Center'),
(33, 'Dr. Paul Scott', 'Radiology', 'MRI Imaging', 'Radiologist', 'MD', 4, 'Imaging Health Center'),
(34, 'Dr. Quentin Brown', 'Clinical Laboratory', 'Blood Tests', 'Laboratory Technician', 'MBBS', 4, 'Diagnostic Laboratory Clinic'),
(35, 'Dr. Rebecca Adams', 'Genetics', 'Genetic Testing', 'Geneticist', 'MD', 4, 'Genetic Health Center'),

-- Floor 5
(36, 'Dr. Samuel Green', 'Clinical Laboratory', 'Microbiology', 'Pathologist', 'MD', 5, 'Diagnostic Health Center'),
(37, 'Dr. Teresa Walker', 'Radiology', 'CT Scans', 'Radiologist', 'MD', 5, 'Radiology Health Institute'),
(38, 'Dr. Ursula White', 'Pathology', 'Skin Cancer Diagnosis', 'Pathologist', 'MD', 5, 'Oncology Pathology Center'),
(39, 'Dr. Victor King', 'Genetics', 'Hereditary Conditions', 'Genetic Counselor', 'PhD', 5, 'Genetic Research Center'),
(40, 'Dr. Wanda Johnson', 'Clinical Laboratory', 'Urine Tests', 'Laboratory Technician', 'MBBS', 5, 'Clinical Diagnostics'),
(41, 'Dr. Xavier Lee', 'Radiology', 'X-Ray Imaging', 'Radiologist', 'MD', 5, 'X-ray Health Center'),
(42, 'Dr. Yasmin White', 'Pathology', 'Autopsy Services', 'Pathologist', 'MD', 5, 'Pathology Institute'),

-- Floor 6
(43, 'Dr. Zackary Moore', 'Cardiac ICU (CICU)', 'Post-Op Recovery', 'Intensivist', 'MD', 6, 'Heart Recovery Center'),
(44, 'Dr. Alice Brown', 'Intensive Care Unit (ICU)', 'Critical Care', 'ICU Consultant', 'MD', 6, 'Trauma Intensive Care Center'),
(45, 'Dr. Brian Collins', 'Pediatric ICU (PICU)', 'Neonatal Care', 'Pediatrician', 'MD', 6, 'Pediatric ICU Health Center'),
(46, 'Dr. Clara Evans', 'Post-Anesthesia Care Unit (PACU)', 'Anesthesia Recovery', 'PACU Nurse', 'MD', 6, 'Surgical Recovery Center'),
(47, 'Dr. Daniel Harris', 'Neonatal ICU (NICU)', 'Neonatal Care', 'Neonatologist', 'MD', 6, 'NICU Health Center'),
(48, 'Dr. Emily Green', 'Cardiac ICU (CICU)', 'Heart Surgery Recovery', 'Cardiologist', 'MD', 6, 'Cardiac Recovery Unit'),
(49, 'Dr. Frank Scott', 'Intensive Care Unit (ICU)', 'Ventilator Support', 'Intensivist', 'MD', 6, 'ICU Care Center'),

-- Floor 7
(50, 'Dr. Gavin White', 'Physical Therapy (PT)', 'Rehabilitation Post-Surgery', 'Physical Therapist', 'DPT', 7, 'Rehab Health Center'),
(51, 'Dr. Holly Brown', 'Occupational Therapy (OT)', 'Musculoskeletal Rehabilitation', 'OT Specialist', 'DPT', 7, 'OT Care Center'),
(52, 'Dr. Ian Davis', 'Rehabilitation Medicine', 'Neuro-Rehabilitation', 'Specialist', 'MD', 7, 'Neuro Rehab Clinic'),
(53, 'Dr. Jack Turner', 'Speech Therapy', 'Speech Rehabilitation', 'Speech Therapist', 'MS', 7, 'Speech Health Clinic'),
(54, 'Dr. Karen Lee', 'Physical Therapy (PT)', 'Post-Stroke Rehabilitation', 'Physical Therapist', 'DPT', 7, 'Stroke Rehab Center'),
(55, 'Dr. Liam Scott', 'Rehabilitation Medicine', 'Post-Surgery Recovery', 'Rehabilitation Specialist', 'MD', 7, 'Surgical Rehabilitation Center'),
(56, 'Dr. Monica Green', 'Speech Therapy', 'Swallowing Disorders', 'Speech Pathologist', 'MS', 7, 'Speech Rehab Clinic'),

-- Floor 8
(57, 'Dr. Nathan White', 'Bone Marrow/Stem Cell Transplantation', 'Stem Cell Therapy', 'Hematologist', 'MD', 8, 'Stem Cell Institute'),
(58, 'Dr. Olivia King', 'Hematology', 'Leukemia Treatment', 'Hematologist', 'MD', 8, 'Cancer Research Center'),
(59, 'Dr. Peter Johnson', 'Oncology', 'Radiation Therapy', 'Oncologist', 'MD', 8, 'Oncology Radiation Center'),
(60, 'Dr. Quentin Lee', 'Radiation Therapy', 'Cancer Radiation', 'Radiation Oncologist', 'MD', 8, 'Cancer Care Center'),
(61, 'Dr. Rachel Turner', 'Palliative Care', 'End-of-Life Care', 'Palliative Specialist', 'MD', 8, 'Palliative Health Clinic'),
(62, 'Dr. Steven Clark', 'Oncology', 'Chemotherapy', 'Oncologist', 'MD', 8, 'Chemotherapy Health Center'),
(63, 'Dr. Tina Scott', 'Oncology', 'Cancer Treatment', 'Oncologist', 'MD', 8, 'Cancer Care Center'),

-- Floor 9
(64, 'Dr. Uma White', 'Dialysis Unit', 'Chronic Kidney Disease', 'Nephrologist', 'MD', 9, 'Dialysis Health Center'),
(65, 'Dr. Victor Brown', 'Kidney Transplantation', 'Kidney Transplant', 'Transplant Surgeon', 'MD', 9, 'Kidney Transplant Center'),
(66, 'Dr. William Green', 'Dialysis Unit', 'Hemodialysis', 'Nephrologist', 'MBBS', 9, 'Renal Dialysis Center'),
(67, 'Dr. Xander Lee', 'Liver Transplantation', 'Liver Transplant Surgery', 'Liver Surgeon', 'MD', 9, 'Liver Transplant Center'),
(68, 'Dr. Yara Davis', 'Dialysis Unit', 'Dialysis Support', 'Nephrology Nurse', 'RN', 9, 'Dialysis Center'),
(69, 'Dr. Zachary White', 'Kidney Transplantation', 'Kidney Transplant Care', 'Nephrologist', 'MD', 9, 'Kidney Institute'),
(70, 'Dr. Alexis King', 'Liver Transplantation', 'Liver Care', 'Liver Specialist', 'MD', 9, 'Transplant Health Clinic');



-- PATIENTS : 
INSERT INTO Patients (patient_id, first_name, last_name, date_of_birth, gender, contact_number, email, address, emergency_contact, blood_Group) VALUES		
(1, 'John', 'Doe', '1985-07-12', 'Male', '555-1234', 'john.doe@example.com', '123 Elm St, Springfield', 'Jane Doe - 555-5678', 'A+'),
(2, 'Alice', 'Smith', '1992-03-22', 'Female', '555-2345', 'alice.smith@example.com', '456 Oak St, Lincoln', 'Bob Smith - 555-6789', 'B+'),
(3, 'Bob', 'Johnson', '1988-11-15', 'Male', '555-3456', 'bob.johnson@example.com', '789 Pine St, Shelbyville', 'Carol Johnson - 555-7890', 'O+'),
(4, 'Mary', 'Brown', '1975-06-30', 'Female', '555-4567', 'mary.brown@example.com', '321 Maple St, Rivertown', 'David Brown - 555-8901', 'AB+'),
(5, 'Michael', 'Williams', '1990-12-05', 'Male', '555-5678', 'michael.williams@example.com', '654 Birch St, Oakville', 'Sarah Williams - 555-9012', 'A-'),
(6, 'Emma', 'Jones', '1983-09-17', 'Female', '555-6789', 'emma.jones@example.com', '987 Cedar St, Westfield', 'Tom Jones - 555-0123', 'B-'),
(7, 'James', 'Miller', '2000-02-09', 'Male', '555-7890', 'james.miller@example.com', '543 Walnut St, Clearwater', 'Mary Miller - 555-1234', 'O-'),
(8, 'Olivia', 'Davis', '1995-05-24', 'Female', '555-8901', 'olivia.davis@example.com', '234 Pine St, Maple City', 'John Davis - 555-2345', 'AB-'),
(9, 'William', 'Garcia', '1993-01-11', 'Male', '555-9012', 'william.garcia@example.com', '765 Oak St, Springfield', 'Maria Garcia - 555-3456', 'A+'),
(10, 'Sophia', 'Martinez', '1980-10-19', 'Female', '555-0123', 'sophia.martinez@example.com', '321 Birch St, Rivertown', 'Jose Martinez - 555-4567', 'B+'),
(11, 'David', 'Rodriguez', '1996-07-08', 'Male', '555-1234', 'david.rodriguez@example.com', '234 Elm St, Lakewood', 'Laura Rodriguez - 555-5678', 'O+'),
(12, 'Isabella', 'Wilson', '1982-04-02', 'Female', '555-2345', 'isabella.wilson@example.com', '876 Maple St, Pinehurst', 'Robert Wilson - 555-6789', 'AB+'),
(13, 'Joseph', 'Taylor', '1978-08-15', 'Male', '555-3456', 'joseph.taylor@example.com', '123 Oak St, Hilltop', 'Karen Taylor - 555-7890', 'A-'),
(14, 'Charlotte', 'Moore', '1998-12-22', 'Female', '555-4567', 'charlotte.moore@example.com', '765 Birch St, Springdale', 'William Moore - 555-8901', 'B-'),
(15, 'Ethan', 'Jackson', '1987-09-28', 'Male', '555-5678', 'ethan.jackson@example.com', '432 Pine St, Oakwood', 'Emily Jackson - 555-9012', 'O-'),
(16, 'Amelia', 'Lee', '2001-05-17', 'Female', '555-6789', 'amelia.lee@example.com', '567 Cedar St, Fairview', 'Paul Lee - 555-0123', 'AB-'),
(17, 'Alexander', 'Harris', '1994-11-04', 'Male', '555-7890', 'alexander.harris@example.com', '890 Oak St, Lakeside', 'Nancy Harris - 555-1234', 'A+'),
(18, 'Mia', 'Clark', '1991-02-18', 'Female', '555-8901', 'mia.clark@example.com', '234 Maple St, Clearwater', 'Steven Clark - 555-2345', 'B+'),
(19, 'Jacob', 'Lewis', '1989-06-01', 'Male', '555-9012', 'jacob.lewis@example.com', '678 Pine St, Rivertown', 'Lily Lewis - 555-3456', 'O+'),
(20, 'Grace', 'Young', '1993-08-12', 'Female', '555-0123', 'grace.young@example.com', '345 Oak St, Beachwood', 'John Young - 555-4567', 'AB+'),
(21, 'Daniel', 'Allen', '1986-10-25', 'Male', '555-1234', 'daniel.allen@example.com', '123 Cedar St, Maplewood', 'Sandra Allen - 555-5678', 'A-'),
(22, 'Ella', 'Scott', '1990-03-03', 'Female', '555-2345', 'ella.scott@example.com', '234 Walnut St, Greenfield', 'Michael Scott - 555-6789', 'B-'),
(23, 'Matthew', 'Adams', '1981-04-18', 'Male', '555-3456', 'matthew.adams@example.com', '567 Birch St, Pinehill', 'Olivia Adams - 555-7890', 'O-'),
(24, 'Zoe', 'Baker', '1992-07-07', 'Female', '555-4567', 'zoe.baker@example.com', '678 Maple St, Oak Valley', 'Paul Baker - 555-8901', 'AB-'),
(25, 'Luke', 'Gonzalez', '1987-12-14', 'Male', '555-5678', 'luke.gonzalez@example.com', '789 Cedar St, Valleyview', 'Sophia Gonzalez - 555-9012', 'A+'),
(26, 'Lily', 'Nelson', '1994-09-11', 'Female', '555-6789', 'lily.nelson@example.com', '890 Pine St, Springwood', 'David Nelson - 555-0123', 'B+'),
(27, 'Evan', 'Carter', '1983-11-05', 'Male', '555-7890', 'evan.carter@example.com', '321 Oak St, Fairmont', 'Rachel Carter - 555-1234', 'O+'),
(28, 'Avery', 'Mitchell', '1995-03-17', 'Female', '555-8901', 'avery.mitchell@example.com', '432 Birch St, Newtown', 'James Mitchell - 555-2345', 'AB+'),
(29, 'Jack', 'Perez', '1980-01-09', 'Male', '555-9012', 'jack.perez@example.com', '543 Cedar St, Brookside', 'Olivia Perez - 555-3456', 'A-'),
(30, 'Megan', 'Roberts', '1986-05-22', 'Female', '555-0123', 'megan.roberts@example.com', '654 Oak St, Hill Valley', 'Steven Roberts - 555-4567', 'B-'),
(31, 'Samuel', 'Gomez', '1993-02-14', 'Male', '555-1234', 'samuel.gomez@example.com', '765 Birch St, Clearview', 'Linda Gomez - 555-5678', 'O-'),
(32, 'Natalie', 'Ward', '1994-08-25', 'Female', '555-2345', 'natalie.ward@example.com', '876 Oak St, Pine Grove', 'John Ward - 555-6789', 'AB-'),
(33, 'Tyler', 'Morris', '1981-11-30', 'Male', '555-3456', 'tyler.morris@example.com', '987 Cedar St, Westview', 'Emma Morris - 555-7890', 'A+'),
(34, 'Lillian', 'King', '1990-06-05', 'Female', '555-4567', 'lillian.king@example.com', '234 Birch St, Roseville', 'Matthew King - 555-8901', 'B+'),
(35, 'Adam', 'Lopez', '1992-10-21', 'Male', '555-5678', 'adam.lopez@example.com', '345 Maple St, Westfield', 'Elizabeth Lopez - 555-9012', 'O+'),
(36, 'Victoria', 'Hernandez', '1988-01-28', 'Female', '555-6789', 'victoria.hernandez@example.com', '456 Pine St, Central City', 'Luis Hernandez - 555-0123', 'AB+'),
(37, 'Henry', 'Foster', '1983-12-19', 'Male', '555-7890', 'henry.foster@example.com', '567 Oak St, Greenfield', 'Maria Foster - 555-1234', 'A-'),
(38, 'Hailey', 'Cole', '1995-07-04', 'Female', '555-8901', 'hailey.cole@example.com', '678 Cedar St, Hillside', 'Kevin Cole - 555-2345', 'B-'),
(39, 'Owen', 'Diaz', '1990-11-03', 'Male', '555-9012', 'owen.diaz@example.com', '789 Pine St, Hillcrest', 'Sophia Diaz - 555-3456', 'O-'),
(40, 'Chloe', 'Bennett', '1987-08-17', 'Female', '555-0123', 'chloe.bennett@example.com', '890 Oak St, Valleyview', 'Andrew Bennett - 555-4567', 'AB-'),
(41, 'Isaac', 'Mitchell', '1984-09-09', 'Male', '555-1234', 'isaac.mitchell@example.com', '123 Cedar St, Oakwood', 'Margaret Mitchell - 555-5678', 'A+'),
(42, 'Abigail', 'Cameron', '1991-05-06', 'Female', '555-2345', 'abigail.cameron@example.com', '234 Birch St, Glenwood', 'Richard Cameron - 555-6789', 'B+'),
(43, 'Charles', 'Walker', '1980-02-13', 'Male', '555-3456', 'charles.walker@example.com', '432 Pine St, Oak Park', 'Nancy Walker - 555-7890', 'O+'),
(44, 'Layla', 'Gonzalez', '1989-06-19', 'Female', '555-4567', 'layla.gonzalez@example.com', '543 Cedar St, Pine Ridge', 'Carlos Gonzalez - 555-8901', 'AB+'),
(45, 'Benjamin', 'Roberts', '1992-09-22', 'Male', '555-5678', 'benjamin.roberts@example.com', '654 Oak St, Silverlake', 'Jessica Roberts - 555-9012', 'A-'),
(46, 'Madison', 'Phillips', '1987-03-03', 'Female', '555-6789', 'madison.phillips@example.com', '765 Birch St, Clearfield', 'Jacob Phillips - 555-0123', 'B-'),
(47, 'Landon', 'Evans', '1984-05-25', 'Male', '555-7890', 'landon.evans@example.com', '876 Oak St, Highland Park', 'Rachel Evans - 555-1234', 'O+'),
(48, 'Penelope', 'Perry', '1996-02-10', 'Female', '555-8901', 'penelope.perry@example.com', '987 Cedar St, Lakewood', 'John Perry - 555-2345', 'AB+'),
(49, 'Elijah', 'Morris', '1995-06-29', 'Male', '555-9012', 'elijah.morris@example.com', '543 Oak St, Greenfield', 'Sophia Morris - 555-3456', 'A+'),
(50, 'Scarlett', 'Miller', '1990-07-21', 'Female', '555-0123', 'scarlett.miller@example.com', '234 Cedar St, Riverwood', 'Liam Miller - 555-4567', 'B+'),
(51, 'Jackson', 'Wright', '1993-09-11', 'Male', '555-1234', 'jackson.wright@example.com', '432 Oak St, Brookfield', 'Laura Wright - 555-5678', 'O-'),
(52, 'Emily', 'King', '1987-02-08', 'Female', '555-2345', 'emily.king@example.com', '543 Birch St, Sunshine Valley', 'Thomas King - 555-6789', 'AB-'),
(53, 'Gabriel', 'Adams', '1990-03-14', 'Male', '555-3456', 'gabriel.adams@example.com', '765 Oak St, Hillside', 'Elizabeth Adams - 555-7890', 'A+'),
(54, 'Chloe', 'Hill', '1996-01-17', 'Female', '555-4567', 'chloe.hill@example.com', '876 Cedar St, Maple Park', 'Patrick Hill - 555-8901', 'B+'),
(55, 'Isaiah', 'Walker', '1992-10-13', 'Male', '555-5678', 'isaiah.walker@example.com', '987 Oak St, Sunnydale', 'Jessica Walker - 555-9012', 'O+'),
(56, 'Layla', 'Bennett', '1990-05-19', 'Female', '555-6789', 'layla.bennett@example.com', '123 Pine St, Westbrook', 'David Bennett - 555-0123', 'AB+'),
(57, 'Mason', 'Graham', '1984-11-29', 'Male', '555-7890', 'mason.graham@example.com', '234 Cedar St, Clearview', 'Laura Graham - 555-1234', 'A-'),
(58, 'Lily', 'Foster', '1986-09-16', 'Female', '555-8901', 'lily.foster@example.com', '345 Oak St, Oceanview', 'James Foster - 555-2345', 'B-'),
(59, 'Michael', 'Nelson', '1997-08-04', 'Male', '555-9012', 'michael.nelson@example.com', '456 Birch St, Windwood', 'Sophia Nelson - 555-3456', 'O+'),
(60, 'Sophia', 'Carter', '1994-04-30', 'Female', '555-0123', 'sophia.carter@example.com', '567 Oak St, Riverdale', 'Matthew Carter - 555-4567', 'AB+');



INSERT INTO admissions (admission_id, patient_id, floor_no, dept_name, admission_date, discharge_date, attending_doctor_id, admission_status) VALUES
(1, 1, 0, 'Emergency Department (ER)', '2024-11-29', '2024-11-29', 3, 'Admitted'),
(2, 1, 0, 'Urgent Care', '2024-12-01', NULL, 6, 'Admitted'),
(3, 2, 0, 'Primary Care Services', '2024-12-02', NULL, 7, 'Admitted'),
(4, 3, 0, 'Primary Care Services', '2024-12-03', '2024-12-08', 4, 'Discharged'),
(5, 4, 9, 'Dialysis Unit', '2024-12-04', NULL, 9, 'Admitted'),
(6, 5, 0, 'Urgent Care', '2024-12-05', '2024-12-06', 2, 'Admitted'),
(7, 5, 0, 'Primary Care Services', '2024-12-06', '2024-12-11', 7, 'Discharged'),
(8, 6, 0, 'Emergency Department (ER)', '2024-12-07', NULL, 3, 'Admitted'),
(9, 7, 0, 'Outpatient Clinics', '2024-12-08', NULL, 1, 'Admitted'),
(10, 8, 1, 'Endocrinology', '2024-12-09', NULL, 8, 'Admitted'),
(11, 9, 1, 'Nephrology', '2024-12-10', '2024-12-15', 9, 'Discharged'),
(12, 10, 2, 'Orthopedic Surgery', '2024-12-11', '2024-12-16', 10, 'Discharged'),
(13, 11, 2, 'Plastic Surgery', '2024-12-12', '2024-12-17', 11, 'Discharged'),
(14, 12, 3, 'Cardiology', '2024-12-13', '2024-12-18', 12, 'Discharged'),
(15, 13, 3, 'Radiology', '2024-12-14', '2024-12-19', 13, 'Discharged'),
(16, 14, 4, 'Pulmonology', '2024-12-15', '2024-12-20', 14, 'Discharged'),
(17, 15, 4, 'Oncology', '2024-12-16', '2024-12-21', 15, 'Discharged'),
(18, 16, 5, 'Palliative Care', '2024-12-17', '2024-12-22', 16, 'Discharged'),
(19, 17, 5, 'Gynecology (GYN)', '2024-12-18', NULL, 17, 'Admitted'),
(20, 18, 6, 'Neurosurgery', '2024-12-19', NULL, 18, 'Admitted');



INSERT INTO room (room_id, room_number, floor_no, room_type, room_status, patient_id, admission_date, discharge_date, cost_per_day) VALUES
(1, 'R-001', 0, 'Emergency Room', 'Occupied', 1, '2024-11-29', NULL, 178.98),
(2, 'R-002', 0, 'Urgent Care Room', 'Occupied', 1, '2024-12-01', NULL, 795.51),
(3, 'R-003', 0, 'Primary Care Room', 'Occupied', 2, '2024-12-02', NULL, 640.63),
(4, 'R-004', 0, 'Primary Care Room', 'Discharged', 3, '2024-12-03', '2024-12-08', 716.60),
(5, 'R-005', 9, 'Dialysis Room', 'Occupied', 4, '2024-12-04', NULL, 661.13),
(6, 'R-006', 0, 'Urgent Care Room', 'Occupied', 5, '2024-12-05', NULL, 155.83),
(7, 'R-007', 0, 'Primary Care Room', 'Discharged', 5, '2024-12-06', '2024-12-11', 495.75),
(8, 'R-008', 0, 'Emergency Room', 'Occupied', 6, '2024-12-07', NULL, 111.27),
(9, 'R-009', 0, 'Outpatient Room', 'Occupied', 7, '2024-12-08', NULL, 769.09),
(10, 'R-010', 1, 'Endocrinology Room', 'Occupied', 8, '2024-12-09', NULL, 711.64),
(11, 'R-011', 1, 'Nephrology Room', 'Discharged', 9, '2024-12-10', '2024-12-15', 250.92),
(12, 'R-012', 2, 'Orthopedic Surgery Room', 'Discharged', 10, '2024-12-11', '2024-12-16', 819.69),
(13, 'R-013', 2, 'Plastic Surgery Room', 'Discharged', 11, '2024-12-12', '2024-12-17', 545.68),
(14, 'R-014', 3, 'Cardiology Room', 'Discharged', 12, '2024-12-13', '2024-12-18', 169.32),
(15, 'R-015', 3, 'Radiology Room', 'Discharged', 13, '2024-12-14', '2024-12-19', 909.56),
(16, 'R-016', 4, 'Pulmonology Room', 'Discharged', 14, '2024-12-15', '2024-12-20', 339.84),
(17, 'R-017', 4, 'Oncology Room', 'Discharged', 15, '2024-12-16', '2024-12-21', 670.54),
(18, 'R-018', 5, 'Palliative Care Room', 'Discharged', 16, '2024-12-17', '2024-12-22', 433.17),
(19, 'R-019', 5, 'Gynecology Room', 'Occupied', 17, '2024-12-18', NULL, 954.23),
(20, 'R-020', 6, 'Neurosurgery Room', 'Occupied', 18, '2024-12-19', NULL, 671.63);

INSERT INTO tests (test_id, test_name, dept_name, floor_no, test_type, cost) VALUES
(1, 'Routine Checkup', 'Outpatient Clinics', 0, 'Consultation', 100.00),
(2, 'Flu Test', 'Outpatient Clinics', 0, 'Lab', 25.00),
(3, 'X-Ray for Minor Injuries', 'Urgent Care', 0, 'Imaging', 100.00),
(4, 'Urine Test', 'Urgent Care', 0, 'Lab', 30.00),
(5, 'EKG', 'Emergency Department (ER)', 0, 'Diagnostic', 200.00),
(6, 'Chest X-Ray', 'Emergency Department (ER)', 0, 'Imaging', 150.00),
(7, 'General Blood Tests', 'Primary Care Services', 0, 'Lab', 75.00),
(8, 'Blood Pressure Measurement', 'Primary Care Services', 0, 'Consultation', 50.00),
(9, 'Thyroid Function Test', 'Endocrinology', 1, 'Lab', 100.00),
(10, 'Bone Density Test', 'Rheumatology', 1, 'Imaging', 250.00),
(11, 'Pulmonary Function Test', 'Pulmonology', 1, 'Diagnostic', 200.00),
(12, 'ECG', 'Cardiology', 1, 'Diagnostic', 150.00),
(13, 'Kidney Function Test', 'Nephrology', 1, 'Lab', 120.00),
(14, 'Skin Biopsy', 'Dermatology', 1, 'Diagnostic', 300.00),
(15, 'TB Test', 'Infectious Disease', 1, 'Lab', 50.00),
(16, 'Colonoscopy', 'Gastroenterology', 1, 'Diagnostic', 400.00),
(17, 'CT Scan Brain', 'Neurosurgery', 2, 'Imaging', 450.00),
(18, 'Appendectomy Surgery', 'General Surgery', 2, 'Surgical', 2500.00),
(19, 'Coronary Angiogram', 'Cardiothoracic Surgery', 2, 'Diagnostic', 600.00),
(20, 'X-Ray of Joints', 'Orthopedic Surgery', 2, 'Imaging', 120.00),
(21, 'Cosmetic Surgery Consultation', 'Plastic Surgery', 2, 'Consultation', 200.00),
(22, 'Mammogram', 'Breast Health', 3, 'Imaging', 150.00),
(23, 'Pap Smear', 'Gynecology (GYN)', 3, 'Lab', 75.00),
(24, 'Ultrasound', 'Obstetrics (OB)', 3, 'Imaging', 200.00),
(25, 'IVF Procedure', 'Reproductive Medicine', 3, 'Surgical', 5000.00),
(26, 'Blood Cultures', 'Clinical Laboratory', 4, 'Lab', 150.00),
(27, 'Genetic Screening', 'Genetics', 4, 'Lab', 300.00),
(28, 'Biopsy', 'Pathology', 4, 'Diagnostic', 450.00),
(29, 'X-Ray Chest', 'Radiology', 4, 'Imaging', 180.00),
(30, 'Alcohol Detox Test', 'Addiction Medicine', 5, 'Lab', 200.00);

INSERT INTO tests (test_id, test_name, dept_name, floor_no, test_type, cost) VALUES
(31, 'Cognitive Test', 'Neuropsychology', 5, 'Diagnostic', 250.00),
(32, 'Psychiatric Evaluation', 'Psychiatry', 5, 'Consultation', 350.00),
(33, 'Mental Health Assessment', 'Psychology', 5, 'Consultation', 150.00),
(34, 'ECG Monitoring', 'Cardiac ICU (CICU)', 6, 'Diagnostic', 250.00),
(35, 'ICU Monitoring', 'Intensive Care Unit (ICU)', 6, 'Diagnostic', 1000.00),
(36, 'Brain Activity Test', 'Pediatric ICU (PICU)', 6, 'Diagnostic', 500.00),
(37, 'Post-Surgery Monitoring', 'Post-Anesthesia Care Unit (PACU)', 6, 'Diagnostic', 150.00),
(38, 'Blood Gases Test', 'Neonatal ICU (NICU)', 6, 'Lab', 80.00),
(39, 'Physical Therapy Evaluation', 'Physical Therapy (PT)', 7, 'Consultation', 120.00),
(40, 'Occupational Therapy Evaluation', 'Occupational Therapy (OT)', 7, 'Consultation', 150.00),
(41, 'Neuro Rehab Test', 'Rehabilitation Medicine', 7, 'Diagnostic', 200.00),
(42, 'Speech Therapy Evaluation', 'Speech Therapy', 7, 'Consultation', 100.00),
(43, 'Stem Cell Transplantation Test', 'Bone Marrow/Stem Cell Transplantation', 8, 'Diagnostic', 5000.00),
(44, 'Blood Cancer Screening', 'Hematology', 8, 'Lab', 350.00),
(45, 'Pain Management Assessment', 'Palliative Care', 8, 'Consultation', 200.00),
(46, 'Radiation Treatment', 'Radiation Therapy', 8, 'Treatment', 3000.00),
(47, 'Oncology Consultation', 'Oncology', 8, 'Consultation', 400.00),
(48, 'Dialysis Treatment', 'Dialysis Unit', 9, 'Treatment', 500.00),
(49, 'Kidney Function Tests', 'Kidney Transplantation', 9, 'Lab', 150.00),
(50, 'Liver Function Test', 'Liver Transplantation', 9, 'Lab', 180.00),
(51, 'Routine Blood Work', 'Outpatient Clinics', 0, 'Lab', 60.00),
(52, 'Rapid Strep Test', 'Outpatient Clinics', 0, 'Lab', 30.00),
(53, 'Chest X-Ray', 'Urgent Care', 0, 'Imaging', 120.00),
(54, 'Rapid Flu Test', 'Urgent Care', 0, 'Lab', 40.00),
(55, 'Trauma Assessment', 'Emergency Department (ER)', 0, 'Consultation', 250.00),
(56, 'CT Scan Abdomen', 'Emergency Department (ER)', 0, 'Imaging', 500.00),
(57, 'Complete Blood Count (CBC)', 'Primary Care Services', 0, 'Lab', 50.00),
(58, 'Lipid Profile', 'Primary Care Services', 0, 'Lab', 75.00),
(59, 'Insulin Level Test', 'Endocrinology', 1, 'Lab', 110.00),
(60, 'Thyroid Ultrasound', 'Endocrinology', 1, 'Imaging', 150.00);

INSERT INTO tests (test_id, test_name, dept_name, floor_no, test_type, cost) VALUES
(61, 'Rheumatoid Factor Test', 'Rheumatology', 1, 'Lab', 120.00),
(62, 'Joint MRI', 'Rheumatology', 1, 'Imaging', 350.00),
(63, 'Chest CT', 'Pulmonology', 1, 'Imaging', 400.00),
(64, 'Lung Function Test', 'Pulmonology', 1, 'Diagnostic', 200.00),
(65, 'Cardiac Stress Test', 'Cardiology', 1, 'Diagnostic', 250.00),
(66, 'Echocardiogram', 'Cardiology', 1, 'Imaging', 300.00),
(67, 'Creatinine Test', 'Nephrology', 1, 'Lab', 70.00),
(68, 'Kidney Ultrasound', 'Nephrology', 1, 'Imaging', 180.00),
(69, 'Allergy Testing', 'Dermatology', 1, 'Lab', 150.00),
(70, 'Skin Cancer Biopsy', 'Dermatology', 1, 'Diagnostic', 250.00),
(71, 'HIV Test', 'Infectious Disease', 1, 'Lab', 50.00),
(72, 'Malaria Test', 'Infectious Disease', 1, 'Lab', 40.00),
(73, 'Colonoscopy Screening', 'Gastroenterology', 1, 'Diagnostic', 500.00),
(74, 'MRI Brain', 'Neurosurgery', 2, 'Imaging', 600.00),
(75, 'Spinal Cord Imaging', 'Neurosurgery', 2, 'Imaging', 550.00),
(76, 'Emergency Laparotomy', 'General Surgery', 2, 'Surgical', 3500.00),
(77, 'Hernia Repair Surgery', 'General Surgery', 2, 'Surgical', 2000.00),
(78, 'Heart Valve Replacement', 'Cardiothoracic Surgery', 2, 'Surgical', 12000.00),
(79, 'Cardiac Catheterization', 'Cardiothoracic Surgery', 2, 'Diagnostic', 700.00),
(80, 'Spinal Fusion Surgery', 'Orthopedic Surgery', 2, 'Surgical', 8000.00),
(81, 'Knee Replacement Surgery', 'Orthopedic Surgery', 2, 'Surgical', 7000.00),
(82, 'Facelift Surgery', 'Plastic Surgery', 2, 'Surgical', 4000.00),
(83, 'Tummy Tuck Surgery', 'Plastic Surgery', 2, 'Surgical', 5000.00),
(84, 'Mammography Screening', 'Breast Health', 3, 'Imaging', 180.00),
(85, 'Genetic Testing for Breast Cancer', 'Breast Health', 3, 'Lab', 350.00),
(86, 'Endometrial Biopsy', 'Gynecology (GYN)', 3, 'Diagnostic', 300.00),
(87, 'Pelvic Ultrasound', 'Gynecology (GYN)', 3, 'Imaging', 220.00),
(88, 'Non-Stress Test', 'Obstetrics (OB)', 3, 'Diagnostic', 150.00),
(89, 'Amniocentesis', 'Obstetrics (OB)', 3, 'Diagnostic', 800.00),
(90, 'Semen Analysis', 'Reproductive Medicine', 3, 'Lab', 100.00),
(91, 'Egg Freezing Consultation', 'Reproductive Medicine', 3, 'Consultation', 500.00),
(92, 'Complete Blood Count (CBC)', 'Clinical Laboratory', 4, 'Lab', 55.00),
(93, 'Urinalysis', 'Clinical Laboratory', 4, 'Lab', 30.00),
(94, 'Genetic Mutation Screening', 'Genetics', 4, 'Lab', 250.00),
(95, 'Chromosomal Abnormality Test', 'Genetics', 4, 'Lab', 300.00),
(96, 'Frozen Section Biopsy', 'Pathology', 4, 'Diagnostic', 500.00),
(97, 'CT Scan Abdomen & Pelvis', 'Radiology', 4, 'Imaging', 550.00),
(98, 'MRI Chest', 'Radiology', 4, 'Imaging', 450.00),
(99, 'Drug Screen Test', 'Addiction Medicine', 5, 'Lab', 100.00),
(100, 'Psychiatric Interview', 'Neuropsychology', 5, 'Consultation', 200.00);

INSERT INTO tests (test_id, test_name, dept_name, floor_no, test_type, cost) VALUES
(101, 'Cognitive Function Test', 'Neuropsychology', 5, 'Diagnostic', 250.00),
(102, 'Medication Management', 'Psychiatry', 5, 'Consultation', 180.00),
(103, 'Therapy Consultation', 'Psychology', 5, 'Consultation', 120.00),
(104, 'Echocardiogram', 'Cardiac ICU (CICU)', 6, 'Imaging', 300.00),
(105, 'Sepsis Blood Test', 'Intensive Care Unit (ICU)', 6, 'Lab', 150.00),
(106, 'Neurological Monitoring', 'Pediatric ICU (PICU)', 6, 'Diagnostic', 400.00),
(107, 'Anesthesia Consultation', 'Post-Anesthesia Care Unit (PACU)', 6, 'Consultation', 180.00),
(108, 'Preterm Screening', 'Neonatal ICU (NICU)', 6, 'Diagnostic', 250.00),
(109, 'Physical Assessment', 'Physical Therapy (PT)', 7, 'Consultation', 120.00),
(110, 'Strength and Balance Test', 'Physical Therapy (PT)', 7, 'Diagnostic', 150.00),
(111, 'ADL Test', 'Occupational Therapy (OT)', 7, 'Diagnostic', 100.00),
(112, 'Post-Stroke Rehab Test', 'Rehabilitation Medicine', 7, 'Diagnostic', 200.00),
(113, 'Speech Articulation Test', 'Speech Therapy', 7, 'Diagnostic', 150.00),
(114, 'Bone Marrow Biopsy', 'Bone Marrow/Stem Cell Transplantation', 8, 'Diagnostic', 600.00),
(115, 'Blood Cancer Screening', 'Hematology', 8, 'Lab', 350.00),
(116, 'Palliative Care Consultation', 'Palliative Care', 8, 'Consultation', 200.00),
(117, 'Radiation Oncology Consultation', 'Radiation Therapy', 8, 'Consultation', 500.00),
(118, 'Chemotherapy Consultation', 'Oncology', 8, 'Consultation', 400.00),
(119, 'Tumor Marker Test', 'Oncology', 8, 'Lab', 250.00),
(120, 'Dialysis Treatment', 'Dialysis Unit', 9, 'Treatment', 550.00),
(121, 'Kidney Transplant Compatibility Test', 'Kidney Transplantation', 9, 'Lab', 250.00),
(122, 'Liver Function Test', 'Liver Transplantation', 9, 'Lab', 180.00),
(123, 'CT Scan for Liver', 'Liver Transplantation', 9, 'Imaging', 400.00);

INSERT INTO individual_patient_tests (test_record_id, patient_id, test_id, test_date, test_result, test_status, assigned_doctor_id, cost) VALUES
(1, 1, 1, '2024-11-29', 'No Abnormalities Found', 'Completed', 3, 100.00),
(2, 1, 2, '2024-12-01', 'Positive for Flu Virus', 'Completed', 6, 25.00),
(3, 2, 3, '2024-12-02', 'Normal', 'Completed', 7, 100.00),
(4, 3, 4, '2024-12-03', 'No Abnormalities Found', 'Completed', 4, 30.00),
(5, 4, 5, '2024-12-04', 'Elevated Blood Pressure', 'Completed', 9, 200.00),
(6, 5, 6, '2024-12-05', 'Negative for Infection', 'Completed', 2, 150.00),
(7, 5, 7, '2024-12-06', 'Normal', 'Completed', 7, 75.00),
(8, 6, 8, '2024-12-07', 'No Abnormalities Found', 'Completed', 3, 50.00),
(9, 7, 9, '2024-12-08', 'High Cholesterol Detected', 'Completed', 1, 100.00),
(10, 8, 10, '2024-12-09', 'No Abnormalities Found', 'Completed', 5, 250.00),
(11, 8, 11, '2024-12-10', 'Normal', 'Completed', 8, 200.00),
(12, 9, 12, '2024-12-11', 'Elevated Glucose Levels', 'Completed', 4, 150.00),
(13, 10, 13, '2024-12-12', 'Elevated Risk of Heart Disease', 'Completed', 3, 120.00),
(14, 11, 14, '2024-12-13', 'Normal', 'Completed', 7, 300.00),
(15, 12, 15, '2024-12-14', 'Negative for Disease X', 'Completed', 2, 50.00),
(16, 13, 16, '2024-12-15', 'Requires Further Analysis', 'Completed', 6, 400.00),
(17, 14, 17, '2024-12-16', 'High Blood Pressure Detected', 'Completed', 9, 450.00),
(18, 15, 18, '2024-12-17', 'No Abnormalities Found', 'Completed', 1, 2500.00),
(19, 16, 19, '2024-12-18', 'Normal', 'Completed', 7, 600.00),
(20, 17, 20, '2024-12-19', 'Elevated Risk for Stroke', 'Completed', 3, 120.00);



INSERT INTO procedures (procedure_id, procedure_name, dept_name, floor_no, procedure_type, cost) VALUES
(1, 'General Check-up', 'Outpatient Clinics', 0, 'Diagnostic', 200.00),
(2, 'Flu Treatment', 'Urgent Care', 0, 'Therapeutic', 150.00),
(3, 'Wound Care', 'Urgent Care', 0, 'Therapeutic', 300.00),
(4, 'Trauma Surgery', 'Emergency Department (ER)', 0, 'Surgical', 12000.00),
(5, 'Cardiac Arrest Resuscitation', 'Emergency Department (ER)', 0, 'Therapeutic', 5000.00),
(6, 'Thyroid Function Test', 'Endocrinology', 1, 'Diagnostic', 500.00),
(7, 'Joint Injection', 'Rheumatology', 1, 'Therapeutic', 800.00),
(8, 'Spirometry', 'Pulmonology', 1, 'Diagnostic', 400.00),
(9, 'Electrocardiogram (ECG)', 'Cardiology', 1, 'Diagnostic', 300.00),
(10, 'Dialysis', 'Nephrology', 1, 'Therapeutic', 3000.00),
(11, 'Skin Biopsy', 'Dermatology', 1, 'Diagnostic', 1500.00),
(12, 'HIV Screening', 'Infectious Disease', 1, 'Diagnostic', 300.00),
(13, 'Colonoscopy', 'Gastroenterology', 1, 'Diagnostic', 2500.00),
(14, 'Brain Tumor Surgery', 'Neurosurgery', 2, 'Surgical', 15000.00),
(15, 'Appendectomy', 'General Surgery', 2, 'Surgical', 5000.00),
(16, 'Coronary Artery Bypass', 'Cardiothoracic Surgery', 2, 'Surgical', 25000.00),
(17, 'Spinal Fusion Surgery', 'Orthopedic Surgery', 2, 'Surgical', 12000.00),
(18, 'Cosmetic Rhinoplasty', 'Plastic Surgery', 2, 'Surgical', 6000.00),
(19, 'Mammogram', 'Breast Health', 3, 'Diagnostic', 800.00),
(20, 'Pap Smear', 'Gynecology (GYN)', 3, 'Diagnostic', 150.00),
(21, 'Prenatal Care', 'Obstetrics (OB)', 3, 'Consultation', 500.00),
(22, 'IVF (In-vitro Fertilization)', 'Reproductive Medicine', 3, 'Therapeutic', 12000.00),
(23, 'Breast Cancer Surgery', 'Breast Health', 3, 'Surgical', 10000.00),
(24, 'Blood Test', 'Clinical Laboratory', 4, 'Diagnostic', 150.00),
(25, 'Genetic Counseling', 'Genetics', 4, 'Consultation', 400.00),
(26, 'Biopsy', 'Pathology', 4, 'Diagnostic', 2000.00),
(27, 'X-ray', 'Radiology', 4, 'Diagnostic', 500.00),
(28, 'MRI Scan', 'Radiology', 4, 'Diagnostic', 2000.00),
(29, 'Detoxification', 'Addiction Medicine', 5, 'Therapeutic', 3500.00),
(30, 'Cognitive Testing', 'Neuropsychology', 5, 'Diagnostic', 1200.00),
(31, 'Psychiatric Evaluation', 'Psychiatry', 5, 'Consultation', 500.00),
(32, 'Cognitive Behavioral Therapy (CBT)', 'Psychology', 5, 'Therapeutic', 100.00),
(33, 'Substance Abuse Counseling', 'Addiction Medicine', 5, 'Therapeutic', 250.00),
(34, 'Post-Operative Care', 'Cardiac ICU (CICU)', 6, 'Therapeutic', 3000.00),
(35, 'Ventilator Management', 'Intensive Care Unit (ICU)', 6, 'Therapeutic', 5000.00),
(36, 'Pediatric Intensive Care', 'Pediatric ICU (PICU)', 6, 'Therapeutic', 4500.00),
(37, 'Anesthesia Recovery', 'Post-Anesthesia Care Unit (PACU)', 6, 'Therapeutic', 1000.00),
(38, 'Neonatal Ventilator Support', 'Neonatal ICU (NICU)', 6, 'Therapeutic', 4000.00),
(39, 'Post-Surgical Rehabilitation', 'Physical Therapy (PT)', 7, 'Therapeutic', 500.00),
(40, 'Occupational Therapy Assessment', 'Occupational Therapy (OT)', 7, 'Consultation', 350.00),
(41, 'Neurological Rehabilitation', 'Rehabilitation Medicine', 7, 'Therapeutic', 1000.00),
(42, 'Speech Therapy for Stroke Patients', 'Speech Therapy', 7, 'Therapeutic', 300.00),
(43, 'Joint Rehabilitation', 'Physical Therapy (PT)', 7, 'Therapeutic', 600.00),
(44, 'Bone Marrow Transplant', 'Bone Marrow/Stem Cell Transplantation', 8, 'Surgical', 50000.00),
(45, 'Chemotherapy', 'Oncology', 8, 'Therapeutic', 10000.00),
(46, 'Blood Cancer Consultation', 'Hematology', 8, 'Consultation', 800.00),
(47, 'Palliative Care Consultation', 'Palliative Care', 8, 'Consultation', 1000.00),
(48, 'Radiation Therapy for Cancer', 'Radiation Therapy', 8, 'Therapeutic', 15000.00),
(49, 'Hemodialysis', 'Dialysis Unit', 9, 'Therapeutic', 3500.00),
(50, 'Kidney Transplantation', 'Kidney Transplantation', 9, 'Surgical', 30000.00),
(51, 'Liver Transplantation', 'Liver Transplantation', 9, 'Surgical', 50000.00),
(52, 'Peritoneal Dialysis', 'Dialysis Unit', 9, 'Therapeutic', 4000.00),
(53, 'Post-Transplant Care', 'Kidney Transplantation', 9, 'Therapeutic', 5000.00);

INSERT INTO patient_procedures (procedure_record_id, patient_id, procedure_id, procedure_date, procedure_notes, assigned_doctor_id, procedure_status, cost) VALUES
(1, 1, 4, '2024-11-29', 'Trauma Surgery: Patient admitted to the Emergency Department (ER) for traumatic injuries. A surgical procedure was performed to treat internal bleeding and fractures after a motor vehicle accident.', 3, 'Admitted', 12000.00),
(2, 1, 2, '2024-12-01', 'Flu Treatment: Patient admitted to Urgent Care for influenza treatment. Antiviral medications and fluids were provided to manage symptoms of flu.', 6, 'Admitted', 150.00),
(3, 2, 5, '2024-12-03', 'Cardiac Arrest Resuscitation: Patient admitted to Primary Care Services. The patient received immediate CPR and advanced life support for resuscitation.', 7, 'Admitted', 5000.00),
(4, 3, 5, '2024-12-04', 'Cardiac Arrest Resuscitation: Continued management and monitoring after initial resuscitation. The patient was stabilized and transferred for intensive care.', 4, 'Discharged', 5000.00),
(5, 4, 9, '2024-12-07', 'Dialysis: Patient admitted to Dialysis Unit for hemodialysis due to renal failure. Dialysis performed to filter waste products and excess fluids from the blood.', 9, 'Admitted', 300.00),
(6, 5, 2, '2024-12-05', 'Flu Treatment: Patient admitted to Urgent Care for flu management. Symptomatic treatment provided, including medication for fever and body aches.', 2, 'Admitted', 150.00),
(7, 5, 5, '2024-12-08', 'Cardiac Arrest Resuscitation: Follow-up treatment after initial cardiac arrest. The patient received further evaluation and stabilization in Primary Care Services.', 7, 'Discharged', 5000.00),
(8, 6, 4, '2024-12-08', 'Trauma Surgery: Patient admitted to the ER for injuries from an accident. Surgical intervention was performed to stabilize the patient, address bleeding, and fractures.', 3, 'Admitted', 12000.00),
(9, 7, 1, '2024-12-09', 'General Check-Up: Patient admitted for routine health check-up at Outpatient Clinics. Physical examination and diagnostic tests were performed to assess general health.', 1, 'Admitted', 200.00),
(10, 8, 6, '2024-12-11', 'Thyroid Function Test: Patient admitted to Endocrinology for thyroid evaluation. Blood tests conducted to assess thyroid hormone levels and screen for thyroid disorders.', 8, 'Admitted', 500.00),
(11, 9, 10, '2024-12-10', 'Dialysis: Patient admitted to Nephrology for hemodialysis due to kidney failure. Dialysis was carried out to filter blood and reduce toxins.', 9, 'Discharged', 3000.00),
(12, 10, 18, '2024-12-13', 'Spinal Fusion Surgery: Patient admitted to Orthopedic Surgery for spinal fusion. The surgical procedure was performed to stabilize the spine following injury and alleviate pain.', 10, 'Discharged', 6000.00),
(13, 11, 18, '2024-12-14', 'Cosmetic Rhinoplasty: Patient admitted to Plastic Surgery for cosmetic nose surgery. The procedure involved reshaping the nasal structure to improve appearance and function.', 11, 'Discharged', 6000.00),
(14, 12, 9, '2024-12-16', 'MRI Scan: Patient admitted to Radiology for MRI imaging to assess soft tissue injuries and internal damages. Detailed images of the injured area were obtained.', 12, 'Discharged', 300.00),
(15, 13, 7, '2024-12-17', 'Neurological Rehabilitation: Patient admitted to Rehabilitation Medicine following a stroke. A comprehensive rehabilitation plan was implemented to improve cognitive and motor function.', 13, 'Discharged', 800.00),
(16, 14, 8, '2024-12-18', 'Spirometry: Patient admitted to Pulmonology for lung function testing. Spirometry conducted to assess airflow and diagnose possible lung conditions.', 14, 'Discharged', 400.00),
(17, 15, 8, '2024-12-19', 'Chemotherapy: Patient admitted to Oncology for chemotherapy treatment. The procedure involved administering cancer medications to target and reduce tumor size.', 15, 'Discharged', 400.00),
(18, 16, 8, '2024-12-17', 'Palliative Care: Patient admitted to Palliative Care for symptom management and comfort care. End-of-life care provided to improve quality of life during terminal illness.', 16, 'Discharged', 400.00),
(19, 17, 12, '2024-12-21', 'Pap Smear: Patient admitted to Gynecology for a Pap smear. The test was conducted to screen for cervical abnormalities and potential early signs of cervical cancer.', 17, 'Admitted', 300.00),
(20, 18, 13, '2024-12-21', 'Brain Tumor Surgery: Patient admitted to Neurosurgery for brain tumor removal. The procedure involved a craniotomy to remove the tumor and relieve intracranial pressure.', 18, 'Admitted', 2500.00);

INSERT INTO medications (medication_id, medication_name, dosage, medication_type, side_effects, cost) VALUES
(1, 'Amlodipine', '5 mg', 'Oral', 'Dizziness, swelling of ankles or feet', 23.69),
(2, 'Lisinopril', '10 mg', 'Oral', 'Cough, high potassium levels, dizziness', 59.15),
(3, 'Carvedilol', '12.5 mg', 'Oral', 'Fatigue, low blood pressure, dizziness', 34.68),
(4, 'Doxorubicin', '50 mg', 'Injection', 'Nausea, hair loss, heart damage', 75.93),
(5, 'Methotrexate', '15 mg', 'Oral', 'Nausea, mouth sores, liver toxicity', 85.65),
(6, 'Tamoxifen', '20 mg', 'Oral', 'Hot flashes, blood clots, fatigue', 10.43),
(7, 'Insulin', '5 units', 'Injection', 'Low blood sugar, weight gain, allergic reactions', 55.19),
(8, 'Prednisone', '20 mg', 'Oral', 'Weight gain, high blood pressure, mood swings', 54.68),
(9, 'Epinephrine', '0.3 mg', 'Injection', 'Anxiety, palpitations, dizziness', 97.81),
(10, 'Ibuprofen', '200 mg', 'Oral', 'Upset stomach, dizziness, kidney issues', 45.01),
(11, 'Fentanyl', '50 mcg/hr', 'Patch', 'Drowsiness, constipation, nausea', 11.63),
(12, 'Lorazepam', '1 mg', 'Oral', 'Drowsiness, dizziness, fatigue', 93.14),
(13, 'Benzonatate', '100 mg', 'Oral', 'Drowsiness, dizziness, headache', 60.79),
(14, 'Hydrocodone', '5 mg', 'Oral', 'Constipation, nausea, dizziness', 14.52),
(15, 'Nitroglycerin', '0.3 mg', 'Sublingual', 'Headache, dizziness, low blood pressure', 60.23),
(16, 'Sildenafil', '50 mg', 'Oral', 'Headache, flushing, indigestion', 67.60),
(17, 'Salbutamol', '2.5 mg', 'Inhaler', 'Tremors, headache, fast heartbeat', 57.32),
(18, 'Simvastatin', '20 mg', 'Oral', 'Muscle pain, liver damage, nausea', 73.77),
(19, 'Amoxicillin', '500 mg', 'Oral', 'Rash, diarrhea, nausea', 96.91);

INSERT INTO medications (medication_id, medication_name, dosage, medication_type, side_effects, cost) VALUES
(20, 'Azithromycin', '250 mg', 'Oral', 'Nausea, diarrhea, abdominal pain', 73.24),
(21, 'Adalimumab', '40 mg', 'Injection', 'Injection site reactions, upper respiratory infections', 65.46),
(22, 'Levetiracetam', '500 mg', 'Oral', 'Drowsiness, dizziness, behavioral changes', 97.60),
(23, 'Carbamazepine', '200 mg', 'Oral', 'Drowsiness, dizziness, nausea', 11.61),
(24, 'Methadone', '5 mg', 'Oral', 'Drowsiness, constipation, dizziness', 25.24),
(25, 'Furosemide', '40 mg', 'Oral', 'Dizziness, dehydration, low potassium', 81.36),
(26, 'Enoxaparin', '40 mg', 'Injection', 'Bleeding, headache, dizziness', 51.10),
(27, 'Ceftriaxone', '1 gm', 'Injection', 'Diarrhea, rash, allergic reactions', 91.43),
(28, 'Methylprednisolone', '4 mg', 'Oral', 'Weight gain, stomach ulcers, fluid retention', 23.85),
(29, 'Tamsulosin', '0.4 mg', 'Oral', 'Dizziness, abnormal ejaculation, headache', 14.93),
(30, 'Rivaroxaban', '20 mg', 'Oral', 'Bleeding, stomach pain, dizziness', 83.12),
(31, 'Amoxicillin', '250 mg', 'Oral', 'Rash, diarrhea, nausea', 90.83),
(32, 'Tylenol', '160 mg/5 mL', 'Oral', 'Nausea, stomach pain, allergic reactions', 14.76),
(33, 'Ibuprofen', '100 mg', 'Oral', 'Upset stomach, dizziness, kidney issues', 61.32),
(34, 'Prednisone', '5 mg', 'Oral', 'Weight gain, high blood pressure, mood swings', 72.33),
(35, 'Fluconazole', '100 mg', 'Oral', 'Headache, nausea, stomach pain', 77.67),
(36, 'Montelukast', '4 mg', 'Oral', 'Stomach pain, headache, dizziness', 71.38),
(37, 'Ranitidine', '75 mg', 'Oral', 'Headache, constipation, nausea', 23.89),
(38, 'Doxorubicin', '50 mg', 'Injection', 'Nausea, hair loss, heart damage', 75.30),
(39, 'Methotrexate', '15 mg', 'Oral', 'Nausea, mouth sores, liver toxicity', 24.84),
(40, 'Tamoxifen', '20 mg', 'Oral', 'Hot flashes, blood clots, fatigue', 68.28),
(41, 'Cyclophosphamide', '50 mg', 'Injection', 'Hair loss, nausea, low blood counts', 76.89),
(42, 'Cisplatin', '50 mg', 'Injection', 'Nausea, kidney toxicity, hearing loss', 79.61),
(43, 'Aspirin', '81 mg', 'Oral', 'Gastrointestinal bleeding, nausea, stomach irritation', 67.39),
(44, 'Losartan', '50 mg', 'Oral', 'Dizziness, upper respiratory infections, back pain', 88.10),
(45, 'Atorvastatin', '10 mg', 'Oral', 'Muscle pain, liver damage, nausea', 48.35),
(46, 'Bisoprolol', '5 mg', 'Oral', 'Fatigue, low blood pressure, dizziness', 57.42),
(47, 'Clopidogrel', '75 mg', 'Oral', 'Diarrhea, bleeding, nausea', 42.08),
(48, 'Hydralazine', '25 mg', 'Oral', 'Headache, dizziness, rapid heart rate', 28.11),
(49, 'Digoxin', '0.25 mg', 'Oral', 'Fatigue, nausea, visual disturbances', 94.33),
(50, 'Furosemide', '20 mg', 'Oral', 'Dizziness, dehydration, low potassium', 17.31),
(51, 'Spironolactone', '25 mg', 'Oral', 'Dizziness, high potassium levels, dehydration', 63.56),
(52, 'Verapamil', '80 mg', 'Oral', 'Constipation, dizziness, nausea', 75.89),
(53, 'Bleomycin', '15 mg', 'Injection', 'Fever, lung toxicity, nausea', 88.77),
(54, 'Vincristine', '2 mg', 'Injection', 'Hair loss, constipation, nerve damage', 26.16),
(55, 'Paclitaxel', '100 mg', 'Injection', 'Hair loss, nausea, neuropathy', 34.48),
(56, 'Fluorouracil', '5 mg/mL', 'Injection', 'Nausea, diarrhea, mouth sores', 83.94),
(57, 'Tamoxifen', '10 mg', 'Oral', 'Hot flashes, blood clots, fatigue', 36.27),
(58, 'Trastuzumab', '6 mg/kg', 'Injection', 'Nausea, headache, heart failure', 99.50),
(59, 'Capecitabine', '500 mg', 'Oral', 'Hand-foot syndrome, nausea, fatigue', 18.70),
(60, 'Imatinib', '100 mg', 'Oral', 'Fatigue, nausea, swelling', 55.02),
(61, 'Bortezomib', '3.5 mg/m²', 'Injection', 'Nausea, diarrhea, peripheral neuropathy', 28.98),
(62, 'Rituximab', '375 mg/m²', 'Injection', 'Infusion reactions, fever, chills', 59.84),
(63, 'Diphenhydramine', '12.5 mg/5 mL', 'Oral', 'Drowsiness, dry mouth, dizziness', 22.27),
(64, 'Hydrocortisone', '1% cream', 'Topical', 'Burning, itching, irritation', 11.83),
(65, 'Salbutamol', '100 mcg', 'Inhaler', 'Tremors, headache, fast heartbeat', 72.33);

INSERT INTO medications (medication_id, medication_name, dosage, medication_type, side_effects, cost) VALUES
(66, 'Dextromethorphan', '10 mg/5 mL', 'Oral', 'Drowsiness, nausea, dizziness', 46.17),
(67, 'Cefdinir', '250 mg', 'Oral', 'Diarrhea, nausea, rash', 93.87),
(68, 'Cephalexin', '500 mg', 'Oral', 'Upset stomach, diarrhea, rash', 50.83),
(69, 'Azelastine', '0.1%', 'Nasal Spray', 'Bitter taste, drowsiness, nasal irritation', 52.56),
(70, 'Methylprednisolone', '2 mg', 'Oral', 'Mood changes, weight gain, high blood sugar', 10.29),
(71, 'Montelukast', '10 mg', 'Oral', 'Headache, stomach pain, cough', 63.78),
(72, 'Loratadine', '10 mg', 'Oral', 'Drowsiness, headache, dry mouth', 98.01),
(73, 'Amoxicillin', '500 mg', 'Oral', 'Rash, diarrhea, nausea', 18.71),
(74, 'Ciprofloxacin', '500 mg', 'Oral', 'Nausea, diarrhea, headache', 59.54),
(75, 'Doxycycline', '100 mg', 'Oral', 'Nausea, photosensitivity, diarrhea', 51.56),
(76, 'Vancomycin', '1 gm', 'Injection', 'Red man syndrome, nausea, kidney toxicity', 69.18),
(77, 'Clindamycin', '300 mg', 'Oral', 'Diarrhea, nausea, rash', 91.23),
(78, 'Linezolid', '600 mg', 'Oral', 'Diarrhea, headache, nausea', 58.59),
(79, 'Levofloxacin', '500 mg', 'Oral', 'Dizziness, nausea, tendinitis', 99.27),
(80, 'Azithromycin', '250 mg', 'Oral', 'Diarrhea, nausea, abdominal pain', 40.59),
(81, 'Rifampin', '10 mg/kg', 'Oral', 'Liver damage, red-orange urine, nausea', 75.12),
(82, 'Metronidazole', '500 mg', 'Oral', 'Nausea, headache, metallic taste', 63.86),
(83, 'Methotrexate', '7.5 mg', 'Oral', 'Nausea, mouth sores, liver toxicity', 83.91),
(84, 'Hydroxychloroquine', '200 mg', 'Oral', 'Headache, nausea, visual disturbances', 37.98),
(85, 'Sulfasalazine', '500 mg', 'Oral', 'Upset stomach, rash, diarrhea', 18.17);

INSERT INTO medications (medication_id, medication_name, dosage, medication_type, side_effects, cost) VALUES
(86, 'Etanercept', '50 mg', 'Injection', 'Injection site reactions, headache, dizziness', 56.91),
(87, 'Adalimumab', '40 mg', 'Injection', 'Injection site reactions, upper respiratory infections', 40.04),
(88, 'Azathioprine', '50 mg', 'Oral', 'Nausea, liver toxicity, low blood cell count', 19.48),
(89, 'Leflunomide', '20 mg', 'Oral', 'Diarrhea, rash, liver toxicity', 57.29),
(90, 'Abatacept', '125 mg', 'Injection', 'Headache, injection site reactions, infections', 37.99),
(91, 'Tocilizumab', '162 mg', 'Injection', 'Headache, high blood pressure, diarrhea', 98.07),
(92, 'Anakinra', '100 mg', 'Injection', 'Injection site reactions, headache, nausea', 96.37),
(93, 'Losartan', '50 mg', 'Oral', 'Dizziness, upper respiratory infections, back pain', 87.66),
(94, 'Furosemide', '40 mg', 'Oral', 'Dizziness, dehydration, low potassium', 49.19),
(95, 'Erythropoietin', '1000 IU', 'Injection', 'Headache, joint pain, fever', 62.97),
(96, 'Calcium Carbonate', '500 mg', 'Oral', 'Constipation, stomach upset', 67.28),
(97, 'Alfacalcidol', '0.25 mcg', 'Oral', 'Hypercalcemia, nausea, dizziness', 47.48),
(98, 'Tacrolimus', '1 mg', 'Oral', 'Headache, nausea, kidney toxicity', 25.57),
(99, 'Sevelamer', '800 mg', 'Oral', 'Nausea, diarrhea, stomach pain', 65.39),
(100, 'Cinacalcet', '30 mg', 'Oral', 'Nausea, vomiting, low blood calcium', 60.25),
(101, 'Lanthanum Carbonate', '500 mg', 'Oral', 'Diarrhea, nausea, abdominal pain', 95.09),
(102, 'Mycophenolate Mofetil', '500 mg', 'Oral', 'Diarrhea, nausea, vomiting', 14.69);



-- APPOINTMENTS : 
INSERT INTO Appointments (appointment_id, patient_id, doc_id, appointment_date, appointment_time, reason_for_visit, appointment_status) VALUES
(1, 1, 3, '2024-11-29', '09:00:00', 'Routine check-up', 'Scheduled'),
(2, 1, 6, '2024-12-01', '10:30:00', 'Follow-up on blood pressure', 'Scheduled'),
(3, 2, 7, '2024-12-02', '11:00:00', 'Skin rash examination', 'Scheduled'),
(4, 3, 4, '2024-12-03', '12:00:00', 'Annual health check', 'Scheduled'),
(5, 4, 9, '2024-12-04', '09:00:00', 'Physical therapy', 'Scheduled'),
(6, 5, 2, '2024-12-05', '10:15:00', 'Flu symptoms', 'Scheduled'),
(7, 5, 7, '2024-12-06', '14:00:00', 'Injury recovery', 'Scheduled'),
(8, 6, 3, '2024-12-07', '09:30:00', 'Consultation for dizziness', 'Scheduled'),
(9, 7, 1, '2024-12-08', '10:45:00', 'Post-surgery follow-up', 'Scheduled'),
(10, 8, 5, '2024-12-09', '12:00:00', 'General consultation', 'Scheduled'),
(11, 8, 8, '2024-12-10', '14:30:00', 'Back pain treatment', 'Scheduled'),
(12, 9, 4, '2024-12-11', '11:15:00', 'Eye examination', 'Scheduled'),
(13, 10, 3, '2024-12-12', '13:30:00', 'Mental health therapy', 'Scheduled'),
(14, 11, 7, '2024-12-13', '15:00:00', 'Routine blood tests', 'Scheduled'),
(15, 12, 2, '2024-12-14', '09:30:00', 'Dental check-up', 'Scheduled'),
(16, 13, 6, '2024-12-15', '10:00:00', 'Back pain consultation', 'Scheduled'),
(17, 14, 9, '2024-12-16', '11:00:00', 'Respiratory check-up', 'Scheduled'),
(18, 15, 1, '2024-12-17', '12:15:00', 'Routine health check', 'Scheduled'),
(19, 16, 7, '2024-12-18', '14:00:00', 'Chronic pain management', 'Scheduled'),
(20, 17, 3, '2024-12-19', '15:30:00', 'Physical therapy follow-up', 'Scheduled'),

(21, 18, 2, '2024-12-20', '09:00:00', 'Routine health check-up', 'Scheduled'),
(22, 19, 6, '2024-12-21', '10:30:00', 'Consultation for dizziness', 'Scheduled'),
(23, 20, 3, '2024-12-22', '11:00:00', 'Mental health counseling', 'Scheduled'),
(24, 21, 4, '2024-12-23', '13:00:00', 'Eye surgery consultation', 'Scheduled'),
(25, 22, 7, '2024-12-24', '14:00:00', 'Neck pain consultation', 'Scheduled'),
(26, 23, 1, '2024-12-25', '15:30:00', 'Routine check-up', 'Scheduled'),
(27, 24, 5, '2024-12-26', '09:45:00', 'Dietary consultation', 'Scheduled'),
(28, 25, 8, '2024-12-27', '11:30:00', 'Knee pain treatment', 'Scheduled'),
(29, 26, 9, '2024-12-28', '12:00:00', 'Chronic cough management', 'Scheduled'),
(30, 27, 6, '2024-12-29', '13:15:00', 'Respiratory treatment', 'Scheduled'),
(31, 28, 3, '2024-12-30', '14:45:00', 'Cardiology consultation', 'Scheduled'),
(32, 29, 7, '2025-01-01', '09:00:00', 'Physical therapy', 'Scheduled'),
(33, 30, 2, '2025-01-02', '10:30:00', 'Vision check-up', 'Scheduled'),
(34, 31, 4, '2025-01-03', '12:00:00', 'Heart disease consultation', 'Scheduled'),
(35, 32, 1, '2025-01-04', '13:30:00', 'Family medicine consultation', 'Scheduled'),
(36, 33, 8, '2025-01-05', '14:15:00', 'Back pain consultation', 'Scheduled'),
(37, 34, 9, '2025-01-06', '15:00:00', 'Asthma treatment', 'Scheduled'),
(38, 35, 6, '2025-01-07', '09:00:00', 'Chronic pain management', 'Scheduled'),
(39, 36, 7, '2025-01-08', '10:45:00', 'Post-surgery follow-up', 'Scheduled'),
(40, 37, 2, '2025-01-09', '12:30:00', 'Diabetes management', 'Scheduled'),
(41, 38, 4, '2025-01-10', '14:00:00', 'Heart disease check-up', 'Scheduled'),
(42, 39, 5, '2025-01-11', '13:30:00', 'General consultation', 'Scheduled'),
(43, 40, 3, '2025-01-12', '15:00:00', 'Mental health therapy', 'Scheduled'),
(44, 41, 8, '2025-01-13', '16:00:00', 'Physical therapy', 'Scheduled'),
(45, 42, 9, '2025-01-14', '09:30:00', 'Pulmonary check-up', 'Scheduled'),
(46, 43, 6, '2025-01-15', '10:45:00', 'Consultation for dizziness', 'Scheduled'),
(47, 44, 7, '2025-01-16', '11:30:00', 'Arthritis treatment', 'Scheduled'),
(48, 45, 2, '2025-01-17', '13:00:00', 'Routine check-up', 'Scheduled'),
(49, 46, 5, '2025-01-18', '14:30:00', 'Nutritional counseling', 'Scheduled'),
(50, 47, 8, '2025-01-19', '15:00:00', 'Back injury consultation', 'Scheduled'),

(51, 48, 3, '2025-01-20', '09:00:00', 'Routine check-up', 'Scheduled'),
(52, 48, 4, '2025-01-21', '10:30:00', 'Cardiology consultation', 'Scheduled'),
(53, 49, 5, '2025-01-22', '11:00:00', 'Diet consultation', 'Scheduled'),
(54, 49, 2, '2025-01-23', '13:00:00', 'Eye exam', 'Scheduled'),
(55, 50, 7, '2025-01-24', '14:30:00', 'Physical therapy follow-up', 'Scheduled'),
(56, 51, 9, '2025-01-25', '15:00:00', 'Respiratory therapy', 'Scheduled'),
(57, 52, 3, '2025-01-26', '09:30:00', 'Routine health check', 'Scheduled'),
(58, 52, 6, '2025-01-27', '10:00:00', 'Neuropsychology evaluation', 'Scheduled'),
(59, 53, 8, '2025-01-28', '11:30:00', 'Orthopedic consultation', 'Scheduled'),
(60, 54, 7, '2025-01-29', '12:00:00', 'Physical therapy consultation', 'Scheduled'),
(61, 55, 1, '2025-01-30', '13:30:00', 'General check-up', 'Scheduled'),
(62, 56, 9, '2025-02-01', '14:15:00', 'Dialysis consultation', 'Scheduled'),
(63, 57, 6, '2025-02-02', '15:30:00', 'Respiratory evaluation', 'Scheduled'),
(64, 58, 4, '2025-02-03', '09:15:00', 'Cardiac follow-up', 'Scheduled'),
(65, 59, 8, '2025-02-04', '10:45:00', 'Back injury check-up', 'Scheduled'),
(66, 60, 5, '2025-02-05', '11:30:00', 'Nutritional counseling', 'Scheduled');



INSERT INTO prescriptions (prescription_id, patient_id, appointment_id, doc_id , medication_id, dosage, start_date, end_date, instructions, cost) VALUES
(1, 1, 1, 3, 1, '5 mg', '2024-11-29', '2024-12-29', 'Take one tablet every morning for high blood pressure', 23.69),
(2, 1, 2, 6, 2, '10 mg', '2024-12-01', '2024-12-31', 'Take one tablet daily for hypertension', 59.15),
(3, 2, 3, 7, 19, '500 mg', '2024-12-02', '2024-12-16', 'Take one tablet every 8 hours for bacterial infection', 96.91),
(4, 3, 4, 4, 10, '200 mg', '2024-12-03', '2025-01-03', 'Take as needed for pain relief, do not exceed 3 doses per day', 45.01),
(5, 4, 5, 9, 4, '50 mg', '2024-12-04', '2024-12-11', 'Inject one dose for acute inflammation, consult for follow-up', 75.93),
(6, 5, 6, 2, 18, '20 mg', '2024-12-05', '2024-12-19', 'Take one tablet at bedtime for cholesterol control', 73.77),
(7, 5, 7, 7, 7, '5 units', '2024-12-06', '2024-12-20', 'Inject one dose before meals to control blood sugar', 55.19),
(8, 6, 8, 3, 12, '1 mg', '2024-12-07', '2024-12-14', 'Take one tablet before sleep for anxiety management', 93.14),
(9, 7, 9, 1, 11, '50 mcg/hr', '2024-12-08', '2025-01-08', 'Apply one patch every 72 hours for chronic pain', 11.63),
(10, 8, 10, 5, 17, '2.5 mg', '2024-12-09', '2024-12-23', 'Use inhaler twice daily for asthma management', 57.32),
(11, 8, 11, 8, 20, '250 mg', '2024-12-10', '2024-12-24', 'Take one tablet daily for bacterial infection', 73.24),
(12, 9, 12, 4, 5, '15 mg', '2024-12-11', '2025-01-11', 'Take one tablet every week for rheumatoid arthritis', 85.65),
(13, 10, 13, 3, 6, '20 mg', '2024-12-12', '2025-01-12', 'Take one tablet daily for cancer prevention', 10.43),
(14, 11, 14, 7, 22, '500 mg', '2024-12-13', '2025-01-13', 'Take one tablet every night for seizure control', 97.60),
(15, 12, 15, 6, 1, '5 mg', '2024-12-14', '2025-01-14', 'Take one tablet in the morning for hypertension', 23.69),
(16, 13, 16, 2, 9, '0.3 mg', '2024-12-15', '2025-01-15', 'Inject as needed for allergic reaction symptoms', 97.81),
(17, 14, 17, 3, 21, '40 mg', '2024-12-16', '2025-01-16', 'Inject as directed for rheumatoid arthritis treatment', 65.46),
(18, 15, 18, 9, 12, '1 mg', '2024-12-17', '2025-01-17', 'Take one tablet in the morning for insomnia', 93.14),
(19, 16, 19, 7, 10, '200 mg', '2024-12-18', '2025-01-18', 'Take one tablet every 4-6 hours as needed for pain', 45.01),
(20, 17, 20, 3, 15, '0.3 mg', '2024-12-19', '2025-01-19', 'Take one tablet sublingually for chest pain relief', 60.23),
(21, 18, 21, 2, 17, '2.5 mg', '2024-12-20', '2025-01-20', 'Use inhaler twice daily for asthma control', 57.32),
(22, 19, 22, 6, 30, '20 mg', '2024-12-21', '2025-01-21', 'Take one tablet daily for anticoagulation therapy', 83.12),
(23, 20, 23, 3, 4, '50 mg', '2024-12-22', '2025-01-22', 'Take injection for post-surgery inflammation', 75.93),
(24, 21, 24, 5, 3, '12.5 mg', '2024-12-23', '2025-01-23', 'Take one tablet daily for blood pressure management', 34.68),
(25, 22, 25, 9, 2, '10 mg', '2024-12-24', '2025-01-24', 'Take one tablet daily for high blood pressure', 59.15),
(26, 23, 26, 1, 7, '5 units', '2024-12-25', '2025-01-25', 'Inject before meals for diabetes management', 55.19),
(27, 24, 27, 8, 13, '100 mg', '2024-12-26', '2025-01-26', 'Take one tablet for cough suppression', 60.79),
(28, 25, 28, 6, 8, '20 mg', '2024-12-27', '2025-01-27', 'Take one tablet daily for anti-inflammatory treatment', 54.68),
(29, 26, 29, 4, 19, '500 mg', '2024-12-28', '2025-01-28', 'Take one tablet every 6 hours for bacterial infection', 96.91),
(30, 27, 30, 9, 5, '15 mg', '2024-12-29', '2025-01-29', 'Take one tablet twice a day for joint inflammation', 85.65);





-- NURSES : 
SELECT * FROM DEPARTMENTS;

-- Insert 20 nurses with contact numbers within range 20
INSERT INTO Nurses (nurse_id, nurse_name, department, contact_number, email, hire_date, floor_no) VALUES
(1001, 'Sarah Johnson', 'Physical Therapy (PT)', '203-555-0011', 'sarah.johnson@hospital.com', '2022-01-15', 7),
(1002, 'James Smith', 'Radiology', '203-555-0012', 'james.smith@hospital.com', '2021-02-22', 4),
(1003, 'Patricia Brown', 'Psychiatry', '203-555-0013', 'patricia.brown@hospital.com', '2020-03-10', 5),
(1004, 'Michael Davis', 'Cardiology', '203-555-0014', 'michael.davis@hospital.com', '2023-07-08', 1),
(1005, 'Linda Garcia','Pediatric ICU (PICU)', '203-555-0015', 'linda.garcia@hospital.com', '2021-06-25', 6),
(1006, 'Robert Martinez', 'Neurosurgery', '203-555-0016', 'robert.martinez@hospital.com', '2020-08-12', 2),
(1007, 'Jennifer Wilson', 'Oncology', '203-555-0017', 'jennifer.wilson@hospital.com', '2023-04-01', 8),
(1008, 'David Moore', 'Infectious Disease', '203-555-0018', 'david.moore@hospital.com', '2022-02-10', 1),
(1009, 'Mary Taylor', 'General Surgery', '203-555-0019', 'mary.taylor@hospital.com', '2021-11-14', 2),
(1010, 'John Anderson', 'Addiction Medicine', '203-555-0020', 'john.anderson@hospital.com', '2024-01-07', 5),
(1011, 'Nancy Thomas', 'Neonatal ICU (NICU)', '203-555-0021', 'nancy.thomas@hospital.com', '2020-04-05', 6),
(1012, 'William Jackson', 'Orthopedic Surgery', '203-555-0022', 'william.jackson@hospital.com', '2023-03-25', 2),
(1013, 'Elizabeth White', 'Physical Therapy (PT)', '203-555-0023', 'elizabeth.white@hospital.com', '2021-07-19', 7),
(1014, 'Joseph Harris', 'Gastroenterology', '203-555-0024', 'joseph.harris@hospital.com', '2022-05-17', 1),
(1015, 'Susan Martin', 'Cardiothoracic Surgery', '203-555-0025', 'susan.martin@hospital.com', '2023-06-22', 2),
(1016, 'Charles Lee', 'Psychology', '203-555-0026', 'charles.lee@hospital.com', '2021-10-10', 5),
(1017, 'Jessica Allen', 'Breast Health', '203-555-0027', 'jessica.allen@hospital.com', '2022-12-15', 7),
(1018, 'Thomas King', 'Neurosurgery', '203-555-0028', 'thomas.king@hospital.com', '2023-09-01', 2),
(1019, 'Barbara Scott', 'Psychiatry', '203-555-0029', 'barbara.scott@hospital.com', '2020-10-28', 5),
(1020, 'Steven Young', 'Cardiology', '203-555-0030', 'steven.young@hospital.com', '2024-02-12', 1),

-- Insert the next 20 nurses with contact numbers within range 20
(1021, 'Jessica Walker', 'Neonatal ICU (NICU)', '203-555-0031', 'jessica.walker@hospital.com', '2023-03-14', 6),
(1022, 'Daniel Moore', 'Psychology', '203-555-0032', 'daniel.moore@hospital.com', '2022-06-11', 5),
(1023, 'Betty Gonzalez', 'Addiction Medicine', '203-555-0033', 'betty.gonzalez@hospital.com', '2020-12-17', 5),
(1024, 'Mark Martinez', 'Pediatric ICU (PICU)', '203-555-0034', 'mark.martinez@hospital.com', '2021-01-04', 6),
(1025, 'Andrew Rodriguez', 'Plastic Surgery', '203-555-0035', 'andrew.rodriguez@hospital.com', '2023-05-09', 2),
(1026, 'Nancy Perez', 'Reproductive Medicine', '203-555-0036', 'nancy.perez@hospital.com', '2020-07-24', 3),
(1027, 'Mary White', 'Pathology', '203-555-0037', 'mary.white@hospital.com', '2022-04-17', 4),
(1028, 'Henry Green', 'Neurosurgery', '203-555-0038', 'henry.green@hospital.com', '2021-12-01', 2),
(1029, 'Jack Adams', 'Radiology', '203-555-0039', 'jack.adams@hospital.com', '2023-11-18', 4),
(1030, 'Grace Hall', 'Orthopedic Surgery', '203-555-0040', 'grace.hall@hospital.com', '2020-03-30', 2),
(1031, 'Helen Harris', 'Neonatal ICU (NICU)', '203-555-0041', 'helen.harris@hospital.com', '2022-07-26', 6),
(1032, 'Joseph Garcia', 'Oncology', '203-555-0042', 'joseph.garcia@hospital.com', '2021-10-20', 8),
(1033, 'Christine Nelson', 'Cardiology', '203-555-0043', 'christine.nelson@hospital.com', '2023-08-01', 1),
(1034, 'Charles Martinez', 'Intensive Care Unit (ICU)', '203-555-0044', 'charles.martinez@hospital.com', '2020-05-22', 6),
(1035, 'Megan Taylor', 'Gastroenterology', '203-555-0045', 'megan.taylor@hospital.com', '2024-03-10', 1),
(1036, 'Emma Clark', 'Physical Therapy (PT)', '203-555-0046', 'emma.clark@hospital.com', '2021-02-07', 7),
(1037, 'Daniel Young', 'Rheumatology', '203-555-0047', 'daniel.young@hospital.com', '2022-09-04', 1),
(1038, 'Rachel Moore', 'Infectious Disease', '203-555-0048', 'rachel.moore@hospital.com', '2023-07-15', 1),
(1039, 'Alice Williams', 'Plastic Surgery', '203-555-0049', 'alice.williams@hospital.com', '2021-04-13', 2),
(1040, 'Edward Scott', 'Psychiatry', '203-555-0050', 'edward.scott@hospital.com', '2020-12-22', 5),

-- Insert the final 20 nurses with contact numbers within range 20
(1041, 'Samuel Harris', 'Neurosurgery', '203-555-0051', 'samuel.harris@hospital.com', '2022-11-08', 2),
(1042, 'Ashley Carter', 'Radiology', '203-555-0052', 'ashley.carter@hospital.com', '2023-06-30', 4),
(1043, 'Richard Thomas', 'Cardiology', '203-555-0053', 'richard.thomas@hospital.com', '2021-01-15', 1),
(1044, 'Deborah Walker', 'Neonatal ICU (NICU)', '203-555-0054', 'deborah.walker@hospital.com', '2022-10-02', 6),
(1045, 'Josephine Robinson', 'Physical Therapy (PT)', '203-555-0055', 'josephine.robinson@hospital.com', '2020-08-29', 7),
(1046, 'Thomas Evans', 'Cardiothoracic Surgery', '203-555-0056', 'thomas.evans@hospital.com', '2023-02-03', 2),
(1047, 'Natalie Scott', 'Infectious Disease', '203-555-0057', 'natalie.scott@hospital.com', '2020-06-12', 1),
(1048, 'Lauren Green', 'Oncology', '203-555-0058', 'lauren.green@hospital.com', '2021-04-28', 8),
(1049, 'Matthew King', 'Pediatric ICU (PICU)', '203-555-0059', 'matthew.king@hospital.com', '2023-03-20', 6),
(1050, 'Christine Adams', 'General Surgery', '203-555-0060', 'christine.adams@hospital.com', '2020-07-05', 2),
(1051, 'John Martinez', 'Cardiology', '203-555-0061', 'john.martinez@hospital.com', '2022-04-18', 1),
(1052, 'Paul Robinson', 'Addiction Medicine', '203-555-0062', 'paul.robinson@hospital.com', '2023-08-17', 5),
(1053, 'Amy Clark', 'General Surgery', '203-555-0063', 'amy.clark@hospital.com', '2021-12-30', 2),
(1054, 'Anthony White', 'Neonatal ICU (NICU)', '203-555-0064', 'anthony.white@hospital.com', '2023-09-05', 6),
(1055, 'Elizabeth Green', 'Rheumatology', '203-555-0065', 'elizabeth.green@hospital.com', '2020-05-06', 1),
(1056, 'Joshua Thomas', 'Orthopedic Surgery', '203-555-0066', 'joshua.thomas@hospital.com', '2023-01-17', 2),
(1057, 'Maria Scott', 'Nephrology', '203-555-0067', 'maria.scott@hospital.com', '2021-11-04', 0),
(1058, 'Douglas Hall', 'Plastic Surgery', '203-555-0068', 'douglas.hall@hospital.com', '2022-10-27', 2),
(1059, 'Grace Martinez', 'Cardiology', '203-555-0069', 'grace.martinez@hospital.com', '2024-01-21', 1),
(1060, 'Franklin Lee', 'Addiction Medicine', '203-555-0070', 'franklin.lee@hospital.com', '2023-04-06', 5);

INSERT INTO Nurses (nurse_id, nurse_name, department, contact_number, email, hire_date, floor_no) VALUES
(1061, 'Evan Nelson', 'Dialysis Unit', '203-555-0046', 'evan.nelson@hospital.com', '2023-03-11', 9),
(1062, 'Avery Carter', 'Kidney Transplantation', '203-555-0047', 'avery.carter@hospital.com', '2020-08-18', 9),
(1063, 'Ella Wilson', 'Liver Transplantation', '203-555-0048', 'ella.wilson@hospital.com', '2021-10-03', 9),
(1064, 'Carter Walker', 'Dialysis Unit', '203-555-0049', 'carter.walker@hospital.com', '2023-04-21', 9),
(1065, 'Mason Johnson', 'Liver Transplantation', '203-555-0050', 'mason.johnson@hospital.com', '2022-07-14', 9);





INSERT INTO assigned_nurse (assignment_id, patient_id, nurse_id, room_id, shift_time, assignment_date, notes)
VALUES
(1, 1, 1001, 1, 'Morning', '2024-11-29', 'Assigned to assist patient during initial admission process and ER procedures.'),
(2, 1, 1002, 1, 'Night', '2024-11-29', 'Assisted with emergency medical evaluations and monitoring patient status.'),
(3, 2, 1003, 1, 'Morning', '2024-12-02', 'Supported patient through primary care examination and initial tests.'),
(4, 3, 1004, 1, 'Afternoon', '2024-12-03', 'Assisted patient post-surgery and assisted with medication management.'),
(5, 4, 1005, 2, 'Night', '2024-12-04', 'Cared for patient in the Dialysis Unit, managing dialysis procedure.'),
(6, 5, 1006, 3, 'Morning', '2024-12-05', 'Managed patient admission and assisted with initial consultation in urgent care.'),
(7, 5, 1007, 3, 'Afternoon', '2024-12-06', 'Monitored patient and helped with medical tests in the primary care unit.'),
(8, 6, 1008, 4, 'Night', '2024-12-07', 'Supported emergency care and assisted in monitoring patient vital signs.'),
(9, 7, 1009, 5, 'Morning', '2024-12-08', 'Managed outpatient procedure and ensured proper post-procedure care.'),
(10, 8, 1010, 6, 'Afternoon', '2024-12-09', 'Assisted patient in endocrinology unit with medical evaluation and blood tests.'),
(11, 9, 1011, 7, 'Night', '2024-12-10', 'Assisted with nephrology evaluation and prepared patient for discharge.'),
(12, 10, 1012, 8, 'Morning', '2024-12-11', 'Assisted with orthopedic surgery preparation and post-surgery care.'),
(13, 11, 1013, 9, 'Afternoon', '2024-12-12', 'Supervised recovery after plastic surgery and monitored vital signs.'),
(14, 12, 1014, 10, 'Morning', '2024-12-13', 'Assisted with cardiology procedures and monitored cardiovascular condition.'),
(15, 13, 1015, 11, 'Night', '2024-12-14', 'Assisted with radiology exams and patient positioning for scans.'),
(16, 14, 1016, 12, 'Morning', '2024-12-15', 'Monitored pulmonology patient post-procedure and administered medication.'),
(17, 15, 1017, 13, 'Afternoon', '2024-12-16', 'Assisted with oncology therapy and monitored response to treatment.'),
(18, 16, 1018, 14, 'Night', '2024-12-17', 'Managed palliative care patient and ensured comfort during recovery.'),
(19, 17, 1019, 15, 'Morning', '2024-12-18', 'Assisted with gynecology examinations and post-procedure care.'),
(20, 18, 1020, 16, 'Afternoon', '2024-12-19', 'Assisted with neurosurgery procedures and ensured patient recovery monitoring.');

INSERT INTO billing (billing_id, patient_id, admission_id, amount, payment_status, payment_date, payment_method)
VALUES
(1, 1, 1, 12302.67, 'Completed', '2024-11-29', 'Credit Card'),
(2, 1, 2, 1029.66, 'Completed', '2024-12-01', 'Cash'),
(3, 2, 3, 5791.61, 'Completed', '2024-12-02', 'Insurance'),
(4, 3, 4, 1237.06, 'Completed', '2024-12-03', 'Credit Card'),
(5, 4, 5, 6155.54, 'Completed', '2024-12-04', 'Debit Card'),
(6, 5, 6, 529.60, 'Completed', '2024-12-05', 'Cash'),
(7, 5, 7, 5625.40, 'Completed', '2024-12-06', 'Insurance'),
(8, 6, 8, 12154.41, 'Completed', '2024-12-07', 'Credit Card'),
(9, 7, 9, 1080.72, 'Completed', '2024-12-08', 'Cash'),
(10, 8, 10, 1792.20, 'Completed', '2024-12-09', 'Debit Card'),
(11, 9, 11, 3526.57, 'Completed', '2024-12-10', 'Insurance'),
(12, 10, 12, 6950.12, 'Completed', '2024-12-11', 'Cash'),
(13, 11, 13, 6943.28, 'Completed', '2024-12-12', 'Credit Card'),
(14, 12, 14, 543.01, 'Completed', '2024-12-13', 'Debit Card'),
(15, 13, 15, 2207.37, 'Completed', '2024-12-14', 'Insurance'),
(16, 14, 16, 1255.30, 'Completed', '2024-12-15', 'Credit Card'),
(17, 15, 17, 3663.68, 'Completed', '2024-12-16', 'Cash'),
(18, 16, 18, 1478.18, 'Completed', '2024-12-17', 'Debit Card'),
(19, 17, 19, 1434.46, 'Completed', '2024-12-18', 'Insurance'),
(20, 18, 20, 5728.95, 'Completed', '2024-12-19', 'Cash');


-- queries
-- simple
SELECT * FROM FLOORS;
SELECT * FROM DEPARTMENTS order by floor_no;
SELECT * FROM DOCTORS;
SELECT * FROM PATIENTS;
SELECT * FROM APPOINTMENTS;
SELECT * FROM NURSES;
SELECT * FROM TESTS;
SELECT * FROM MEDICATIONS;

SELECT * FROM Prescriptions ;
SELECT * FROM Admissions;
SELECT * FROM procedures;
SELECT * FROM individual_patient_tests;
SELECT * FROM patient_procedures;
SELECT * FROM room;
SELECT * FROM assigned_nurse;
SELECT * FROM billing;


-- Retrieve the total number of patients admitted to each department:
SELECT dept_name, COUNT(patient_id) AS total_patients
FROM admissions
GROUP BY dept_name
ORDER BY total_patients DESC;


--  -- Get the number of appointments scheduled for each doctor:
SELECT d.doc_name, COUNT(a.appointment_id) AS total_appointments
FROM doctors d
LEFT JOIN appointments a ON d.doc_id = a.doc_id
GROUP BY d.doc_name
ORDER BY total_appointments DESC;

-- --  Get the count of patients admitted by each doctor:
SELECT d.doc_name, COUNT(a.patient_id) AS total_patients
FROM doctors d
JOIN admissions a ON d.doc_id = a.attending_doctor_id
GROUP BY d.doc_name
ORDER BY total_patients DESC;

-- -- List all medications with their side effects that cost less than $50:

SELECT medication_name, side_effects, cost
FROM medications
WHERE cost  < 50
ORDER BY cost DESC;



-- -- List all floors and the number of departments they host:
SELECT f.floor_no, COUNT(d.dept_name) AS total_departments
FROM floors f
LEFT JOIN departments d ON f.floor_no = d.floor_no
GROUP BY f.floor_no;



-- -- Find the average cost of procedures in each department

SELECT dept_name, AVG(cost) AS avg_procedure_cost
FROM procedures
GROUP BY dept_name
ORDER BY avg_procedure_cost DESC;


-- --  Find patients who have been assigned to more than one nurse:

SELECT patient_id, COUNT(DISTINCT nurse_id) AS total_nurses
FROM assigned_nurse
GROUP BY patient_id
HAVING total_nurses > 1;

-- -- Retrieve details of the doctors with no active appointments:

SELECT d.doc_id, d.doc_name, d.specialty, d.dept_name
FROM doctors d
LEFT JOIN appointments a ON d.doc_id = a.doc_id
WHERE a.appointment_id IS NULL;


-- Find patients who have appointments but have not been admitted
SELECT patient_id
FROM appointments
WHERE patient_id NOT IN (SELECT patient_id FROM admissions);


-- -- Identify rooms where the average patient billing exceeds $5,000

SELECT room_id
FROM room
WHERE room_id IN (SELECT room_id FROM admissions a
	JOIN billing b ON a.patient_id = b.patient_id
	GROUP BY room_id
	HAVING AVG(b.amount) > 4000
);




-- -- Retrieve the list of procedures conducted in departments located on the floor with the maximum number of departments

SELECT procedure_name, dept_name
FROM procedures
WHERE dept_name IN (SELECT dept_name FROM departments
WHERE floor_no = (SELECT floor_no FROM (SELECT floor_no, COUNT(*) AS dept_count FROM departments
GROUP BY floor_no) AS subquery
ORDER BY dept_count DESC
LIMIT 1));

-- Patients who have booked appointments but were not admitted to the hospital.
SELECT patient_id
FROM appointments
WHERE patient_id NOT IN (SELECT patient_id FROM admissions);

-- -- Find patients who are assigned to more than one nurse and have had tests costing over $100

SELECT patient_id
FROM assigned_nurse
GROUP BY patient_id
HAVING COUNT(DISTINCT nurse_id) > 1
AND patient_id IN (SELECT patient_id
                   FROM individual_patient_tests
                   WHERE cost > 100);
--                    
-- -- Find patients who are assigned to more than one nurse and have had tests costing over $100

SELECT patient_id
FROM assigned_nurse
GROUP BY patient_id
HAVING COUNT(DISTINCT nurse_id) > 1
AND patient_id IN (SELECT patient_id
                   FROM individual_patient_tests
                   WHERE cost > 100);


-- -- Find the patients assigned to nurses who have shifts in "Night"

SELECT p.patient_id, CONCAT(p.first_name, ' ', p.last_name) AS full_name
FROM patients p
WHERE p.patient_id IN (SELECT patient_id
                       FROM assigned_nurse
                       WHERE shift_time LIKE '%Night%');



-- -- Find the floors that host more than 2 departments

SELECT floor_no, COUNT(dept_name) AS total_departments
FROM departments
GROUP BY floor_no
HAVING COUNT(dept_name) > (SELECT COUNT(*) FROM departments WHERE floor_no = 2);


