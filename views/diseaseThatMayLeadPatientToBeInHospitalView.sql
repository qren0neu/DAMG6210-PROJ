create view diseaseThatMayLeadPatientToBeInHospitalView as
select concat(p.fname, " ", p.lname) as patientName, 
i.`date` as inquiryDate,
concat(s.fname, " ", s.lname) as doctorName,
des.diseaseName as diseaseName
from patient p
inner join inquiry i
on p.pkPatient = i.fkPatient
inner join doctor d
on i.fkDoctor = d.pkDoctor
inner join staff s
on d.fkStaff = s.pkStaff
inner join diagnosis di
on di.fkInquiry = i.pkInquiry
inner join hospitalization hos
on hos.fkPatient = p.pkPatient
inner join disease des
on di.fkDisease = des.pkDisease