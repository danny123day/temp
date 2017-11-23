DATA TEST;
 INFILE "C:\Users\user\Desktop\SAS\DATA\MyRawData\KBRK.dat";
 INPUT CITY $ 1-15 @ 19 WJ KT TR FILP TTR;
 SUMSCORE = SUM(OF WJ-NUMERIC-TTR);
 MEANSCORE = MEAN(OF WJ-NUMERIC-TTR);
RUN;
PROC PRINT DATA = TEST;
 TITLE "KBRK";
RUN;

DATA GARDEN;
 INFILE "C:\Users\user\Desktop\SAS\DATA\MyRawData\Garden.dat";
 INPUT NAME $ 1-6 A B C D;
RUN;
PROC PRINT DATA = GARDEN;
 WHERE NAME BETWEEN "Molly" AND "Susan";
RUN;

DATA CLASS;
 INPUT NAME $ 1-11 GENDER $  AGE;
 DATALINES;
Joyce      F      11
Thomas     M      11
Jane       F      12
Louise     F      12
James      M      12
John       M      12
Robert     M      12
Alice      F      13
Barbara    F      13
Jeffery    M      13
Carol      F      14
Judy       F      14
Alfred     M      14
Henry      M      14
Jenet      F      15
Mary       F      15
Ronald     M      15
William    M      15
Philip     M      16
;
RUN;
PROC PRINT DATA = CLASS;
 WHERE NAME CONTAIN "ar";
RUN;

PROC PRINT DATA = Sashelp.Company;
 WHERE LEVEL4 IN ("SALES","FINANCE","MARKETING");
RUN;
