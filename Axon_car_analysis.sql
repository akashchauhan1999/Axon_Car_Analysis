use classicmodels;

# 1 what are the total number of orders?
select count(*) as Total_orders from orders;


# 2 which customer has the highest credit limit?

select  customername, country, creditlimit from customers order by creditlimit desc limit 5;

# 3 Which 5 product which has the highest sale in terms of quantity sold?

select  productname, sum(quantityOrdered) as total_ordered from orderdetails OD
inner join products P on P.productCode = OD.productcode group by productname
order by total_ordered desc limit 5 ;


# 4 Retrieve the top 10 products by total revenue:
       
  select productName, SUM(quantityOrdered * priceEach) as total_revenue from orderdetails OD
  inner join products P on OD.productCode = P.productCode
  group by productName order by total_revenue desc limit 10;
       

# 5 how many times a sales represntative have done sales

select  salesrepemployeenumber, concat(firstname, space(2), lastname) as Full_name, jobtitle, email, count(*) as Occurences from  customers C
inner join employees E on C.salesRepEmployeeNumber = E.employeeNumber 
 group by salesRepEmployeeNumber order by occurences desc limit 5;
 
 
 
 # 6 Top 5 salesrepemployeenumber who have done the highest amount of sales 

select salesrepemployeenumber, sum(amount) as Sales_amount from customers C 
inner join payments P on P.customernumber = C.customernumber
group by salesRepEmployeeNumber order by sales_amount desc limit 5;


 
# 7 Top 10  customers who spent the highest amount

select C.customernumber, customername, sum(amount) as Total_Amount_spent from payments P 
inner join customers C on P.customerNumber = C.customernumber
group by customernumber order by Total_Amount_spent desc limit 10;


# 8 Estimated Delivery  time and what amount paid on ordernumber through productname

select O.ordernumber,P.productcode, productname, quantityOrdered, (quantityOrdered * priceEach) as Total_Amount_Paid, 
 datediff(shippedDate,orderdate) as Delivery_time from orders O
inner join orderdetails OD on O.ordernumber = OD.ordernumber
inner join products P on P.productCode = OD.productCode order by ordernumber;
 
 # 9 Retrieve the sales reps and their associated customers:

select concat(firstname, space(2), lastname) as Sales_rep, customername from employees E 
inner join customers C on C.salesRepEmployeeNumber = E.employeeNumber order by Sales_rep;
      
 
#10 Retrieve the total revenue by product line for a given year:


select PL.Productline, sum(quantityordered * priceeach) as total_revenue from orderdetails OD
inner join products P on P.productCode = OD.productCode
inner join productlines PL on PL.productLine = P.productline
inner join orders O on O.ordernumber = OD.ordernumber
where year(O.orderdate) = '2004'
group by PL.productLine order by total_revenue desc;