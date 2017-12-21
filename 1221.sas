DATA _NULL_;
INFILE "C:\Users\user\Desktop\SAS\DATA\MyRawData\CandySales.dat";
INPUT NAME $ 1-11 CLASS @15 DATARETURN MMDDYY10. CANDYTYPE $ QUANTITY;
PROFIT = QUANTITY * 1.25;
FILE "C:\Users\user\Desktop\SAS\STUDENT.rep";
TITLE;
PUT @5 "Candy sales report for " NAME "from classroom" CLASS
// @5 "Congratulations! You sold " QUANTITY "boxes of candy"
/ @5 "and earned " PROFIT DOLLAR6.2 "for our field trip";
PUT _PAGE_;
RUN;

PROC FORMAT;
 VALUE GENDER 1 = "MALE"
 2 = "FEMALE";
DATA _NULL_;
INFILE  "C:\Users\user\Desktop\SAS\DATA\MyRawData\Cars.dat";
INPUT AGE SEX INCOME TMP $;
FILE "C:\Users\user\Desktop\SAS\CARS.rep";
TITLE;
IF SEX = 1 THEN
PUT @5 "Observe " _N_ "IS " SEX: GENDER.+(-1)"."
/ @5 "HIS AGE IS " AGE "AND HIS INCOME IS " INCOME DOLLAR7.".";
ELSE
PUT  @5 "Observe " _N_ "IS " SEX: GENDER.+(-1)"."
/ @5 "HER AGE IS " AGE "AND HER INCOME IS " INCOME DOLLAR7.".";
PUT _PAGE_;
RUN;

DATA SALES;
INFILE "C:\Users\user\Desktop\SAS\DATA\MyRawData\Flowers.dat";
INPUT CUSTID $ @9 SALESDATE MMDDYY10. PETUNIA SNAPDRAGON MARIGOLD;
Month = MONTH(SALESDATE);
PROC SORT DATA = SALES;
BY Month;
PROC MEANS DATA = SALES MAXDEC = 0;
BY Month;
VAR PETUNIA SNAPDRAGON MARIGOLD;
TITLE "MONTH";
RUN;
