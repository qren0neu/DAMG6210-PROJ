CREATE TRIGGER patient_update_backup BEFORE UPDATE ON patient FOR EACH ROW
  INSERT INTO patient_record
  VALUES
    (null, old.pkPatient, old.fname, old.lname, old.dateOfBirth, old.phone, old.email, old.password, 'u', now());