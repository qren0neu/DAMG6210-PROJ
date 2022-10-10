create view topDeviceSellerView as
SELECT count(pkOrder) as orderCount, 
p.`name` as producerName,
sum(deo.quantity) as totalQuantity,
sum(deo.itemPrice * deo.quantity) DIV 1 as turnover
FROM device_order as deo
inner join producer p
on deo.fkProducer = p.pkProducer
inner join device d
on deo.fkDevice = d.pkDevice
group by p.`name`
order by orderCount desc