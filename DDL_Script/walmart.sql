set search_path to public;
create schema walmart;
set search_path to walmart;


CREATE TABLE Employee(
employee_id varchar (20)  NOT NULL,
employee_name varchar (20) NOT NULL,
employee_contact int   NOT NULL ,         
employee_dob  date  NOT NULL,
employee_email varchar(50)  NOT NULL,
employee_address varchar(50)  NOT NULL,
gender  VARCHAR(10) NOT NULL      check (gender = 'female' or gender='male'),
PRIMARY KEY (employee_id)
);

CREATE TABLE OfferDetails(
offers_id varchar(50)  NOT NULL,
offers_type varchar(50)  NOT NULL,
offers_details varchar(50)  NOT NULL,
offers_start_date date  NOT NULL,
offers_end_date date  NOT NULL,
PRIMARY KEY (offers_id)
    );





CREATE TABLE CustomerType(
type_id varchar(6)  NOT NULL,
type_name varchar(20)  NOT NULL,
PRIMARY KEY (type_id)    
 ) ;
    
CREATE TABLE Customer(
customer_id varchar(10)  NOT NULL,
customer_name varchar(50)  NOT NULL,
customer_contact int    NOT NULL,
date_of_birth  date  NOT NULL,            
email varchar(50)  NOT NULL,
address varchar(50)  NOT NULL,
gender VARCHAR(20)    NOT NULL check (gender = 'female' or gender='male'),
customer_type_id varchar(6)  NOT NULL,
membership_to date  NOT NULL,
membership_to_from  date  NOT NULL,    
PRIMARY KEY (customer_id),
FOREIGN KEY (customer_type_id) REFERENCES CustomerType(type_id)    
                                                                           ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE Warehouse(
warehouse_no varchar(20)  ,
warehouse_name varchar(50)  ,
PRIMARY KEY (warehouse_no)
); 
    
  
CREATE TABLE Block(
block_id VARCHAR(2)  NOT NULL,
block_name varchar(50)  NOT NULL,
block_incharge_id  varchar(50)  NOT NULL,
PRIMARY KEY (block_id),
FOREIGN KEY (block_incharge_id) REFERENCES Employee(employee_id)  
                                                                           ON DELETE SET NULL ON UPDATE CASCADE
    );  
  
CREATE TABLE Category(
category_id varchar(6)  NOT NULL,
category_name varchar(50)  NOT NULL,
store_id varchar(2)  NOT NULL,
warehouse_no varchar(20) ,
PRIMARY KEY (category_id) ,
FOREIGN KEY (store_id) REFERENCES Block(block_id),
FOREIGN KEY (warehouse_no) REFERENCES Warehouse(warehouse_no)
);



    
CREATE TABLE  PaymentMode(
payment_mode_id varchar(6)  NOT NULL,
mode_of_payment varchar(20)  NOT NULL,
offer_id varchar(50)  NOT NULL,
PRIMARY KEY (payment_mode_id) ,
FOREIGN KEY (offer_id) REFERENCES OfferDetails(offers_id)
                                                                                 ON DELETE SET NULL ON UPDATE CASCADE
);    

CREATE TABLE  InvoiceDetails(
inv_id varchar(20)  NOT NULL,
cust_id varchar(20)  NOT NULL,
amount float  NOT NULL,
inv_date  date   NOT NULL,
payment_mode_id varchar(6)  NOT NULL,
cashier_id varchar(10)  NOT NULL,
PRIMARY KEY (inv_id)  ,
FOREIGN KEY (payment_mode_id) REFERENCES PaymentMode(payment_mode_id)
                                                                                 ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (cashier_id) REFERENCES Employee(employee_id)
                                                                                 ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (cust_id) REFERENCES Customer (customer_id)
										 ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE  Product(
product_id varchar(20)  NOT NULL,
product_type varchar(50)  NOT NULL,
brand varchar(20)  NOT NULL,
cost_price float  NOT NULL,
weight varchar(20)  NOT NULL,
selling_price float  NOT NULL,
category_id varchar(6)  NOT NULL,
offer_id  varchar(50) NOT NULL,
block_count int NOT NULL,
warehouse_count int NOT NULL,
 PRIMARY KEY (product_id),   
FOREIGN KEY (offer_id) REFERENCES OfferDetails(offers_id)    
                                                                                ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (category_id) REFERENCES Category(category_id)
                                                                                ON DELETE SET NULL ON UPDATE CASCADE
);          

CREATE TABLE Buys(
product_id varchar(20)  NOT NULL,
invoice_id varchar(20)  NOT NULL,
quantity int  NOT NULL,
cost float Not NULL,  
PRIMARY KEY (product_id,invoice_id),                 
FOREIGN KEY (product_id) REFERENCES Product(product_id)
                                                                                  ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (invoice_id) REFERENCES InvoiceDetails(inv_id)
                                                                                  ON DELETE SET NULL ON UPDATE CASCADE
);  

CREATE TABLE Feedback(
review_id varchar(20)  NOT NULL,
review_text VARCHAR(50)  NOT NULL,
rating int  NOT NULL,
review_date date  NOT NULL,
cust_id varchar(20)  NOT NULL,
invoice_id varchar(20) NOT NULL,
PRIMARY KEY (review_id),   
FOREIGN KEY (cust_id) REFERENCES Customer(customer_id)
                                                                                 ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (invoice_id) REFERENCES InvoiceDetails(inv_id)
                                                                                 ON DELETE SET NULL ON UPDATE CASCADE   
);

     
CREATE TABLE ReturnSlip(
slip_no varchar(20)  NOT NULL, 
    inv_id varchar(20)  NOT NULL,
product_id varchar(20)  NOT NULL,
quantity  int  NOT NULL check(quantity>0),
return_date date NOT NULL,

PRIMARY KEY (slip_no,product_id),
FOREIGN KEY (product_id) REFERENCES Product(product_id)
                                                                                ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (inv_id) REFERENCES InvoiceDetails(inv_id)
                                                                                ON DELETE SET NULL ON UPDATE CASCADE
);

insert into CustomerType values('CT00S','Silver');
insert into CustomerType values('CT00G','Gold');
insert into CustomerType values('CT00P','Platinum');
insert into CustomerType values('CT0PR','Premium');


INSERT into Employee values('EMP1001','Mahesh Jha','72015478','1978-05-01','mahesh.jha@gmail.com','R.K.Puram','male');
INSERT into Employee values('EMP1002','Sunil Kumar','78621365','1979-01-02','sunilkumar@gmail.com','Rohini','male');
INSERT into Employee values('EMP1003','Niranjan Choudary','83473419','1995-02-13','nkc696@gmail.com','Kailash Nagar','male');
INSERT into Employee values('EMP2001','Shashi Kapoor','98751235','1986-05-07','shashi.kap@gmail.com','Pritampura','male');
INSERT into Employee values('EMP2002','Anjana Singh','87465354','1975-05-06','anjana0605@gmail.com','Rohini','female');
INSERT into Employee values('EMP2003','Degangna Suryavanshi','85219932','1990-02-14','surya.deganga@hotmail.com','Hauz Khas','female');
INSERT into Employee values('EMP2004','Mahima Arora','94620856','1993-01-15','mahima.arora93@gmail.com','Pragati Maidan','female');
INSERT into Employee values('EMP1004','Pragya Richa','84561732','1991-05-05','richa.pragya@hotmail.com','R.K.Puram','female');
INSERT into Employee values('EMP2005','Siddharth Shrivastav','85473215','1990-06-09','sid.shri@gmail.com','Pragati Maidan','male');
INSERT into Employee values('EMP1005','Akash Agarwal','78954635','1987-05-07','coolhunk@gmail.com','Kailash Nagar','male');
INSERT into Employee values('EMP2006','Yash Kumar','84652179','1988-08-15','yash.singh@gmail.com','Dwarka','male');
INSERT into Employee values('EMP1006','Rimmi Sinha','78958978','1985-11-09','rimi.babes@gmail.com','Rohini','female');
INSERT into Employee values('EMP1007','Kajal Kumari','89547231','1987-05-07','kajalk@gmail.com','Alaknanda','female');
INSERT into Employee values('EMP1010','Abhishek Sharma','94785123','1975-11-25','coolabhi@gmail.com','Defence Colony','male');
INSERT into Employee values('EMP1009','Rajat Kapoor','84569254','1984-08-04','rajatkapoor@gmail.com','Janakpuri','male');
INSERT into Employee values('EMP1008','Saurav Singh','95462154','1987-05-06','sauravsingh56@gmail.com','Karol Bagh','male');

INSERT into Block values('A1','Grocery','EMP1001');
INSERT into Block values('B1','Men Fashion','EMP1002');
INSERT into Block values('A2','Daily Needs','EMP1003');
INSERT into Block values('C1','Electronics','EMP1004');
INSERT into Block values('C2','Dining & Serving','EMP1005');
INSERT into Block values('B2','Women Fashion','EMP1006');
INSERT into Block values('B3','Kids Wear','EMP1007');
INSERT into Block values('C3','Stationary','EMP1008');
INSERT into Block values('B4','Footwear','EMP1009');
INSERT into Block values('B5','Watches','EMP1010');



INSERT into OfferDetails values('OFF10','Discount','10 %off','2016-01-01','2017-03-31');
INSERT into OfferDetails values('THREE+ONE','Bonanza','Buy 3 product and get one free','2016-05-01','2017-09-28');
INSERT into OfferDetails values('SUMMER25','Summer offer','25% off','2016-03-05','2016-05-28');
INSERT into OfferDetails values('WINTER20','Winter offer','20% off','2016-11-01','2017-02-28');
INSERT into OfferDetails values('SUMMER5','Summer offer','5% off','2016-03-01','2016-06-28');
INSERT into OfferDetails values('WINTER5','Winter offer','5% off','2016-11-01','2017-02-28');
INSERT into OfferDetails values('KHUSIWALIDIWALI','Diwali offer','15% off','2016-10-01','2016-10-20');
INSERT into OfferDetails values('RANGBHARIHOLI','Holi offer','15% off','2017-03-01','2017-03-20');
INSERT into OfferDetails values('CASH10','Cash payment offer','10% off','2016-01-01','2017-03-31');
INSERT into OfferDetails values('CREDIT5','Credit card offer','5% off','2016-01-01','2017-03-31');
INSERT into OfferDetails values('DEBIT5','Debit card offer','5% off','2016-01-01','2017-03-31');
INSERT into OfferDetails values('PAYTM8','Paytm offer','8% off','2016-01-01','2017-03-31');

INSERT into PaymentMode values('PAY001','Cash','CASH10');
INSERT into PaymentMode values('PAY002','Credit card','CREDIT5');
INSERT into PaymentMode values('PAY003','Debit card','DEBIT5');
INSERT into PaymentMode values('PAY004','Paytm','PAYTM8');

INSERT into Warehouse values('WARA001','AWARE');
INSERT into Warehouse values('WARA002','BWAR');
INSERT into Warehouse values('WARA003','CWAR');
INSERT into Warehouse values('WARB001','DWAR');
INSERT into Warehouse values('WARB002','EWAR');
INSERT into Warehouse values('WARC001','FWAR');
INSERT into Warehouse values('WARC002','GWAR');
INSERT into Warehouse values('WARC003','HWAR');




insert into Customer values('CTM00001','Mahesh','96548245','2000-11-23','maheshpunk@gmail.com','rohini','male','CT00S','2016-12-10','2017-12-10');
insert into Customer values('CTM00002','Rakesh','96545489','1998-07-13','rakeshrap@gmail.com','cannaught palace','male','CT00G','2016-05-17','2019-05-17');
insert into Customer values('CTM00003','Shanti','86544759','1996-10-28','shanti203@gmail.com','pitampura','female','CT00G','2015-12-05','2018-12-05');
insert into Customer values('CTM00004','Vimla','92512549','1994-10-11','vimlakanti@gmail.com','india gate','female','CT00P','2012-07-10','2017-07-10');
insert into Customer values('CTM00005','Ahmad','84824589','2000-09-11','ahmadkhan11@gmail.com','pragati maidan','male','CT00S','2016-10-15','2017-10-15');
insert into Customer values('CTM00006','Vikash','96618554','1998-02-13','vikashhero@gmail.com','rohini','male','CT00S','2016-11-11','2017-11-11');
insert into Customer values('CTM00007','kalika','87521452','2001-12-22','kalikaomg@gmail.com','dwarka','female','CT00S','2016-08-05','2017-08-05');
insert into Customer values('CTM00008','karan','80821452','1991-10-20','karank102@gmail.com','cannaught palace','male','CT0PR','2011-09-26','2019-09-26');
insert into Customer values('CTM00009','Vipul','88548887','1992-03-29','singhvipul@gmail.com','noida','male','CT0PR','2014-06-15','2022-06-15');
insert into Customer values('CTM00010','Akhilesh','94547212','2000-10-23','akhilesh887@gmail.com','rohini','male','CT00S','2016-12-10','2017-12-10');
insert into Customer values('CTM00011','Raman','91541587','1998-09-13','ramanji87p@gmail.com','cannaught palace','male','CT00G','2016-05-17','2019-05-17');
insert into Customer values('CTM00012','Sita','76524775','1996-12-28','sita5487@gmail.com','pitampura','female','CT00G','2015-12-05','2018-12-05');
insert into Customer values('CTM00013','Kavita','95812573','1994-11-11','kvgood12@gmail.com','india gate','female','CT00P','2012-07-10','2017-07-10');
insert into Customer values('CTM00014','Vijay','94584581','2000-10-11','vijay11@gmail.com','pragati maidan','male','CT00S','2016-10-15','2017-10-15');
insert into Customer values('CTM00015','kamlesh','98624774','1998-01-13','kamk78@gmail.com','rohini','male','CT00S','2016-11-11','2017-11-11');
insert into Customer values('CTM00016','Radha','97548475','2001-10-22','radhakrishna09@gmail.com','dwarka','female','CT00S','2016-08-05','2017-08-05');
insert into Customer values('CTM00017','Manish','92821112','1991-12-20','manimonk102@gmail.com','cannaught palace','male','CT0PR','2013-09-26','2021-09-26');
insert into Customer values('CTM00018','Prem','89821845','1992-01-28','prempuri41@gmail.com','noida','male','CT0PR','2014-06-17','2022-06-17');
insert into Customer values('CTM00024','Ghanshyam','89821845','1993-01-28','gnm00841@gmail.com','noida','male','CT0PR','2014-06-17','2022-06-17');
insert into Customer values('CTM00037','Manoj','89221845','1990-02-18','manoj2541@gmail.com','noida','male','CT0PR','2014-06-17','2022-06-17');
insert into Customer values('CTM00044','Prashant','89821445','1995-01-28','pc41@gmail.com','punjabi bagh','male','CT00S','2014-06-17','2015-06-17');
insert into Customer values('CTM00031','Biswas','89821841','1990-11-28','biswas41@gmail.com','noida','male','CT0PR','2014-06-17','2022-06-17');
insert into Customer values('CTM00034','Ajay','89821995','1994-11-08','ajay41@gmail.com','noida','male','CT0PR','2014-06-17','2022-06-17');
insert into Customer values('CTM00040','Hemaant','89811845','1993-03-28','hmoi41@gmail.com','noida','male','CT0PR','2014-06-17','2022-06-17');
insert into Customer values('CTM00039','jayesh','89833345','1990-04-23','jayesh401@gmail.com','noida','male','CT00S','2015-06-17','2016-06-17');
insert into Customer values('CTM00041','Bhawesh','89833315','1991-04-23','bhawesh411@gmail.com','noida','male','CT00S','2014-06-17','2015-06-17');
insert into Customer values('CTM00022','keyur','89133345','1990-05-13','keyur401@gmail.com','noida','male','CT00S','2014-06-17','2015-06-17');
insert into Customer values('CTM00019','rayesh','89832245','1989-01-23','rayesh301@gmail.com','rohini','male','CT00S','2014-06-17','2015-06-17');


INSERT into Category values('GRO001','Fruits & Vegetables','A1','WARA001');
INSERT into Category values('GRO002','Spices','A1','WARB001');
INSERT into Category values('GRO003','Dry Fruits','A1','WARC003');
INSERT into Category values('GRO004','Rice & Pulses','A1','WARC002');
INSERT into Category values('GRO005','Oils','A1','WARB001');
INSERT into Category values('DN001','Soaps & Detergents','A2','WARC001');
INSERT into Category values('DN002','Coffee, Tea & Beverages','A2','WARB002');
INSERT into Category values('DN003','Fragrances','A2','WARC001');
INSERT into Category values('MF001','Men Shirts','B1','WARA003');
INSERT into Category values('MF002','Men Trousers','B1','WARC002');
INSERT into Category values('MF003','Men Innerwear','B1','WARB001');
INSERT into Category values('WF001','Women Tops','B2','WARC002');
INSERT into Category values('WF002','Women Jeans','B2','WARB002');
INSERT into Category values('WF003','Women Kurti','B2','WARC001');
INSERT into Category values('WF004','Lingerie','B2','WARA002');
INSERT into Category values('KW001','Tops & Tees','B3','WARC003');
INSERT into Category values('KW002','Baby Jeans','B3','WARB002');
INSERT into Category values('KW003','Kids Ethnic Wear','B3','WARC002');
INSERT into Category values('FW001','Men Footwear','B4','WARC001');
INSERT into Category values('FW002','Women Footwear','B4','WARB001');
INSERT into Category values('FW003','Kids Footwear','B4','WARA002');
INSERT into Category values('CLK001','Men Watches','B5','WARA003');
INSERT into Category values('CLK002','Women Watches','B5','WARA002');
INSERT into Category values('CLK003','Kids Watches','B5','WARA001');
INSERT into Category values('ELC001','Smartphones','C1','WARC001');
INSERT into Category values('ELC002','Tablets','C1','WARB002');
INSERT into Category values('ELC003','Laptop','C1','WARC002');
INSERT into Category values('ELC004','LED Television','C1','WARA001');
INSERT into Category values('ELC005','Speaker , Woofer & MP3 player','C1','WARA001');
INSERT into Category values('DNG001','TableWare','C2','WARA001');
INSERT into Category values('DNG002','Storage','C2','WARC003');
INSERT into Category values('DNG003','Kitchen Tools','C2','WARC001');
INSERT into Category values('DNG004','Cooking Essentials','C2','WARA003');
INSERT into Category values('STN001','Office Supplies','C3','WARA002');
INSERT into Category values('STN002','Notebooks, Writing Pads & Diaries','C3','WARA003');
INSERT into Category values('STN003','Art & Craft Supplies','C3','WARB001');
INSERT into Category values('STN004','Pens, Pencils & Writing Supplies','C3','WARC001');

INSERT into InvoiceDetails values('AAA001','CTM00001','5000.223','2017-04-01','PAY001','EMP2001');
INSERT into InvoiceDetails values('AAA002','CTM00013','455000.11','2017-04-01','PAY002','EMP2003');
INSERT into InvoiceDetails values('AAA003','CTM00024','9865.22','2017-04-01','PAY003','EMP2004');
INSERT into InvoiceDetails values('AAB001','CTM00037','8000.25','2015-03-05','PAY004','EMP2002');
INSERT into InvoiceDetails values('AAB002','CTM00044','56666.22','2014-03-05','PAY001','EMP2005');
INSERT into InvoiceDetails values('AAH001','CTM00016','7889.42','2014-02-15','PAY002','EMP2006');
INSERT into InvoiceDetails values('AAC001','CTM00031','9999.88','2017-02-15','PAY003','EMP2005');
INSERT into InvoiceDetails values('AAC002','CTM00016','7852.88','2017-02-15','PAY003','EMP2005');
INSERT into InvoiceDetails values('AAD001','CTM00034','400.88','2017-01-15','PAY001','EMP2002');
INSERT into InvoiceDetails values('AAD002','CTM00044','52224.88','2017-01-15','PAY002','EMP2001');
INSERT into InvoiceDetails values('AAD003','CTM00040','6655.88','2017-01-15','PAY003','EMP2004');
INSERT into InvoiceDetails values('AAE001','CTM00044','488.88','2016-12-30','PAY001','EMP2003');
INSERT into InvoiceDetails values('AAE002','CTM00039','300.88','2016-12-30','PAY004','EMP2002');
INSERT into InvoiceDetails values('AAF001','CTM00041','400.88','2015-01-15','PAY003','EMP2002');
INSERT into InvoiceDetails values('AAF002','CTM00022','52224.88','2015-01-15','PAY002','EMP2001');
INSERT into InvoiceDetails values('AAG003','CTM00041','6655.88','2016-01-15','PAY003','EMP2004');
INSERT into InvoiceDetails values('AAG001','CTM00031','488.88','2016-03-30','PAY001','EMP2003');
INSERT into InvoiceDetails values('AAG002','CTM00024','3000.88','2016-04-30','PAY004','EMP2002');

INSERT into InvoiceDetails values('AAI001','CTM00001','6000.223','2017-05-01','PAY001','EMP2001');
INSERT into InvoiceDetails values('AAI002','CTM00007','495000.11','2017-04-29','PAY002','EMP2003');
INSERT into InvoiceDetails values('AAJ003','CTM00003','19865.22','2017-04-12','PAY003','EMP2004');
INSERT into InvoiceDetails values('AAJ001','CTM00005','800.25','2015-02-05','PAY004','EMP2002');
INSERT into InvoiceDetails values('AAJ002','CTM00007','5666.22','2014-07-07','PAY001','EMP2005');
INSERT into InvoiceDetails values('AAK001','CTM00015','78289.42','2014-02-12','PAY002','EMP2006');
INSERT into InvoiceDetails values('AAK002','CTM00006','999.88','2016-06-15','PAY003','EMP2005');
INSERT into InvoiceDetails values('AAK003','CTM00013','4000.88','2017-01-15','PAY001','EMP2006');
INSERT into InvoiceDetails values('AAL002','CTM00011','23224.88','2016-02-15','PAY002','EMP2001');
INSERT into InvoiceDetails values('AAL003','CTM00011','6655.88','2017-01-12','PAY003','EMP2004');
INSERT into InvoiceDetails values('AAM001','CTM00012','4880.88','2016-11-30','PAY001','EMP2001');
INSERT into InvoiceDetails values('AAM002','CTM00019','300.88','2016-11-30','PAY004','EMP2002');
INSERT into InvoiceDetails values('AAN001','CTM00008','40030.88','2015-07-15','PAY003','EMP2002');
INSERT into InvoiceDetails values('AAN002','CTM00002','5222.88','2014-01-15','PAY002','EMP2001');
INSERT into InvoiceDetails values('AAN003','CTM00014','66555.88','2016-01-15','PAY003','EMP2004');
INSERT into InvoiceDetails values('AAP001','CTM00013','4880.88','2015-04-30','PAY001','EMP2003');
INSERT into InvoiceDetails values('AAP002','CTM00002','300.88','2016-04-28','PAY004','EMP2002');






INSERT into Product values('PI10001','Apple','CASCADIAN FARM','270','1kg','300','GRO001','OFF10','500','300');
INSERT into Product values('PI10002','Banana','HARVEST FARM','36','1kg','40','GRO001','OFF10','200','100');
INSERT into Product values('PI10003','Orange','365 ORGANIC','180','1kg','200','GRO001','OFF10','300','200');
INSERT into Product values('PI10004','Brinjal','MARKET SIDE','36','1kg','40','GRO001','OFF10','100','50');
INSERT into Product values('PI10005','Potato','MARKET SIDE','18','1kg','20','GRO001','OFF10','100','50');
    
    
INSERT into Product values('PI10011','turmeric','EVEREST','45','0.05kg','50','GRO002','OFF10','100','200');
INSERT into Product values('PI10012','chilli powder','EVEREST','36','0.05kg','40','GRO002','OFF10','100','200');
INSERT into Product values('PI10013','Salt','TATA','18','1 kg','20','GRO002','OFF10','200','100');
INSERT into Product values('PI10014','Chicken Masala','EVEREST','36','0.1kg','40','GRO002','OFF10','100','150');
    
INSERT into Product values('PI10021','walnut','sunsweet','450','0.25kg','500','GRO003','OFF10','100','200');
INSERT into Product values('PI10022','cashew','Tulsi','360','0.25kg','400','GRO003','OFF10','100','200');
INSERT into Product values('PI10023','apricot','delicious','180','0.5kg','200','GRO003','OFF10','200','100');
INSERT into Product values('PI10024','coconut','balaji','36','0.25kg','40','GRO003','OFF10','100','150');


INSERT into Product values('PI10031','rice','India Gate','90','1kg','100','GRO004','OFF10','200','300');
INSERT into Product values('PI10032','brown rice','fabindia','72','1kg','80','GRO004','OFF10','300','200');
INSERT into Product values('PI10033','wheat','aashirwad','27','1kg','30','GRO004','OFF10','400','200');
INSERT into Product values('PI10034','Urad daal','balaji','108','1kg','120','GRO004','OFF10','300','250');

INSERT into Product values('PI10041','soyabean oil','fortune','90','1kg','100','GRO005','OFF10','100','100');
INSERT into Product values('PI10042','canola oil','saffola','135','1kg','150','GRO005','OFF10','50','100');
INSERT into Product values('PI10043','mustard oil','nature fresh','117','1kg','130','GRO005','OFF10','200','100');
INSERT into Product values('PI10044','sunflower oil','nutrela','108','1kg','120','GRO005','OFF10','100','110');

INSERT into Product values('PI10081','body soap','cinthol','36','0.05kg','40','DN001','OFF10','200','100');
INSERT into Product values('PI10082','cloth soap','rin','18','0.05kg','20','DN001','OFF10','300','100');
INSERT into Product values('PI10083','detergent','surf excel','117','0.5kg','130','DN001','OFF10','100','100');
INSERT into Product values('PI10084','floor cleaner','lizol','54','1kg','60','DN001','OFF10','70','50');

INSERT into Product values('PI10091','tea','tata','36','0.05kg','40','DN002','OFF10','200','100');
INSERT into Product values('PI10092','coffee','nescafe','126','0.05kg','140','DN002','OFF10','350','100');
INSERT into Product values('PI10093','Cappuccino','Bru','117','0.5kg','130','DN002','OFF10','100','100');
INSERT into Product values('PI10094','leaf-tea','lipton','54','0.05kg','60','DN002','OFF10','200','160');

INSERT into Product values('PI10101','perfume','adidas','360','0.15kg','400','DN003','OFF10','200','100');
INSERT into Product values('PI10102','deodrant','axe','126','0.15kg','140','DN003','OFF10','350','100');
INSERT into Product values('PI10103','room freshner','odonil','117','0.15kg','130','DN003','OFF10','100','100');

INSERT into Product values('PI10111','shirt','mufti','1260','1','1400','MF001','OFF10','200','100');
INSERT into Product values('PI10112','half sleeve','lee','1170','1','1300','MF001','OFF10','350','100');
INSERT into Product values('PI10113','t-shirt','jack and jones','1080','1','1200','MF001','OFF10','100','100');


INSERT into Product values('PI10121','jeans','mufti','1260','1','1400','MF002','OFF10','200','100');
INSERT into Product values('PI10122','trousers','lee','1170','1','1300','MF002','OFF10','350','100');
INSERT into Product values('PI10123','formal','blackberry','1080','1','1200','MF002','OFF10','100','100');

INSERT into Product values('PI10131','banyan','rupa frontline','126','1','140','MF003','OFF10','60','100');
INSERT into Product values('PI10132','underwear','jockey','225','1','250','MF003','OFF10','50','100');
INSERT into Product values('PI10133','handkerchief','blackberry','90','1','100','MF003','OFF10','50','100');
INSERT into Product values('PI10134','socks','jockey','90','1','100','MF003','OFF10','50','100');


INSERT into Product values('PI10141','full sleeve top','lee','1260','1','1400','WF001','OFF10','60','100');
INSERT into Product values('PI10142','half sleeve top','lee cooper','540','1','600','WF001','OFF10','50','100');
INSERT into Product values('PI10143','sleeveless','jockey','990','1','1100','WF001','OFF10','50','100');
INSERT into Product values('PI10144','formal','diva','990','1','1100','WF001','OFF10','50','100');


INSERT into Product values('PI10151','jeans','mufti','1260','1','1400','WF002','OFF10','200','100');
INSERT into Product values('PI10152','trousers','lee','1170','1','1300','WF002','OFF10','350','100');
INSERT into Product values('PI10153','formal','karisma','1080','1','1200','WF002','OFF10','100','100');

INSERT into Product values('PI10161','banyan','amul','126','1','140','WF004','OFF10','60','100');
INSERT into Product values('PI10162','underwear','jockey','225','1','250','WF004','OFF10','50','100');
INSERT into Product values('PI10163','handkerchief','blackberry','90','1','100','WF004','OFF10','50','100');
INSERT into Product values('PI10164','socks','jockey','90','1','100','WF004','OFF10','50','100');
INSERT into Product values('PI10165','BRA','haynes','180','1','200','WF004','OFF10','50','100');

INSERT into Product values('PI10171','top','lilliput','360','1','400','KW001','OFF10','80','100');
INSERT into Product values('PI10172','lower','champion','270','1','300','KW001','OFF10','80','100');
INSERT into Product values('PI10173','combo','lilliput','810','1','900','KW001','OFF10','80','100');

INSERT into Product values('PI10181','half jeans','lilliput','450','1','500','KW002','OFF10','60','100');
INSERT into Product values('PI10182','full jeans','kidzee','720','1','800','KW002','OFF10','70','100');
INSERT into Product values('PI10183','trouser','lilliput','810','1','900','KW002','OFF10','90','100');

INSERT into Product values('PI10191','Kurata-Payzama','Bad-boys','900','1','1000','KW003','OFF10','70','100');
INSERT into Product values('PI10192','Top-Skirt','Biba','540','1','600','KW003','OFF10','40','100');
INSERT into Product values('PI10193','Sherwani','Gkidz','720','1','800','KW003','OFF10','60','100');
INSERT into Product values('PI10194','Lehenga-choli','Biba','1350','1','1500','KW003','OFF10','90','100');

INSERT into Product values('PI10201','Sneakers','Levis','1350','1','1500','FW001','OFF10','70','100');
INSERT into Product values('PI10202','Loafers','Nike','1125','1','1500','FW001','SUMMER25','60','100');
INSERT into Product values('PI10203','Casual Shoes','Reebok','1800','1','2000','FW001','OFF10','50','100');
INSERT into Product values('PI10204','Formal Shoes','Columbus','2700','1','3000','FW001','OFF10','90','100');
INSERT into Product values('PI10205','Flip-flops','Puma','225','1','300','FW001','SUMMER25','30','100');
INSERT into Product values('PI10206','Floaters','Adidas','900','1','1200','FW001','SUMMER25','40','100');

INSERT into Product values('PI10211','Wedges','Lavie','3150','1','3500','FW002','OFF10','70','100');
INSERT into Product values('PI10212','Heels','Catwalk','2250','1','2500','FW002','OFF10','90','100');
INSERT into Product values('PI10213','Casual Shoes','Reebok','1620','1','1800','FW002','OFF10','50','100');
INSERT into Product values('PI10214','Ballerians','Bata','1350','1','1500','FW002','OFF10','80','100');
INSERT into Product values('PI10215','Flip-flops','Action','150','1','200','FW002','SUMMER25','30','100');
INSERT into Product values('PI10216','Floaters','Sparx','900','1','1200','FW002','SUMMER25','40','100');

INSERT into Product values('PI10221','Sandals','Puma','720','1','800','FW003','OFF10','70','100');
INSERT into Product values('PI10222','Shoes','Action-campus','900','1','1000','FW003','OFF10','90','100');
INSERT into Product values('PI10223','Flip-flops','Bata','180','1','200','FW003','OFF10','50','100');

INSERT into Product values('PI10301','Digital','Fastrack','4250','1','5000','CLK001','KHUSIWALIDIWALI','80','100');
INSERT into Product values('PI10302','Analogue','Sonata','2550','1','3000','CLK001','RANGBHARIHOLI','70','100');
INSERT into Product values('PI10303','Analogue','HMT','1350','1','1500','CLK001','OFF10','80','100');
INSERT into Product values('PI10304','Analogue','Titan','3400','1','4000','CLK001','KHUSIWALIDIWALI','60','100');
INSERT into Product values('PI10305','Digital','Timex','1500','1','2000','CLK001','SUMMER25','50','100');

INSERT into Product values('PI10311','Digital','Reebok','2250','1','2500','CLK002','OFF10','90','100');
INSERT into Product values('PI10312','Analogue','Maxima','1800','1','2000','CLK002','OFF10','50','100');
INSERT into Product values('PI10313','Analogue','Titan','3750','1','5000','CLK002','SUMMER25','80','100');
INSERT into Product values('PI10314','Analogue','Sonata','1530','1','1800','CLK002','KHUSIWALIDIWALI','30','100');

INSERT into Product values('PI10321','Digital','Zoop','1080','1','1200','CLK003','OFF10','90','100');
INSERT into Product values('PI10322','Analogue','Sonata','950','1','1000','CLK003','SUMMER5','50','100');
INSERT into Product values('PI10323','Digital','Fastrack','1350','1','1500','CLK003','OFF10','80','100');

INSERT into Product values('PI10601','Highlighter','Faber-castle','45','1','50','STN001','OFF10','90','100');
INSERT into Product values('PI10602','Stapler','Kangaroo','95','1','100','STN001','WINTER5','50','100');
INSERT into Product values('PI10603','Pen-stand','GAC','190','1','200','STN001','WINTER5','80','100');
INSERT into Product values('PI10604','A4-paper','JK-Copier','570','1','600','STN001','SUMMER5','30','100');

INSERT into Product values('PI10611','Long-Book','Camlin','90','1','100','STN002','OFF10','20','100');
INSERT into Product values('PI10612','Notebook','Classmate','45','1','50','STN002','OFF10','50','100');
INSERT into Product values('PI10613','Writing-board','FfUuNn','108','1','120','STN002','OFF10','70','100');
INSERT into Product values('PI10614','Scrapbook','Navneet','57','1','60','STN002','WINTER5','80','100');

INSERT into Product values('PI10621','Wax crayons','Camlin','18','1','20','STN003','OFF10','20','100');
INSERT into Product values('PI10622','Fevicol','Pidilite','180','1','200','STN003','OFF10','50','100');
INSERT into Product values('PI10623','Poster-colors','Camel','135','1','150','STN003','OFF10','70','100');
INSERT into Product values('PI10624','Paper-cutter','Faber-castle','57','1','60','STN003','WINTER5','80','100');

INSERT into Product values('PI10631','Gel-pen','Cello','90','10','100','STN004','OFF10','20','100');
INSERT into Product values('PI10632','Ballpoint-pen','Flair','45','1','50','STN004','OFF10','50','100');
INSERT into Product values('PI10633','Pencils','FfUuNn','45','1','50','STN004','OFF10','70','100');
INSERT into Product values('PI10634','Eraser','Navneet','45','1','50','STN004','OFF10','80','100');



INSERT into Product values('PI10401','Android phone','samsung','14450','1','15000','ELC001','KHUSIWALIDIWALI','20','20');
INSERT into Product values('PI10404','Android phone','samsung','4450','1','5000','ELC001','KHUSIWALIDIWALI','20','20');
INSERT into Product values('PI10402','windows','microsoft','7720','1','8000','ELC001','KHUSIWALIDIWALI','20','10');
INSERT into Product values('PI10403','IPHONE','apple','38810','1','40000','ELC001','KHUSIWALIDIWALI','10','05');

INSERT into Product values('PI10411','Android tablet','MI','12550','1','13000','ELC002','KHUSIWALIDIWALI','20','20');
INSERT into Product values('PI10412','Android tablet','micromax','6450','1','7000','ELC002','KHUSIWALIDIWALI','20','20');
INSERT into Product values('PI10414','windows','microsoft','9720','1','10000','ELC002','KHUSIWALIDIWALI','20','10');
INSERT into Product values('PI10413','ipad','apple','48810','1','50000','ELC002','KHUSIWALIDIWALI','10','05');

INSERT into Product values('PI10421','windows based','Acer','42550','1','43000','ELC003','KHUSIWALIDIWALI','20','20');
INSERT into Product values('PI10422','windows based','Dell','36450','1','37000','ELC003','KHUSIWALIDIWALI','20','20');
INSERT into Product values('PI10424','windows based','lenovo','29720','1','30000','ELC003','KHUSIWALIDIWALI','20','10');
INSERT into Product values('PI10423','macbook','apple','47810','1','50000','ELC003','KHUSIWALIDIWALI','10','05');


INSERT into Product values('PI10431','40 inch','sony','32550','1','33100','ELC004','KHUSIWALIDIWALI','20','20');
INSERT into Product values('PI10432','32 inch','panasonic','26450','1','27200','ELC004','KHUSIWALIDIWALI','20','20');
INSERT into Product values('PI10434','premium tv','vu','39720','1','45000','ELC004','KHUSIWALIDIWALI','20','10');
INSERT into Product values('PI10433','32 inch','samsung','38810','1','42300','ELC004','KHUSIWALIDIWALI','10','05');

INSERT into Product values('PI10441','home theatre','sony','22550','1','23100','ELC005','KHUSIWALIDIWALI','20','20');
INSERT into Product values('PI10442','bluetooth speaker','philips','1450','1','1300','ELC005','KHUSIWALIDIWALI','20','20');
INSERT into Product values('PI10444','soundbars','philips','19720','1','21000','ELC005','KHUSIWALIDIWALI','20','10');
INSERT into Product values('PI10443','ipods','apple','18810','1','19300','ELC005','KHUSIWALIDIWALI','10','05');

INSERT into Product values('PI10501','cutlery','uberlyfe','550','1','600','DNG001','KHUSIWALIDIWALI','200','200');
INSERT into Product values('PI10502','glasses','godskitchen','450','1','500','DNG001','KHUSIWALIDIWALI','200','120');
INSERT into Product values('PI10503','dishware','planet','720','1','800','DNG001','KHUSIWALIDIWALI','200','100');
INSERT into Product values('PI10504','trays','woogor','310','1','400','DNG001','KHUSIWALIDIWALI','100','305');

INSERT into Product values('PI10511','Jars & Containers ','cello','750','1','800','DNG002','KHUSIWALIDIWALI','120','52');
INSERT into Product values('PI10512','lunch boxes','blossoms','250','1','300','DNG002','KHUSIWALIDIWALI','120','20');
INSERT into Product values('PI10513','kitchen racks','generic','1020','1','1100','DNG002','KHUSIWALIDIWALI','220','110');
INSERT into Product values('PI10514','produce storage bags','bagathon india','610','1','700','DNG002','KHUSIWALIDIWALI','100','105');

INSERT into Product values('PI10521','juicer','bajaj','1750','1','1850','DNG003','KHUSIWALIDIWALI','30','12');
INSERT into Product values('PI10522','grinder','maharaj','2250','1','2350','DNG003','KHUSIWALIDIWALI','20','10');
INSERT into Product values('PI10523','vegetable cutter','prestige','1120','1','1200','DNG003','KHUSIWALIDIWALI','40','10');
INSERT into Product values('PI10524','fruit chooper','ganesh','610','1','700','DNG003','KHUSIWALIDIWALI','40','15');


INSERT into Product values('PI10531','cooking induction','prystine','1450','1','1550','DNG004','KHUSIWALIDIWALI','30','12');
INSERT into Product values('PI10532','presssure cooker','prestige','1250','1','1350','DNG004','KHUSIWALIDIWALI','20','10');
INSERT into Product values('PI10533','cooking pots','king','420','1','500','DNG004','KHUSIWALIDIWALI','40','10');
INSERT into Product values('PI10534','casserole set','pristine','1010','1','1100','DNG004','KHUSIWALIDIWALI','40','15');



INSERT into Buys values('PI10531','AAA001','1','1550');
INSERT into Buys values('PI10511','AAA001','1','800');
INSERT into Buys values('PI10602','AAA001','1','100');

INSERT into Buys values('PI10441','AAA002','1','2310');
INSERT into Buys values('PI10522','AAA002','1','2350');
INSERT into Buys values('PI10532','AAA002','1','1350');
INSERT into Buys values('PI10432','AAA002','1','27200');


INSERT into Buys values('PI10441','AAA003','2','2310');
INSERT into Buys values('PI10522','AAA003','2','2350');
INSERT into Buys values('PI10444','AAA003','1','21000');
INSERT into Buys values('PI10431','AAA003','1','33100');

INSERT into Buys values('PI10511','AAB002','4','800');
INSERT into Buys values('PI10533','AAB002','3','500');
INSERT into Buys values('PI10532','AAB002','1','1350');
INSERT into Buys values('PI10432','AAB002','1','27200');


INSERT into Buys values('PI10313','AAB001','1','5000');
INSERT into Buys values('PI10203','AAB001','1','2000');
INSERT into Buys values('PI10121','AAB001','1','1400');
INSERT into Buys values('PI10433','AAB001','1','42300');

INSERT into Buys values('PI10532','AAH001','2','1350');
INSERT into Buys values('PI10533','AAH001','2','500');
INSERT into Buys values('PI10101','AAH001','2','400');

INSERT into Buys values('PI10041','AAC002','5','100');
INSERT into Buys values('PI10534','AAC002','2','1100');
INSERT into Buys values('PI10304','AAC002','2','4000');

INSERT into Buys values('PI10111','AAD002','2','1400');
INSERT into Buys values('PI10534','AAD002','2','1100');
INSERT into Buys values('PI10304','AAD002','2','4000');

INSERT into Buys values('PI10112','AAD001','2','1300');
INSERT into Buys values('PI10534','AAD001','1','1100');
INSERT into Buys values('PI10301','AAD001','1','5000');

INSERT into Buys values('PI10511','AAD003','2','800');
INSERT into Buys values('PI10441','AAD003','2','2310');
INSERT into Buys values('PI10304','AAD003','2','4000');

INSERT into Buys values('PI10121','AAE002','2','1400');
INSERT into Buys values('PI10122','AAE002','2','1300');
INSERT into Buys values('PI10304','AAE002','2','4000');

INSERT into Buys values('PI10411','AAE001','1','13000');
INSERT into Buys values('PI10442','AAE001','1','1450');
INSERT into Buys values('PI10301','AAE001','1','5000');

INSERT into Buys values('PI10121','AAF002','1','1400');
INSERT into Buys values('PI10122','AAF002','1','1300');
INSERT into Buys values('PI10304','AAF002','1','4000');
INSERT into Buys values('PI10421','AAF001','1','43000');
INSERT into Buys values('PI10442','AAF001','1','1450');
INSERT into Buys values('PI10301','AAF001','1','5000');
INSERT into Buys values('PI10121','AAG002','1','1400');
INSERT into Buys values('PI10442','AAG001','1','1450');
INSERT into Buys values('PI10301','AAG001','1','5000');

INSERT into ReturnSlip values('SL001','AAB001','PI10203','1','2015-03-06');
INSERT into ReturnSlip values('SL002','AAD001','PI10112','1','2017-01-05');
INSERT into ReturnSlip values('SL003','AAC001','PI10041','2','2014-02-20');
INSERT into ReturnSlip values('SL004','AAH001','PI10532','1','2016-04-01');
INSERT into ReturnSlip values('SL005','AAD002','PI10112','1','2015-01-18');



INSERT into Feedback values('RV001','Pears shop is expire','2','2016-05-03','CTM00002','AAG002');
INSERT into Feedback values('RV002','Quality is not good','3','2015-01-15','CTM00013','AAF002');
INSERT into Feedback values('RV003','vegitable is bad','2','2014-02-15','CTM00011','AAH001');
INSERT into Feedback values('RV004','Sony speakers is fake','1','2017-02-15','CTM00014','AAC002');

