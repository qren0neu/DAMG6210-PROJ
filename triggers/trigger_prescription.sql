CREATE TRIGGER `invoicePres` BEFORE INSERT ON `prescription` 
FOR EACH ROW 
BEGIN
  set @presMoney = ((select price from medicine where pkMedicine = new.fkMedicine) * new.quantity);
  insert into invoice values (null, date(now()), adddate(now(), interval 2 month), 'a', @presMoney, 'u');
  set new.fkInvoice = LAST_INSERT_ID();
END