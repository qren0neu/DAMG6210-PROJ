create view patientWithMedicinePaymentView as 
select concat(p.fname, " ", p.lname) as patientName, 
i.`date` as inquiryDate,
m.medicineName as medicine, 
concat(s.fname, " ", s.lname) as doctorName,
iv.price as medicinePayment
from patient p
inner join inquiry i
on p.pkPatient = i.fkPatient
inner join doctor d
on i.fkDoctor = d.pkDoctor
inner join staff s
on d.fkStaff = s.pkStaff
inner join diagnosis di
on di.fkInquiry = i.pkInquiry
inner join prescription ps
on ps.fkDiagnose = di.pkDiagonsis
inner join medicine m
on ps.fkMedicine = m.pkMedicine
inner join invoice iv
on ps.fkInvoice = iv.pkInvoice