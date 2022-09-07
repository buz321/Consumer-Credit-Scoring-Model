libname User 'M:\CRM';

/*import the file*/
proc import datafile = "M:\CRM\final_dataset.csv" dbms = csv out = crm;
run;

/*explore the content of the file*/
proc contents data = crm order = varnum;
run;
/*explore categorical characteristics*/
proc freq data = crm;
tables home_ownership/ plots = freqplot (type = barchart);
run;

/*associate with performance flag*/
proc freq data = crm;
tables home_ownership * flagbinary / chisq nocol nopercent;
tables verification_status * flagbinary / chisq nocol nopercent;
run;


/*creat new coarse-classified variables*/
data crm_coarse;
set crm;
if home_ownership = 'MORTGAGE' then ho = 0;
if home_ownership = 'OWN' then ho = 1;
if home_ownership = 'RENT' then ho = 2;
if home_ownership = 'OTHER' then ho = 3;
if verification_status = 'Source Verified' then vs = 0;
if verification_status = 'Verified' then vs = 1;
if verification_status = 'Not Verified' then vs = 2;

run;

proc freq data = crm_coarse;
tables ho * flagbinary / chisq nocol nopercent;
tables vs * flagbinary / chisq nocol nopercent;
run;

data crm_coarse;
set crm_coarse;
if ho = 2 then ho1 = 1;
if ho = 3 then ho1 = 1;
if ho = 0 then ho1 = 0;
if ho = 1 then ho1 = 0;
run;

data crm_coarse;
set crm_coarse;
if vs = 2 then vs1 = 1;
else vs1 = 0;
run;

proc freq data = crm_coarse;
tables ho1 * flagbinary / chisq nocol nopercent;
tables vs1 * flagbinary / chisq nocol nopercent;
run;

/*weights of evidence*/
data crm_coarse;
set crm_coarse;
if ho1 = 1 then
howoe = log( (66051 * 22737) /(11188 * 118893) );
if ho1 = 0 then
howoe = log( (52842 * 22737) / (11549 * 118893) );
run;
data crm_coarse;
set crm_coarse;
if vs1 = 1 then
vswoe = log( (37165 * 22737) /(5254 * 118893) );
if vs1 = 0 then
vswoe = log( (81728 * 22737) / (17483 * 118893) );
run;
proc freq data = crm_coarse;
tables howoe / plots = none ;
tables vswoe / plots = none ;
run;



/*----------------------(numeric variables)-------------------------*/

/*exploring the data*/
proc contents data = crm_coarse; run;


proc univariate data = crm_coarse; var loan_amnt; histogram;
run;

proc rank data= crm_coarse out=ranks groups=10 ties=low;
var loan_amnt;
ranks loanbinned;
run;

proc means min max; var loan_amnt; class loanbinned; 
run;

proc freq;tables loanbinned * flagbinary / nocol nopercent;
run;


/*creating new coarse-classofoed variable*/
data loancoarse;
set ranks;
if (loanbinned = 0 or loanbinned = 1) then loangroup = 0; 
if loanbinned=2 then loangroup = 2;
if loanbinned= 3 then loangroup = 3;
if loanbinned =4 then loangroup = 4;
if(loanbinned = 5 or loanbinned = 6) then loangroup = 5;
if loanbinned =7 then loangroup = 7;
if loanbinned =8 then loangroup = 8;
if loanbinned = 9 then loangroup = 9;
run;

proc freq;tables loangroup * flagbinary / nocol nopercent;
run;

proc freq;
table loangroup loanbinned;
run;


/*term*/
proc rank data= crm_coarse out=ranks groups=10 ties=low;
var term;
ranks termbinned;
run;

proc means min max; var term; class termbinned; 
run;

proc freq;tables termbinned * flagbinary / nocol nopercent;
run;


data termcoarse;
set ranks;
if (loanbinned = 0 or loanbinned = 1) then loangroup = 0; 
if loanbinned=2 then loangroup = 2;
if loanbinned= 3 then loangroup = 3;
if loanbinned =4 then loangroup = 4;
if(loanbinned = 5 or loanbinned = 6) then loangroup = 5;
if loanbinned =7 then loangroup = 7;
if loanbinned =8 then loangroup = 8;
if loanbinned = 9 then loangroup = 9;
run;

proc freq;tables loangroup * flagbinary / nocol nopercent;
run;

/*int_rate*/
proc rank data= crm_coarse out=intranks groups=10 ties=low;
var int_rate;
ranks intbinned;
run;

proc means min max; var int_rate; class intbinned; 
run;

proc freq;tables intbinned * flagbinary / nocol nopercent;
run;

/*dti*/
proc rank data= crm_coarse out=ranks groups=10 ties=low;
var dti;
ranks dtibinned;
run;

proc means min max; var dti; class dtibinned; 
run;

proc freq;tables dtibinned * flagbinary / nocol nopercent;
run;


data dticoarse;
set ranks;
if (dtibinned = 0 or dtibinned = 1) then dtigroup = 0; 
if dtibinned=2 then dtigroup = 2;
if dtibinned= 3 then dtigroup = 3;
if dtibinned =4 then dtigroup = 4;
if dtibinned =5 then dtigroup = 5;
if dtibinned =6 then dtigroup = 6;
if dtibinned =7 then dtigroup = 7;
if dtibinned =8 then dtigroup = 8;
if dtibinned = 9 then dtigroup = 9;
run;

proc freq;tables dtigroup * flagbinary / nocol nopercent;
run;

/*earliest_cr_line*/
proc rank data= crm_coarse out=ranks groups=10 ties=low;
var earliest_cr_line;
ranks earlycrlinebinned;
run;

proc means min max; var earliest_cr_line; class earlycrlinebinned; 
run;

proc freq;tables earlycrlinebinned * flagbinary / nocol nopercent;
run;


data earliestcoarse;
set ranks;
if (earlycrlinebinned = 0 or earlycrlinebinned = 1) then earlycrlinegroup = 0; 
if earlycrlinebinned=2 then earlycrlinegroup = 2;
if earlycrlinebinned= 3 then earlycrlinegroup = 3;
if earlycrlinebinned =4 then earlycrlinegroup = 4;
if earlycrlinebinned =5 then earlycrlinegroup = 5;
if (earlycrlinebinned = 6 or earlycrlinebinned = 7) then earlycrlinegroup = 6; 
if (earlycrlinebinned = 8 or earlycrlinebinned = 9) then earlycrlinegroup = 8; 
run;

proc freq;tables earlycrlinegroup * flagbinary / nocol nopercent;
run;

/*avr_cur_bal*/
proc rank data= crm_coarse out=ranks groups=10 ties=low;
var avg_cur_bal;
ranks avgcurbalebinned;
run;

proc means min max; var avg_cur_bal; class avgcurbalebinned; 
run;

proc freq;tables avgcurbalebinned * flagbinary / nocol nopercent;
run;


data curbalcoarse;
set ranks;
if (avgcurbalebinned = 0 or avgcurbalebinned = 1) then avgcurbalgroup = 0; 
if (avgcurbalebinned = 2 or avgcurbalebinned = 3) then avgcurbalgroup = 2; 
if avgcurbalebinned =4 then avgcurbalgroup = 4;
if avgcurbalebinned =5 then avgcurbalgroup = 5;
if avgcurbalebinned =6 then avgcurbalgroup = 6;
if avgcurbalebinned =7 then avgcurbalgroup = 7;
if avgcurbalebinned =8 then avgcurbalgroup = 8;
if avgcurbalebinned =9 then avgcurbalgroup = 9;
run;

proc freq;tables avgcurbalgroup * flagbinary / nocol nopercent;
run;

/*mo_sin_rcnt_ti*/
proc rank data= crm_coarse out=ranks groups=10 ties=low;
var mo_sin_rcnt_tl;
ranks mosinrcnttlbinned;
run;

proc means min max; var mo_sin_rcnt_tl; class mosinrcnttlbinned; 
run;

proc freq;tables mosinrcnttlbinned * flagbinary / nocol nopercent;
run;


data mosincoarse;
set ranks;
if mosinrcnttlbinned <= 5 then mosinrcnttlgroup = mosinrcnttlbinned;
if (mosinrcnttlbinned = 6 or mosinrcnttlbinned = 7) then mosinrcnttlgroup = 6; 
if mosinrcnttlbinned >= 8 then mosinrcnttlgroup = mosinrcnttlbinned;
run;

proc freq;tables mosinrcnttlgroup * flagbinary / nocol nopercent;
run;

/*mort_acc*/
proc rank data= crm_coarse out=ranks groups=10 ties=low;
var mort_acc;
ranks mortaccbinned;
run;

proc means min max; var mort_acc; class mortaccbinned; 
run;

proc freq;tables mortaccbinned * flagbinary / nocol nopercent;
run;


data mortcoarse;
set ranks;
if mortaccbinned <= 5 then mortacclgroup = mortaccbinned;
if (mortaccbinned = 6 or mortaccbinned = 7) then mortacclgroup = 6; 
if mortaccbinned >= 8 then mortacclgroup = mortaccbinned;
run;

proc freq;tables mortacclgroup * flagbinary / nocol nopercent;
run;

/*mths_since_recent_inq*/
proc rank data= crm_coarse out=inqranks groups=10 ties=low;
var mths_since_recent_inq;
ranks mthssincerecentinqbinned;
run;

proc means min max; var mths_since_recent_inq; class mthssincerecentinqbinned; 
run;

proc freq;tables mthssincerecentinqbinned * flagbinary / nocol nopercent;
run;

/*num_actv_rev_tl*/
proc rank data= crm_coarse out=tlranks groups=10 ties=low;
var num_actv_rev_tl;
ranks numactvrevtlbinned;
run;

proc means min max; var num_actv_rev_tl; class numactvrevtlbinned; 
run;

proc freq;tables numactvrevtlbinned * flagbinary / nocol nopercent;
run;

/*num_tl_op_past_12m*/
proc rank data= crm_coarse out=numtlranks groups=10 ties=low;
var num_tl_op_past_12m;
ranks numtloppast12mbinned;
run;

proc means min max; var num_tl_op_past_12m; class numtloppast12mbinned; 
run;

proc freq;tables numtloppast12mbinned * flagbinary / nocol nopercent;
run;

/*percent_bc_gt_75*/
proc rank data= crm_coarse out=ranks groups=10 ties=low;
var percent_bc_gt_75;
ranks percentbcgt75binned;
run;

proc means min max; var percent_bc_gt_75; class percentbcgt75binned; 
run;

proc freq;tables percentbcgt75binned * flagbinary / nocol nopercent;
run;

data percentcoarse;
set ranks;
if percentbcgt75binned <= 4 then percentbcgt75group = percentbcgt75binned;
if (percentbcgt75binned = 5 or percentbcgt75binned = 6) then percentbcgt75group = 5; 
if percentbcgt75binned >= 7 then percentbcgt75group = percentbcgt75binned;
run;
proc freq;tables percentbcgt75group * flagbinary / nocol nopercent;
run;

/*total_bc_limit*/
proc rank data= crm_coarse out=totalranks groups=10 ties=low;
var total_bc_limit;
ranks totalbclimitbinned;
run;

proc means min max; var total_bc_limit; class totalbclimitbinned; 
run;

proc freq;tables totalbclimitbinned * flagbinary / nocol nopercent;
run;

/*log_annual_inc*/
proc rank data= crm_coarse out=ranks groups=10 ties=low;
var log_annual_inc;
ranks logannualincbinned;
run;

proc means min max; var log_annual_inc; class logannualincbinned; 
run;

proc freq;tables logannualincbinned * flagbinary / nocol nopercent;
run;

data logcoarse;
set ranks;
if logannualincbinned <= 0 then logannualincgroup = logannualincbinned;
if (logannualincbinned = 1 or logannualincbinned = 2) then logannualincgroup = 1; 
if logannualincbinned >= 3 then logannualincgroup = logannualincbinned;
run;
proc freq;tables logannualincgroup * flagbinary / nocol nopercent;
run;

/*fico_score*/
proc rank data= crm_coarse out=ranks groups=10 ties=low;
var fico_score;
ranks ficoscorebinned;
run;

proc means min max; var fico_score; class ficoscorebinned; 
run;

proc freq;tables ficoscorebinned * flagbinary / nocol nopercent;
run;

data ficocoarse;
set ranks;
if ficoscorebinned <= 1 then ficoscoregroup = ficoscorebinned;
if (ficoscorebinned = 2 or ficoscorebinned = 3) then ficoscoregroup = 2; 
if ficoscorebinned >= 4 then ficoscoregroup = ficoscorebinned;
run;
proc freq;tables ficoscoregroup * flagbinary / nocol nopercent;
run;

  DATA three;
MERGE 

termcoarse
loancoarse
intranks
dticoarse
earliestcoarse
curbalcoarse
mosincoarse
mortcoarse
inqranks
tlranks
numtlranks
percentcoarse
totalranks
logcoarse
ficocoarse
;
run;
   
  PROC PRINT DATA=three; 
  RUN;

/*-----------------------running logistic regression on dummy variables------------------------*/
proc logistic data=three outmodel=est_all;
class ho1 vs1 loangroup dtigroup earlycrlinegroup avgcurbalgroup mosinrcnttlgroup mortacclgroup percentbcgt75group logannualincgroup ficoscoregroup / param=ref ref=last;
model flagbinary (descending) =ho1 vs1 loangroup dtigroup earlycrlinegroup avgcurbalgroup mosinrcnttlgroup mortacclgroup percentbcgt75group logannualincgroup ficoscoregroup / rsq;
score data=three out=sco_all;
roc;
run;

proc export data=sco_all
    outfile="M:\CRM\wow.xlsx"
    dbms=xlsx;
run;
