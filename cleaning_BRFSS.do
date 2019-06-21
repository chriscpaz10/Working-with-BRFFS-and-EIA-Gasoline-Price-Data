*==============================================================================*
* Tiltle: Cleaning BRFSS-complete
* Author: Christian Carrillo 
* Date Created: 5/11/2018
* date Modified: 5/11/2018
*        CLeaning the assembled BRFFSS data
*==============================================================================*
clear 
cap log close 
set more off 

global logdir "/Users/christiancarrillo/Documents/Thesis(2)"
global datadir "/Users/christiancarrillo/Documents/Thesis(2)"
global resdir "/Users/christiancarrillo/Documents/Thesis(2)"


cd "/Users/christiancarrillo/Documents/Thesis(2)" 
use "/Users/christiancarrillo/Documents/Thesis(2)/BRFSS_Complete.dta"

gen tax_cents = tax/100 
gen gasoline_price = Gas_Price + tax_cents 
gen log_price = ln(gasoline_price)

*==============================================================================*
*									CPI Adjustment

sort year month 
mmerge year month using "CPI_prices.dta", type(n:1) 
drop _merge
gen CPI16_ratio = CPI/2.230
gen cpi_adjusted_price = gasoline_price*CPI16_ratio 
gen log_cpi_price = ln(cpi_adjusted_price) 

*==============================================================================*

drop fmonth idate imonth iday iyear dispcode _psu stateres  renthom1 ///
 usenow3 nocov121 crgvpers ///
marijana usemrjna  _ltasth1  ///
 _raceg21 _racegr3 _race_g1 _age65yr _age80 _age_g htin4 htm4 wtkg3  ///
 _bmi5cat _rfbmi5 _chldcnt _educag _incomg _smoker3  _ecigsts _curecig ///
 drocdy3_ _rfbing5 _drnkwek  _pneumo2 _drnkdrv _merge _cprace 
*==============================================================================*
* 						Demographics 
*==============================================================================*

label define sex1 1"male" 2"female" 
label values sex sex1
gen female = 0
replace female = 1 if sex == 2 
replace female = . if sex == .

label define marital1 1"married" 2"divorced" 3"widowed" 4"separated" 5"Never Married" ///
6"Unmarried Couple" 9"refused" 
label values marital marital1 
gen married = 0 
replace married = 1 if marital == 1 
replace married = . if marital == . 

label define educa1 1"Never attended" 2"Elementary" 3"some highschool" 4"high school" ///
5"some collegee" 6"College" 9"refused" 
label values educa educa1

gen no_education = 0 
replace no_education = 1 if educa == 1 
replace no_education = . if educa == . 

gen elementary = 0 
replace elementary = 1 if educa == 2 
replace elementary = . if educa == . 

gen some_highschoole = 0 
replace some_highschool = 1 if educa == 3 
replace some_highschool = . if educa == . 

gen highschool = 0 
replace highschool = 1 if educa == 4 
replace highschool = . if educa == . 

gen some_college = 0 
replace some_college = 1 if educa == 5 
replace some_college = . if educa == . 

gen college = 0 
replace college = 1 if educa == 6 
replace college = . if educa == . 

label define employ2 1"Employed for wages" 2"self-employed" 3"Out of work for 1+ years" ///
4"out of work for -1 year" 5"homemaker" 6"Student" 7"retired" 8"Unable" 9"refused" 
label values employ1 employ2 
gen employed = 0 
 replace employed = 1 if (employ1 == 1 | employ1 == 2) 
gen student = 0 
replace student =1 if employ1 == 6 


* Compute race by _hispanc and _mrace = for _race (race/ ethnicity categories) 


label define hispanc1 1"Hispanic/Latino" 2"Not Hispanic/latino" 7"Don't know" 9"refused" 
label values _hispanc hispanc1

label define _mrace1 1"White" 2"Black" 3"American Indian" 4"Asian" 5"Hawaiian/pacific" ///
6"Other" 7"Multiracial" 77"Not sure" 99"refused" 
label values _mrace _mrace1 

gen black = 0 
replace black = 1 if (_hispanc == 2 & _mrace == 2 ) 
replace black = . if _mrace == .

gen hispanic = 0
replace hispanic = 1 if _hispanc == 1 
replace hispanic =. if _hispanc ==. 

gen other_race = 0 
replace other_race = 1 if (_hispanc == 2 & _mrace == 4 | _mrace == 5 | _mrace == 6 | _mrace == 7) 
replace other_race =. if _mrace == . 

label define income3 1"less than $10,000" 2"$10 to $15" 3"$15 to $20" 4"$20 to $25" ///
5"$25 to $35" 6"$35 to $50" 7"$50 to $75" 8"75,000+" 77"not sure" 99"refused" 
label values income2 income3

gen insured = 0 
replace insured = 1 if hlthpln1 == 1 
replace insured = . if hlthpln1 == .

* Metropolitan 
* NOTE: MSA = Metroploitan Statistical Area

label define mscode1 1"Center of city of MSA" 2"outside city but in county w/MSA" ///
 3"Inside suburban county of MSA" 4"In MSA w/no center city" 5"not in MSA" 
label values mscode mscode1 
* CHeck for rural and/or Urban

gen rural = 0 
replace rural = 1 if mscode == 5
replace rural = . if mscode ==. 

gen suburban = 0
replace suburban = 1 if (mscode == 2 & 3 & 4)
replace suburban = . if mscode == .

gen urban = 0 
replace urban = 1 if mscode == 1
replace urba = . if mscode ==. 

gen low_income = 0 
replace low_income = 1 if income2 == 1 & 2 & 3 
replace low_income =. if income2 == . 

gen medium_income = 0 
replace medium_income = 1 if income2 == 4 & 5 & 6 
replace medium_income = . if income2 == . 

gen high_income = 0 
replace high_income = 1 if income2 == 7 & 8 
replace high_income = . if income2 == . 

tab low_income
tab medium_income 
tab high_income 

drop if _ageg5yr == 10 & 11 & 12 & 13 
gen age18_24 = 0
replace age18_24 = 1 if _ageg5yr == 1
replace age18_24 = . if _ageg5yr == 14

gen age25_29 = 0 
replace age25_29 = 1 if _ageg5yr == 2
replace age25_29 = . if _ageg5yr == 14

gen age30_34 =0
replace age30_34 = 1 if _ageg5yr == 3
replace age30_34 = . if _ageg5yr == 14

gen age35_39 =0
replace age35_39 = 1 if _ageg5yr == 4
replace age35_39 = . if _ageg5yr == 14

gen age40_44 =0
replace age40_44 = 1 if _ageg5yr == 5
replace age40_44 = . if _ageg5yr == 14

gen age45_49 =0
replace age45_49 = 1 if _ageg5yr == 6
replace age45_49 = . if _ageg5yr == 14

gen age50_54 =0
replace age50_54 = 1 if _ageg5yr == 7
replace age50_54 = . if _ageg5yr == 14

gen age55_59 =0
replace age55_59 = 1 if _ageg5yr == 8
replace age55_59 = . if _ageg5yr == 14

gen age60_64 =0
replace age60_64 = 1 if _ageg5yr == 9
replace age60_64 = . if _ageg5yr == 14


* CREATE CLUSTER 
gen time = 100*(2017-year)+month 
gen Time_State = time*100+ _state
* Note: I have 72 months * 48 states available 


global xlist female married elementary some_highschool highschool some_college ///
college black hispanic other insured low_income medium_income age25_29 age30_34 age35_39 ///
age40_44 age45_49 age50_54 age55_59 age60_64 suburban urban 



*==============================================================================*
* 									Lag Prices
*==============================================================================*

* See lag_price.do


preserve

keep _state month year cpi_adjusted_price log_cpi_price
duplicates drop
sort _state year month
bysort _state: gen gasoline_price_L1 = cpi_adjusted_price[_n-1]
bysort _state: gen gasoline_price_L2 = cpi_adjusted_price[_n-2]
bysort _state: gen gasoline_price_L3 = cpi_adjusted_price[_n-3]
bysort _state: gen gasoline_price_L4 = cpi_adjusted_price[_n-4]
bysort _state: gen gasoline_price_L5 = cpi_adjusted_price[_n-5]
bysort _state: gen gasoline_price_L6 = cpi_adjusted_price[_n-6]
bysort _state: gen gasoline_price_L7 = cpi_adjusted_price[_n-7]
bysort _state: gen gasoline_price_L8 = cpi_adjusted_price[_n-8]
bysort _state: gen gasoline_price_L9 = cpi_adjusted_price[_n-9]
bysort _state: gen gasoline_price_L10 = cpi_adjusted_price[_n-10]
bysort _state: gen gasoline_price_L11 = cpi_adjusted_price[_n-11]
bysort _state: gen gasoline_price_L12 = cpi_adjusted_price[_n-12]

bysort _state: gen log_price_L1 = log_cpi_price[_n-1] 
bysort _state: gen log_price_L2 = log_cpi_price[_n-2] 
bysort _state: gen log_price_L3 = log_cpi_price[_n-3] 
bysort _state: gen log_price_L4 = log_cpi_price[_n-4] 
bysort _state: gen log_price_L5 = log_cpi_price[_n-5] 
bysort _state: gen log_price_L6 = log_cpi_price[_n-6] 
bysort _state: gen log_price_L7 = log_cpi_price[_n-7] 
bysort _state: gen log_price_L8 = log_cpi_price[_n-8] 
bysort _state: gen log_price_L9 = log_cpi_price[_n-9] 
bysort _state: gen log_price_L10 = log_cpi_price[_n-10] 
bysort _state: gen log_price_L11 = log_cpi_price[_n-11] 
bysort _state: gen log_price_L12 = log_cpi_price[_n-12] 
save lag_prices.dta, replace 


restore


sort _state year month
mmerge _state year month using "lag_prices.dta", type(n:1) 

global lag_prices gasoline_price_L1 gasoline_price_L2 gasoline_price_L3 gasoline_price_L4 gasoline_price_L5 gasoline_price_L6 gasoline_price_L7 gasoline_price_L8 gasoline_price_L9 gasoline_price_L10 gasoline_price_L11 gasoline_price_L12
global lag_logs log_price_L1 log_price_L2 log_price_L3 log_price_L4 log_price_L5 log_price_L6 log_price_L7 log_price_L8 log_price_L9 log_price_L10 log_price_L11 log_price_L12
drop _merge
*==============================================================================*
* 							Self-reported health
*===============================================================================*
* General Health 
label define generalhealth 1"excellent" 2"very good" 3"good" 4"fair" 5"poor" 7"dont Know" 9"refuse" 
labe values genhlth generalhealth 

gen good_health = 0 
replace good_health = 1 if ( genhlth == 1| genhlth == 2 | genhlth == 3) 

* POOR HEALTH (physical and mental) 

/// drop observation that report don't know, refuse and missing  
* Note: The total number of observations gest significantly reduced. N=676,639 
* poor_helath = 1 is 40% of sample, recode instead 

recode poorhlth (88=0) 
recode poorhlth (77=.) 
recode poorhlth (99=.)  

* PHYSICAL HEALTH 

recode physhlth (88=0)
recode physhlth (77=.)
recode physhlth (99=.) 

gen exercise = 0 
replace exercise = 1 if exerany2 == 1 
replace exercise = . if exerany2 == . 
*==============================================================================*
* 								Smoking & Drinking 
*==============================================================================*
* create a variable dor smokers: everyday / someday 

label define smokday3 1"Everyday" 2"some days" 3"Not at all" 7"don't know" 9"refused" 
label values smokday2 smokday3

label define smoke200 1"yes" 2"no" 7"don't know" 9"refused" 
label values smoke100 smoke200 

gen smoker = 0 
replace smoker = 1 if (smokday2 == 1 & 2)
replace smoker = . if (smokday2 == 7 & 9) 
replace smoker = . if smokday2 == . 
*not accounting for smoke100 anymore 
/* During the past 30 days, how many days per week or per month did you have at 
least one drink of any alcoholic beverage such as beer, wine a malt beverage or 
liquor? 
101-107 Days per week 
201-230 days per month
777 don't know 
888 no drinks 
999 refused / blank */


tab alcday5 year
drop if alcday5 == 110
drop if alcday5 == 114
drop if alcday5 == 115
drop if alcday5 == 130 
drop if alcday5 == 232
drop if alcday5 == 250 
drop if alcday5 == 260 
recode alcday5 (888=0) 
recode alcday5 (777=.)
recode alcday5 (999=.) 

gen alcohol_week = 0 
replace alcohol_week = 1 if alcday5 == 101 
replace alcohol_week = 2 if alcday5 == 102 
replace alcohol_week = 3 if alcday5 == 103 
replace alcohol_week = 4 if alcday5 == 104 
replace alcohol_week = 5 if alcday5 == 105 
replace alcohol_week = 6 if alcday5 == 106 
replace alcohol_week = 7 if alcday5 == 107 

gen alcohol_month = alcday5 if alcday5 >= 201
replace alcohol_month = 0 if alcday5 == 0 
replace alcohol_month = . if alcday5 == .
tab alcohol_month year, miss 

gen drank_alcohol = 0
replace drank_alcohol = 1 if alcohol_month >= 201
replace drank_alcohol = . if alcohol_month == . 
tab drank_alcohol, miss
*==============================================================================*
* 									Asthma
*==============================================================================*
* Do you still have asthma? 

gen current_asthma = 0
replace current_asthma = 1 if asthnow == 1
replace current_asthma = . if asthnow == .

/*	gen calculated_asthma = 0 
replace calculated_asthma = 1 if(asthma3 == 1 | asthnow == 1 ) 
replace calculated_asthma = . if (asthma3 == . | asthnow == .)
*/
recode  casthdx2 (7=.)
recode  casthdx2 (9=.)
tab casthdx2 year, miss

recode casthno2 (7=.)
recode casthno2 (9=.)
tab casthno2 year, miss
*==============================================================================*


*==============================================================================*
*				   				SUMMARY STATISTICS
*==============================================================================*
* DEMOGRAPHICS:
sum $xlist
sum tax_cents gasoline_price log_price $lag_prices $lag_logs
* OUTCOME VARIABLES
sum poorhlth physhlth exercise smoker alcohol_week alcohol_month drank_alcohol current_asthma 

save "Data(3).dta", replace 

/*==============================================================================*
* 						REGRESSIONS: Smoking and Drinking 
*==============================================================================* 

reg smoker log_price $xlist $dummy_states $dummy_years, cluster (_state) 
reg smoker log_price $xlist $dummy_states $dummy_months, cluster (_state)

reg smoker gasoline_price $xlist $dummy_states $dummy_years, cluster (_state) 
reg smoker gasoline_price $xlist $dummy_states $dummy_months, cluster (_state)  

* alcohol_month: # of days per month that individual had at least one alcoholic drink


reg alcohol_month log_price $xlist $dummy_states $dummy_years, cluster(_state) 
reg alcohol_month log_price $xlist $dummy_states $dummy_months, cluster(_state) 

reg alcohol_month gasoline_price $xlist $dummy_states $dummy_years, cluster(_state) 
reg alcohol_month gasoline_price $xlist $dummy_states $dummy_months, cluster(_state) 

reg drank_alcohol log_price $xlist $dummy_states $dummy_years, cluster(_state) 
reg drank_alcohol log_price $xlist $dummy_states $dummy_months, cluster(_state)

reg drank_alcohol gasoline_price $xlist $dummy_states $dummy_years, cluster(_state) 
reg drank_alcohol gasoline_price $xlist $dummy_states $dummy_months, cluster(_state) 

*==============================================================================*
*							REGRESSIONS: ASTHMA
*==============================================================================*
reg current_asthma log_price $xlist $dummy_states $dummy_years, cluster(_state) 
reg current_asthma log_price $xlist $dummy_states $dummy_months, cluster(_state) 

reg current_asthma gasoline_price $xlist $dummy_states $dummy_years, cluster(_state) 
reg current_asthma gasoline_price $xlist $dummy_states $dummy_months, cluster(_state) 

*==============================================================================*
* 						REGRESSION: Self-Reported Health 
*==============================================================================*

reg physhlth log_price $xlist $dummy_states $dummy_years, cluster(_state) 
reg physhlth log_price $xlist $dummy_states $dummy_months, cluster(_state) 



* poor health 

reg poorhlth log_price $xlist $dummy_states $dummy_years, cluster(_state) 
reg poorhlth log_price $xlist $dummy_states $dummy_months, cluster(_state) 

*==============================================================================*
*					REGRESSIONS: EXERCISE
*==============================================================================*

reg exercise log_price $xlist $dummy_states $dummy_years, cluster(_state) 
reg exercise log_price $xlist $dummy_states $dummy_months, cluster(_state)

reg exercise gasoline_price $xlist $dummy_states $dummy_years, cluster(_state) 
reg exercise gasoline_price $xlist $dummy_states $dummy_months, cluster(_state)




log close
translate logpdf.smcl logpdf.pdf, replace


fsor
