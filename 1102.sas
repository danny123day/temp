DATA OLDCARS;
 INFILE "C:\Users\user\Desktop\SAS\DATA\MyRawData\Auction.dat";
 INPUT MAKE $ 1-13 MODEL $ 15-29 YEAR SEED MILLION ;
 IF YEAR < 1890 THEN V = "YES";
 IF MODEL = "F-88" THEN DO ;
 MAKE = "OLDMOBILE";
 SEED = 2;
 END;
RUN;
PROC PRINT DATA = OLDCARS;
 TITLE  "CARS";
RUN ;

DATA HOME;
 INFILE "C:\Users\user\Desktop\SAS\DATA\MyRawData\Home.dat";
 INPUT NAME $ 1-7 DESCRIPTION $ 9-33 COST;
 IF COST = . THEN COSTGROUP = "MISSING";
 ELSE IF COST < 2000 THEN COSTGROUP = "LOW";
 ELSE IF COST < 10000 THEN COSTGROUP = "MEDIAN";
 ELSE COSTGROUP = "HIGH";
RUN;
PROC PRINT DATA = HOME;
 TITLE "HOME";
RUN;

DATA EX4;
INPUT NAME $ 1-16 NB1 NB2 NB3 NB4 NB5 NB6 STATUS $;
LENGTH ACTION $ 7;
IF STATUS = "PASSED" THEN ACTION = "NONE";
ELSE IF STATUS IN( "INCOMP" , "FAILED")  THEN ACTION = "CONTACT";
DATALINES;
 ALEXANDER SMITH 78 82 86 69 97 80 PASSED
 JOHN SIMON      88 72 86 . 100 85 INCOMP
 PATRICIA JONES  98 92 92 99 99 93 PASSED
 JACK BENEDICT   54 63 71 49 82 69 FAILED
 RENE PORTER     100 62 88 74 98 92 PASSED
END ;
RUN;
PROC PRINT DATA = EX4;
 TITLE "EX4";
 VAR NAME STATUS ACTION;
RUN;

DATA _NULL_;
 SDATE = "16OCT1998"D;
 EDATE = "16FEB2010"D;
 Y_AGE = YRDIF(SDATE,EDATE,"AGE");
 YACTACT = YRDIF(SDATE,EDATE,"ACT/ACT");
 YACT360 = YRDIF(SDATE,EDATE,"ACT/360");
 YACT365 = YRDIF(SDATE,EDATE,"ACT/365");
 PUT Y_AGE=/YACTACT=/YACT360=/YACT365=/"DATEDIFF";
RUN;

DATA TST;
 FORMAT W $CHAR3.
  Y 10.3
  DEFAULT = 8.2 $CHAR8;
 W = "GOOD MORNING";
 X = 12.1;
 Y = 13.2;
 Z = "HOWDY-DOODY";
 PUT W/X/Y/Z;
RUN;
PROC CONTENTS DATA = TST;
RUN;
PROC PRINT DATA = TST;
RUN;

DATA DOLLARS;
 LENGTH VAL1 8 VAL2 8 VAL3 8 VAL4 8;
 FORMAT VAL1 DOLLAR8. VAL2 DOLLAR8.2 VAL3 DOLLAR4.2 VAL4 DOLLAR10.2;
 VAL1 = 12345.67;
 VAL2 = 12345.67;
 VAL3 = 12345.67;
 VAL4 = 12345.67;
RUN;

PROC PRINT DATA = DOLLARS;
RUN;
