	/*==============================================================================*
Title: Regressions 
Author: Christian Carrillo
Date create: July 22, 2018
last edited: July 22, 2018
===============================================================================*/
clear 
cap log close 
cap log open 
set more off
log using trial1

use "/Users/christiancarrillo/Documents/Thesis(2)/Data(2).dta"


global xlist female married elementary some_highschool highschool some_college ///
college black hispanic other insured low_income medium_income age25_29 age30_34 age35_39 ///
age40_44 age45_49 age50_54 age55_59 age60_64 suburban urban 

*==============================================================================*
* See CPIadjustment.do 
gen CPI16_ratio = CPI/2.230
gen cpi_adjusted_price = gasoline_price*CPI16_ratio 
gen log_cpi_price = ln(cpi_adjusted_price) 


/* CPI values were obtaine from https://data.bls.gov/pdq/SurveyOutputServlet
prices are adjusted to 2016 us dollars. */

*==============================================================================*

*==============================================================================*
*				   			SUMMARY STATISTICS
*==============================================================================*
* DEMOGRAPHICS:
sum $xlist
sum tax_cents gasoline_price log_price $lag_prices $lag_logs cpi_adjusted_price
* OUTCOME VARIABLES
sum exercise smoker alcohol_week alcohol_month drank_alcohol current_asthma 
*==============================================================================*

*==============================================================================*
*								Smoking
*==============================================================================*

xi:reg smoker log_cpi_price $xlist i._state i.year, cluster (_state) 
xi:reg smoker log_cpi_price $xlist i._state i.month, cluster (_state) 

xi:reg smoker cpi_adjusted_price $xlist i._state i.year, cluster (_state) 

*==============================================================================*
*								Drinking
*==============================================================================*

xi:reg alcohol_month log_cpi_price $xlist i._state i.year, cluster (_state) 
xi:reg alcohol_month log_cpi_price $xlist i._state i.month, cluster (_state) 

xi:reg alcohol_month cpi_adjusted_price $xlist i._state i.year, cluster (_state) 



*==============================================================================*
*								Asthma
*==============================================================================*
xi:reg current_asthma log_cpi_price $xlist i._state i.year, cluster (_state) 
xi:reg current_asthma log_cpi_price $xlist i._state i.month, cluster (_state) 

xi:reg current_asthma cpi_adjusted_price $xlist i._state i.year, cluster (_state) 


preserve 

keep if _state == 13 | _state == 22 | _state == 28 | _state == 42 | _state == 47  

* limitations due to asthma
*==============================================================================*
recode asactlim (888 = 0 ) 
recode asactlim (777 = .) 
recode asactlim (999 = .)  

global sub_state dummy_state22 dummy_state28 dummy_state42 dummy_state47


xi:reg asactlim log_cpi_price $xlist i._state i.year , cluster(_state) 
xi:reg asactlim log_cpi_price $xlist i._state i.month , cluster(_state) 

xi:reg asactlim cpi_adjusted_price $xlist i._state i.year , cluster(_state) 

*==============================================================================*
* Asthma attack
* Had episode of asthma or asthma attack during past 12 months 
*==============================================================================*
recode asattack (7 = .) 
recode asattack (9 = .) 

xi:reg asattack log_cpi_price $xlist i._state i.year , cluster(_state) 
xi:reg asattack log_cpi_price $xlist i._state i.month , cluster(_state) 

xi:reg asattack cpi_adjusted_price $xlist i._state i.year , cluster(_state) 


*==============================================================================*
* Emergency visits due to asthma 
*==============================================================================*

recode aservist (88 = 0) 
recode aservist (98 =.)
recode aservist (99=.)

xi:reg aservist log_cpi_price $xlist i._state i.year , cluster(_state) 
xi:reg aservist log_cpi_price $xlist i._state i.month , cluster(_state) 

xi:reg aservist cpi_adjusted_price $xlist i._state i.year , cluster(_state) 

*==============================================================================*
* 	Asthma Symptoms 
*==============================================================================*

recode asymptom (7 = .) 
recode asymptom (9 = .) 
recode asymptom (8 = 0) 
label define asymptom1 0"Never" 1"less than once a week" 2"once or twice a week" ///
3"more than 2 times/week not every day" 4"everyday, not all time" 5"every day, all the time" 
label values asymptom asymptom1

gen symptoms_low = 0 
replace symptoms_low = 1 if asymptom == 1 
replace symptoms_low = . if asymptom == . 

gen symptoms_occasionally = 0 
replace symptoms_occasionally = 1 if asymptom == 2 & 3 
replace symptoms_occasionally = . if asymptom == .  

gen symptoms_severe = 0 
replace symptoms_severe = 1 if asymptom == 4 & 5 
replace symptoms_severe = . if asymptom == .

xi:reg symptoms_low log_cpi_price $xlist i._state i.year, cluster(_state) 
xi:reg symptoms_low log_cpi_price $xlist i._state i.month, cluster(_state) 

xi:reg symptoms_low cpi_adjusted_price $xlist i._state i.year, cluster(_state) 


xi:reg symptoms_occasionally log_cpi_price $xlist i._state i.month, cluster(_state) 
xi:reg symptoms_occasionally log_cpi_price $xlist i._state i.year, cluster(_state) 

xi:reg symptoms_occasionally cpi_adjusted_price $xlist i._state i.year, cluster(_state) 



xi:reg symptoms_severe log_cpi_price $xlist i._state i.year, cluster(_state) 
xi:reg symptoms_severe log_cpi_price $xlist i._state i.month, cluster(_state) 

xi:reg symptoms_severe cpi_adjusted_price $xlist i._state i.year, cluster(_state) 


restore 

cap log close 
translate reial1.smcl trial1.log




