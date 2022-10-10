CREATE VIEW `topmedicinesellerview` AS 
select count(`mo`.`pkOrder`) AS `orderCount`,
`f`.`name` AS `medicineFactor`,
sum(`mo`.`quantity`) AS `totalQuantity`,
(sum((`mo`.`itemPrice` * `mo`.`quantity`)) DIV 1) AS `turnover` 
from ((`medicine_order` `mo` 
	join `medicine` `m` 
	on((`mo`.`fkMedicine` = `m`.`pkMedicine`))) 
join `factory` `f` 
on((`f`.`pkFactory` = `mo`.`fkFactory`))) 
group by `medicineFactor` 
order by `orderCount` desc