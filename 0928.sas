DATA SALES ;
        INFILE 'C:\Users\user\Desktop\SAS\DATA\MyRawData\OnionRing.dat';
        INPUT VISITINGTEAM $ 1-20 CONCESSIONSALES 21-24 BLEACHERSALES 25-28
                OURHITS 29-31 THEIRHITS 32-34 OURRUNS 35-37 THEIRRUNS 38-40;
        RUN ;

PROC PRINT DATA = SALES;
        TITLE 'SAS DATA SET SALES' ;
RUN ;

DATA CONTEST ;
        INFILE 'C:\Users\user\Desktop\SAS\DATA\MyRawData\Pumpkin.dat';
        INPUT NAME $16 AGE 3.+1 TYPE $1.+1 DATE MMDDYY10.
                (SCORE1 SCORE2 SCORE3 SCORE4 SCORE5)(4.1);
RUN;

PROC PRINT DATA = CONTEST;
        TITLE 'CONYEST' ;
RUN;


DATA CH2 ;
        INPUT ID4.+1 NAME $15.+4 TEAM $6.+1 S_WEIGHT E_WEIGHT ;
        DATALINE;
                1023 David Shaw         red    189 165
                1049 Amelia Serrano     yellow 145 124
                1219 Alan Nance         red    210 192
                1246 Ravi Sinha         yellow 194 177
                1078 Ashley McKnight    red    127 118
                1221 Jim Brown          yellow 220
         ;
RUN;
PROC PRINT DATA = CH2;
        TITLE 'CH2' ;
RUN;

DATA CH2_1 ;
        INPUT SSN $11.+1 HIREDATE DATE7.+1 SALARY COMMA6.+1 DEPARTMENT $9.+1 PHONE 4.+1;
        DATALINES;
209-20-3721 07JAN78 41,983 SALES     2896
223-96-8933 03MAY86 27,356 EDUCATION 2344
232-18-3485 17AUG81 33,167 MARKETING 2674
251-25-9392 08SEP84 34,033 RESEARCH  2956
;
RUN ;
PROC PRINT DATA = CH2_1 ;
        TITLE 'CH2_1'   ;
RUN ;
