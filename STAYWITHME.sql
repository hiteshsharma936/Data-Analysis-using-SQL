use staywithmedata;

select * from Customerss;
select * from hotelss;
select * from staywithme;
---- Question: What is the overall trend in monthly bookings over the past year? ------

select month(Check_In_Date) as Month, count(Booking_ID) as Total_bookings    from staywithme group by month(Check_In_Date)
order by month(Check_In_Date);

 ---- Question: What is the average star rating for each hotel? which hotel(S) have the highest average rating

select avg(a.customer_Rating) as Average_Rating, b.Hotel_Name from staywithme a inner join hotelss b 
on a.Hotel_ID = b.Hotel_ID group by b.Hotel_Name order by  avg(a.customer_Rating) desc;


---- Question: Which room types are the most popular among customers? ----

select count(Booking_ID) as Total_Bookings, Room_Type from staywithme group by Room_Type order by count(Booking_ID) desc ;

----Question: How many customers are enrolled in the loyalty program, and how does it correlate with their booking frequency?----

select count(distinct(a.Customer_ID)) as Total_customers, count(a.Booking_ID) as Total_Bookings,b.Loyalty_Program_Status from
staywithme a inner join customerss b on a.Customer_ID = b.Customer_ID group by Loyalty_Program_Status having
Loyalty_Program_Status = 'Platinum' or Loyalty_Program_Status= 'Silver' or Loyalty_Program_Status= 'Gold' 
order by Loyalty_Program_Status;

----Question: Which customers have more than 1 bookings, and what is their contact information?----

with cte
as
(select count(a.Customer_ID) as NumOfBooking,a.Customer_ID from staywithme a 
group by a.Customer_ID having count(a.Customer_ID)>1) 

select  x.Customer_ID, y.Name,x.NumOfBooking, y.Contact_Info from cte x inner join customerss y on x.Customer_ID = Y.Customer_ID
ORDER BY x.Customer_ID;

----Question: On which days of the week do hotels experience the highest booking activity?----

select datename(w,Check_In_Date) as Weekday,count(Booking_ID) as Total_Bookings from staywithme group by DATENAME(w,Check_In_Date)
order by Total_Bookings Desc;

----Question: Who are the top 5 customers with the highest number of bookings, and what is their loyalty program status?----

with cte 
as
(select count(a.Customer_ID) as Total_Bookings,a.Customer_ID from staywithme a
  group by a.Customer_ID)
  
select top 5 a.Customer_ID,b.Name,a.Total_Bookings,b.Loyalty_Program_Status from cte a inner join customerss b on a.Customer_ID = b.Customer_ID
 order by Total_Bookings desc; 

----Question: Which city have a most number of bookings?----

with cte 
as
(select count(a.Hotel_ID) as Total_Bookings,a.Hotel_ID from staywithme a
  group by a.Hotel_ID)
  
select top 1 b.Location_City,a.Total_Bookings from cte a inner join hotelss b on a.Hotel_ID = b.Hotel_ID
 order by Total_Bookings desc; 

-------------------------------------------------THE END-----------------------------------------------------------------