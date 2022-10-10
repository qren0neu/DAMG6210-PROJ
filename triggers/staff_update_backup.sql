CREATE TRIGGER staff_update_backup BEFORE update ON staff FOR EACH ROW
  INSERT INTO staff_record
  VALUES
    (null, old.pkStaff, old.fname, old.lname, old.dateOfBirth, old.phone, old.email, old.password, old.type, now(), old.jobTitle, old.salary, old.bankaccount, 'u');