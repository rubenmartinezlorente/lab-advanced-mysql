use publications;

#####################################  			CHALLENGE 1				##################################################################################


########################################################################################################################


###STEP1
##from TITLES folder --> title_id, advance, price, royalty 
#from TITLEAUTHOR --> au_id, royaltyper
#from Sales --> qty

SELECT  titles.title_id as TITLE,
titleauthor.au_id as TITLE_AUTHOR,
advance * royaltyper/100 as ADVANCE,  
price * qty * royalty / 100 * royaltyper / 100 as sales_royalty
from titles 
join titleauthor on titleauthor.title_id = titles.title_id
join sales on sales.title_id = titles.title_id
order by sales_royalty DESC
;

########################################################################################################################


###STEP2

SELECT 
TITLE,
TITLE_AUTHOR,
ADVANCE,
SUM(sales_royalty + ADVANCE) as AGG_ROYALTIES

from (

		SELECT
		titles.title_id as TITLE,
		titleauthor.au_id as TITLE_AUTHOR,
		advance * royaltyper/100 as ADVANCE,  
		price * qty * royalty / 100 * royaltyper / 100 as sales_royalty
		from titles 
		join titleauthor on titleauthor.title_id = titles.title_id
		join sales on sales.title_id = titles.title_id
		order by sales_royalty DESC

) as STEP1

group by TITLE, TITLE_AUTHOR, ADVANCE
;


########################################################################################################################

##STEP3


SELECT 
TITLE,
TITLE_AUTHOR,
SUM(ADVANCE + AGG_ROYALTIES) AS FINAL_RESULT

FROM
(

		SELECT 
		TITLE,
		TITLE_AUTHOR,
		ADVANCE,
		SUM(sales_royalty + ADVANCE) as AGG_ROYALTIES

				from (

				SELECT
				titles.title_id as TITLE,
				titleauthor.au_id as TITLE_AUTHOR,
				advance * royaltyper/100 as ADVANCE,  
				price * qty * royalty / 100 * royaltyper / 100 as sales_royalty
				from titles 
				join titleauthor on titleauthor.title_id = titles.title_id
				join sales on sales.title_id = titles.title_id
				order by sales_royalty DESC

				) as STEP1
				
				
		group by TITLE, TITLE_AUTHOR, ADVANCE
		
) as STEP2

group by TITLE, TITLE_AUTHOR
order by FINAL_RESULT DESC
LIMIT 3
;


#####################################  			CHALLENGE 2			##################################################################################

use publications;



###STEP1
##from TITLES folder --> title_id, advance, price, royalty 
#from TITLEAUTHOR --> au_id, royaltyper
#from Sales --> qty
CREATE TEMPORARY TABLE PRUEBA1

SELECT  titles.title_id as TITLE,
titleauthor.au_id as TITLE_AUTHOR,
advance * royaltyper/100 as ADVANCE,  
price * qty * royalty / 100 * royaltyper / 100 as sales_royalty
from titles 
join titleauthor on titleauthor.title_id = titles.title_id
join sales on sales.title_id = titles.title_id
-- order by sales_royalty DESC
;

DROP TEMPORARY TABLE PRUEBA2 
;


CREATE TEMPORARY TABLE PRUEBA2

SELECT 
TITLE,
TITLE_AUTHOR,
ADVANCE,
SUM(sales_royalty + ADVANCE) as AGG_ROYALTIES

from PRUEBA1

group by TITLE, TITLE_AUTHOR, ADVANCE
;



##STEP3


SELECT 
TITLE,
TITLE_AUTHOR,
SUM(ADVANCE + AGG_ROYALTIES) AS FINAL_RESULT

FROM prueba2 

group by TITLE, TITLE_AUTHOR
order by FINAL_RESULT DESC
LIMIT 3;

#####################################  			CHALLENGE 3			##################################################################################

DROP table  most_profing_authors;


#####creation table 
create table  most_profing_authors
(
TITLE_AUTHOR varchar(11),
AGG_ROYALTIES varchar(40)
)
;





#######insert values
insert into most_profing_authors
(TITLE_AUTHOR, AGG_ROYALTIES)
values
('722-51-5454', '33771.528000000000'),
('213-46-8915', '20275.116000000000'),
('238-95-7766', '14110.160000000000')
;
