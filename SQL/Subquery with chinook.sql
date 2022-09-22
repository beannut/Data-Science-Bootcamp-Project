select 
    Germany_cus.CustomerId,
    Germany_cus.Firstname,
    Germany_cus.Lastname,
    Germany_cus.Phone,
    Germany_cus.Email,
    ROUND(sum(invoice_items.Quantity), 2) Total_Quantity,
    ROUND(sum(invoices.total), 2) Total_invoice
from (select *
from customers
where Country = 'Germany') as Germany_cus
join invoices on Germany_cus.CustomerId =  invoices.CustomerId
join invoice_items on invoices.Invoiceid = invoice_items.Invoiceid
group by 1, 2, 3
order by 7 desc ;

select
    tracks.Name,
    genres_name.Name,
    ROUND(sum(invoices.total), 2) Total_invoice
from (select *
from genres
where name = 'Heavy Metal') as genres_name
join tracks on tracks.genreId = genres_name.genreId
join invoice_items on tracks.Trackid = invoice_items.Trackid
join invoices on invoice_items.Invoiceid = invoices.Invoiceid
group by 2
order by 3 desc ; 
