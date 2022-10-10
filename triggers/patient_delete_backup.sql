CREATE TRIGGER patient_delete_backup BEFORE DELETE ON patient FOR EACH ROW
  INSERT INTO patient_record
  VALUES
    (null, old.pkPatient, old.fname, old.lname, old.dateOfBirth, old.phone, old.email, old.password);